//
//  MECDevicesDetailViewController.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDevicesDetailViewController.h"
#import "MECDevicesBluetoothTableViewCell.h"

#import "MECDefaultButton.h"
#import "MECNoDeviceFoundViewController.h"


#import <CoreBluetooth/CoreBluetooth.h>
#import "MECSetTemperatureViewController.h"



#define kServiceUUID @"0000ffb0-0000-1000-8000-00805f9b34fb"
#define kCharacteristicUUID @"0000ffb1-0000-1000-8000-00805f9b34fb"


#define kHeadViewHeight kWidth6(40)
#define kBottomViewHeight kWidth6(76)

@interface MECDevicesDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,CBPeripheralDelegate>

/// 顶部提示
@property (nonatomic, strong) UILabel *tipsLabel;
/// 列表tableview
@property (nonatomic ,strong) UITableView *tableView;

/// 底部视图
@property (nonatomic, strong) UIView *bottomView;

/// 底部文案
@property (nonatomic, strong) UILabel *bottomTipsLabel;
/// try按钮
@property (nonatomic, strong) MECDefaultButton *tryBtn;


///中央设备
@property (nonatomic, strong) CBCentralManager *centralManager;
///蓝牙连接失败状态
//@property (nonatomic, assign) BluetoothFailState bluetoothFailState;
///蓝牙扫描状态
@property (nonatomic, assign) BluetoothState bluetoothState;
///周边设备
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;
///周边设备服务特性
@property (nonatomic, strong) CBCharacteristic *characteristic;

/// 搜索蓝牙列表数据
@property (nonatomic, strong) NSMutableArray *searchBluDataMuArr;
/// 配对蓝牙列表数据
@property (nonatomic, strong) NSMutableArray *matchBluDataMuArr;


/// 当前选中cell row
@property (nonatomic, assign) NSInteger currentRow;
/// 当前选中连接状态
@property (nonatomic, assign) BOOL currentSelectStatus;


@end

@implementation MECDevicesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [self configUI];
    
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomTipsLabel];
    [self.bottomView addSubview:self.tryBtn];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(30));
        make.centerX.equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(15));
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kBottomViewHeight);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-(kIsIphoneX?kWidth6(34):0));
        make.height.mas_equalTo(kBottomViewHeight);
    }];
    [self.bottomTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.bottomView).offset(kWidth6(10));
        make.height.mas_equalTo(kWidth6(15));
    }];
    [self.tryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView);
        make.height.mas_equalTo(kWidth6(34));
        make.width.mas_equalTo(kWidth6(120));
        make.top.equalTo(self.bottomTipsLabel.mas_bottom).offset(kWidth6(10));
    }];
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.matchBluDataMuArr.count;
    }else{
        return self.searchBluDataMuArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth6(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        if (self.matchBluDataMuArr.count > 0) {
            return kHeadViewHeight;
        }else{
            return 0.01;
        }
    }else{
        if (self.searchBluDataMuArr.count > 0) {
            return kHeadViewHeight;
        }else{
            return 0.01;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewHeight)];
    headerView.backgroundColor = kColorHex(0xDCDCDC);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, kScreenWidth - kMargin * 2, kHeadViewHeight)];
    label.text = @"AVAILABLE DEVICES";
    if (0 == section) {
        label.text = @"SELECTED DEVICE";
    }
    label.font = MEC_Helvetica_Regular_Font(14);
    label.textColor = kColorHex(0x727171);
    [headerView addSubview:label];
    if (0 == section ) {
        if (self.matchBluDataMuArr.count > 0) {
            return headerView;
        }else{
            return [UIView new];
        }
    }else{
        if (self.searchBluDataMuArr.count > 0) {
            return headerView;
        }else{
            return [UIView new];
        }
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MECDevicesBluetoothTableViewCell *cell = [MECDevicesBluetoothTableViewCell cellWithTableView:tableView];
    CBPeripheral *per;
    if (0 == indexPath.section) {
        per = (CBPeripheral *)self.matchBluDataMuArr[indexPath.row];
    }else{
        per = (CBPeripheral *)self.searchBluDataMuArr[indexPath.row];
    }
    
    NSString *bleName = per.name;
    cell.deviceNameStr = bleName;
    cell.contentView.backgroundColor = kColorHex(0xffffff);
    if (0 == indexPath.section) {
        if (self.currentRow == indexPath.row) {
            cell.isStop = !(BluetoothStateConnecting == self.bluetoothState);
            if (PositionTypeFootLeft == self.positionType) {
                cell.positionStr = @"Left";
            }else if (PositionTypeFootRight == self.positionType){
                cell.positionStr = @"Right";
            }else if (PositionTypeFootTop == self.positionType){
                cell.positionStr = @"Top";
            }else if (PositionTypeFootBottom == self.positionType){
                cell.positionStr = @"Bottom";
            }else if (PositionTypeFootHeatingPad == self.positionType){
                cell.positionStr = @"Heating Pad";
            }else{
                cell.positionStr = @"";
            }
        }
    }else{
        cell.isStop = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // get a reference to the cell that the user tapped
//    MECDevicesBluetoothTableViewCell *cell = (MECDevicesBluetoothTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ( 0 == indexPath.section) {
        //跳转到温度设置页面
        MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
        [self.navigationController pushViewController:vc  animated:YES];
    }else{
        CBPeripheral *peripheral=(CBPeripheral *)self.searchBluDataMuArr[indexPath.row];
        //设定周边设备，指定代理者
        self.discoveredPeripheral = peripheral;
        self.discoveredPeripheral.delegate = self;
        //连接设备
        [self.centralManager connectPeripheral:peripheral
                                       options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
        // 开始匹配中
        self.bluetoothState = BluetoothStateConnecting;
        // 搜索列表移除 配对列表加入，并更新列表
        [self.searchBluDataMuArr removeObject:peripheral];
        [self.matchBluDataMuArr addObject:peripheral];
        self.currentRow = self.matchBluDataMuArr.count - 1;
        [self.tableView reloadData];
        
    }
   
}

#pragma mark -
#pragma mark -- tryBtnAction
- (void)tryBtnAction:(UIButton *)button{
    MECNoDeviceFoundViewController *vc = [[MECNoDeviceFoundViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [MBProgressHUD showError:@"Connection fail"];
}


#pragma mark - 检测蓝牙状态
#pragma mark -- centralManagerDidUpdateState
/**
 *  --  初始化成功自动调用
 *  --  必须实现的代理，用来返回创建的centralManager的状态。
 *  --  注意：必须确认当前是CBCentralManagerStatePoweredOn状态才可以调用扫描外设的方法：
 scanForPeripheralsWithServices
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStateUnknown:
            break;
        case CBManagerStateResetting:
            break;
        case CBManagerStateUnsupported:
            [MBProgressHUD showError:@"The current mobile phone is not supported, please replace it"];
            break;
        case CBManagerStateUnauthorized:
            [self alertMessageController];
            break;
        case CBManagerStatePoweredOff:
             [self alertMessageController];
            break;
        case CBManagerStatePoweredOn:
        {
           
            // 开始扫描周围的外设。
            /*
             -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
             -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
             -- 成功扫描到外设后调用didDiscoverPeripheral
             */
//            [self.centralManager scanForPeripheralsWithServices:nil options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@NO}];
            [self startScan];
        }
            break;
        default:
            break;
    }
}

-(void)startScan{
    //判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备  你可以
    //指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
    //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
    //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    //记录目前是扫描状态
    self.bluetoothState = BluetoothStateScaning;
    //清空所有外设数组
    [self.searchBluDataMuArr removeAllObjects];
 
}
#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral == nil||peripheral.identifier == nil)
    {
        return;
    }
//    NSString *pername = [NSString stringWithFormat:@"%@",peripheral.name];
//    //判断是否存在@"你的设备名"
//    NSRange range = [pername rangeOfString:@"你的设备名"];
    //如果从搜索到的设备中找到指定设备名，和searchBluDataMuArr数组没有它的地址
    //加入数组
//    if(range.location != NSNotFound && [self.searchBluDataMuArr containsObject:peripheral] == NO){
//        [self.searchBluDataMuArr addObject:peripheral];
//    }
    if([self.searchBluDataMuArr containsObject:peripheral] == NO && peripheral.name != nil){
        [self.searchBluDataMuArr addObject:peripheral];
    }
    
    self.bluetoothState  = BluetoothStateScanSuccess;
    [self.tableView reloadData];

}
#pragma mark - 连接到外围设备
#pragma mark --
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
    //设置外围设备的代理为当前视图控制器
    peripheral.delegate = self;
    //外围设备开始寻找服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    NSString *uuid = [NSString stringWithFormat:@"%@",peripheral.identifier];
    NSString *type = [NSString stringWithFormat:@"%ld",(long)self.positionType];
    [self addDeviceRequestWithDeviceBluname:peripheral.name deviceMacname:uuid type:type];
    [self.centralManager stopScan];

    self.bluetoothState = BluetoothStateConnected;

    [self.tableView reloadData];
}
 
//连接外围设备失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接外围设备失败！");
    self.bluetoothState = BluetoothStateConnected;
    [self.tableView reloadData];
}

#pragma mark - 获取当前设备服务services
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        return;
    }
    
    NSLog(@"所有的servicesUUID%@",peripheral.services);
 
    //遍历所有service
    for (CBService *service in peripheral.services)
    {
        
        NSLog(@"服务%@",service.UUID);
        
        //找到你需要的servicesuuid
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"你的设备服务的uuid"]])
        {
            //监听它
            [peripheral discoverCharacteristics:nil forService:service];
        }
        
        
        
    }
    NSLog(@"此时链接的peripheral：%@",peripheral);
    
}

#pragma mark - 外围设备寻找到特征后
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    NSLog(@"服务：%@",service.UUID);
    // 特征
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"%@",characteristic.UUID);
        //发现特征
        //注意：uuid 分为可读，可写，要区别对待！！！
        
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"你的特征uuid"]])
        {
            NSLog(@"监听：%@",characteristic);//监听特征
            //保存characteristic特征值对象
            //以后发信息也是用这个uuid
            self.characteristic = characteristic;
            
            [_discoveredPeripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
        
        //当然，你也可以监听多个characteristic特征值对象
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"你的特征uuid"]])
        {
            //同样用一个变量保存，demo里面没有声明变量，要去声明
//            _characteristic2 = characteristic;
//            [peripheral setNotifyValue:YES forCharacteristic:_characteristic2];
//            NSLog(@"监听：%@",characteristic);//监听特征
        }
    }
}
#pragma mark - 特征值被更新后
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"收到特征更新通知...");
    if (error) {
        NSLog(@"更新通知状态时发生错误，错误信息：%@",error.localizedDescription);
    }
     
    //给特征值设置新的值
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    if ([characteristic.UUID isEqual:characteristicUUID]) {
        if (characteristic.isNotifying) {
            if (characteristic.properties == CBCharacteristicPropertyNotify) {
                NSLog(@"已订阅特征通知.");
                return;
            }else if (characteristic.properties == CBCharacteristicPropertyRead){
                 //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                [peripheral readValueForCharacteristic:characteristic];
            }
        }else{
            NSLog(@"停止已停止.");
             
            //取消连接
            [self.centralManager cancelPeripheralConnection:peripheral];
        }
    }
}

#pragma mark - 更新特征值后
#pragma mark --
//（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"更新特征值时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    if (characteristic.value) {
        NSString *value = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"读取到特征值：%@",value);
    }else{
        NSLog(@"未发现特征值.");
    }
}
#pragma mark - 写入数据
#pragma mark -- writeDataWithHexStr
- (void)writeDataWithHexStr:(NSString *)hexStr {
    NSData *data = [self convertHexStrToData:hexStr];
    [self.discoveredPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}
#pragma mark - 16进制转NSData
#pragma mark --
- (NSData *)convertHexStrToData:(NSString *)str{
    if (!str || [str length] == 0) {
        return nil;
    }
     
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
         
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
         
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}
#pragma mark - 关闭蓝牙
#pragma mark -- closeBluetooth
- (void)closeBluetooth{
    [self.centralManager stopScan];
    if (self.discoveredPeripheral) {
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
    }
    self.centralManager = nil;
    self.discoveredPeripheral = nil;
    self.characteristic = nil;
}

#pragma mark -
#pragma mark -- alertMessageController
- (void)alertMessageController{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please allow bluetooth permissions to be enabled" preferredStyle:UIAlertControllerStyleAlert];
    kWeakSelf
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *gotoAction = [UIAlertAction actionWithTitle:@"Goto" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:gotoAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -  添加设备
#pragma mark -- addDeviceRequest
- (void)addDeviceRequestWithDeviceBluname:(NSString *)dbtname deviceMacname:(NSString *)dmac type:(NSString *)type{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:dbtname ? dbtname:@"" forKey:@"dbtname"];
    [parm setObject:dmac?dmac:@"" forKey:@"dmac"];
    [parm setObject:type?type:@"" forKey:@"type"];
    kWeakSelf
    [QCNetWorkManager postRequestWithUrlPath:QCUrlAddDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
            // 添加失败移到下面列表
            [weakSelf.searchBluDataMuArr removeObject:weakSelf.discoveredPeripheral];
            [weakSelf.matchBluDataMuArr addObject:weakSelf.discoveredPeripheral];
            [weakSelf.tableView reloadData];
        }else {
            [hud showText:@"Add Success"];
            //跳转到温度设置页面
            MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc  animated:YES];
        }
    }];
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(17);
        _tipsLabel.text = @"Bluetooth";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = kColorHex(0x221815);
    }
    return _tipsLabel;
}

#pragma mark - lazy
#pragma mark - tableview
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kColorHex(0xDCDCDC);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kWidth6(40);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _tableView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kColorHex(0xffffff);
    }
    return _bottomView;
}
- (UILabel *)bottomTipsLabel{
    if (!_bottomTipsLabel) {
        _bottomTipsLabel = [[UILabel alloc] init];
        _bottomTipsLabel.font = MEC_Helvetica_Regular_Font(14);
        _bottomTipsLabel.text = @"Did not find the device to be paired.";
        _bottomTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTipsLabel.textColor = kColorHex(0x221815);
    }
    return _bottomTipsLabel;
}

- (MECDefaultButton *)tryBtn{
    if (!_tryBtn) {
        _tryBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Try Again" font:MEC_Helvetica_Regular_Font(14) target:self selector:@selector(tryBtnAction:)];
        [_tryBtn setTitleColor:kColorHex(0xC71F1E) forState:UIControlStateNormal];
    }
    return _tryBtn;
}
- (NSMutableArray *)searchBluDataMuArr{
    if (!_searchBluDataMuArr) {
        _searchBluDataMuArr = [NSMutableArray array];
    }
    return _searchBluDataMuArr;
}
- (NSMutableArray *)matchBluDataMuArr{
    if (!_matchBluDataMuArr) {
        _matchBluDataMuArr = [NSMutableArray array];
    }
    return _matchBluDataMuArr;
}


@end
