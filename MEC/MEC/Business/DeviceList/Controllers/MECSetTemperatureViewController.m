//
//  MECSetTemperatureViewController.m
//  MEC
//
//  Created by John on 2020/8/4.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECSetTemperatureViewController.h"

#import "MECTemperatureCircleAnimationView.h"
#import "MECWebViewController.h"

#import "MECNoDeviceFoundViewController.h"


#define kServiceName @"USB_521_Addheat"
#define kServiceUUID @"FFB0"
#define kWriteUUID @"0000ffb1-0000-1000-8000-00805f9b34fb"
#define kReadUUID @"0000ffb2-0000-1000-8000-00805f9b34fb"


#define kCharacteristicUUID @"0000ffb2-0000-1000-8000-00805f9b34fb"


@interface MECSetTemperatureViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,CBCentralManagerDelegate,CBPeripheralDelegate>

/// 顶部左上角图标背景视图
@property (nonatomic, strong) UIView *topIconBgView;
/// 顶部左上角图标
@property (nonatomic, strong) UIImageView *topIconImageView;
/// OFF提示
@property (nonatomic, strong) UILabel *leftTipsLabel;
/// ON提示
@property (nonatomic, strong) UILabel *rightTipsLabel;

/// 设置温度开关背景视图
@property (nonatomic ,strong) UIView *switchBgView;

/// 设置温度开关
@property (nonatomic ,strong) UISwitch *setTemperatureSwitch;

/// 底部左边提示 Left
@property (nonatomic, strong) UILabel *bottomLeftTipsLabel;
/// 底部左边图标
@property (nonatomic, strong) UIImageView *bottomLeftIconImageView;

/// 底部左边蓝牙图标
@property (nonatomic, strong) UIButton *bottomLeftBluetoothButton;

/// 底部右边提示 Right
@property (nonatomic, strong) UILabel *bottomRightTipsLabel;
/// 底部右边图标
@property (nonatomic, strong) UIImageView *bottomRightIconImageView;

/// 底部右边蓝牙图标
@property (nonatomic, strong) UIButton *bottomRightBluetoothButton;

@property (nonatomic, strong) MECTemperatureCircleAnimationView *temperatureCircleView ;

/// 部位选择器
@property (nonatomic, strong) UIPickerView *pickerView;

/// 上次位置
@property (nonatomic, assign) NSInteger lastRow;

/// 当前位置
@property (nonatomic, assign) NSInteger currentRow;

/// 部位选择器中间圆形框
@property (nonatomic, strong) UIView *middleBgView;

/// 搜索蓝牙列表数据
@property (nonatomic, strong) NSMutableArray *searchBluDataMuArr;

///中央设备
@property (nonatomic, strong) CBCentralManager *centralManager;

///蓝牙扫描状态
@property (nonatomic, assign) BluetoothState bluetoothState;

///周边设备
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

///周边设备服务特性
@property (nonatomic, strong) CBCharacteristic *characteristic;

///周边设备服务特性
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;


///周边设备2
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral2;

///周边设备服务特性2
@property (nonatomic, strong) CBCharacteristic *characteristic2;

///周边设备服务特性2
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic2;

/// 当前温度值
@property (nonatomic, assign) NSInteger currentTemperature;

/// 发送的温度值
@property (nonatomic, assign) NSInteger sendTemperature;
/// 发送的开关值
@property (nonatomic, assign) BOOL sendFlag;

/// 接受到的温度值
@property (nonatomic, assign) NSInteger receiveTemperature;

/// 接受到的开关值
@property (nonatomic, assign) BOOL receiveFlag;


/// 是否是首次
@property (nonatomic, assign) BOOL isFirst;

/// 位置数组
@property (nonatomic, strong) NSArray *positionArr;

/// 左边电量数值
@property (nonatomic, assign) NSInteger leftElectricValue;
/// 右边电量数值
@property (nonatomic, assign) NSInteger rightElectricValue;

/// 定时器
@property (nonatomic, strong) NSTimer *timer1;

/// 定时器时间 秒
@property (nonatomic, assign) NSInteger secondCount;

/// 是否是首次读取数据
@property (nonatomic, assign) BOOL isFirstReadData;


/// 是否显示链接失败
@property (nonatomic, assign) BOOL isShowConnectionError;


/// 是否显示链接失败
@property (nonatomic, assign) BOOL isad;


/// 左边设备数值
@property (nonatomic, copy) NSString *valueStr1;

/// 右边设备数值
@property (nonatomic, copy) NSString *valueStr2;


/// 上个设备数值
@property (nonatomic, copy) NSString *lastValueStr;

/// 是否切换链接
@property (nonatomic, assign) BOOL isPickerConnect;



/// 是否尝试链接
@property (nonatomic, assign) BOOL isTryConnect;


/// 上个设备mac地址
@property (nonatomic, copy) NSString *lastMacAddressStr;

/// 上个设备部位类型
@property (nonatomic, assign) PositionType lastPositionType;

/// 上个设备mac 广播名称
@property (nonatomic, copy) NSString *lastMacDbtnameStr;


/// 是否正在链接1
@property (nonatomic, assign) BOOL isShowLostMessage1;
/// 是否正在链接1
@property (nonatomic, assign) BOOL isShowLostMessage2;


@end

@implementation MECSetTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self configUI];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    NSInteger row = 0;
    if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
        row = 2;
    }else{
        
        if (PositionTypeFootTop == self.positionType) {
            row = 0;
        }else if (PositionTypeFootBottom == self.positionType){
            row = 1;
        }else if (PositionTypeFootHeatingPad == self.positionType){
            row = 3;
        }
        // 不显示底线右边模块及左边文案
        self.bottomRightIconImageView.image = [UIImage imageNamed:@"none"];
        self.bottomRightTipsLabel.text = @"";
        [self.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
        self.bottomLeftTipsLabel.text = @"";
    }
    [self updateTopIconImageView:self.positionType];
    self.currentRow = row;
    self.lastRow = self.currentRow;
    self.lastMacAddressStr = self.macAddressStr;
    self.lastMacDbtnameStr = self.dbtname;
    self.lastPositionType = self.positionType;
    [self.pickerView selectRow:row inComponent:0 animated:YES];
    
    // 记录状态
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(self.positionType) forKey:kLastPosition];
    [userDefaults synchronize];
    
}
#pragma mark - 开启定时器
#pragma mark -- startTimer
- (void)startTimer{
    self.timer1 = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(monitorCharacteristicValue) userInfo:nil repeats:YES];
    // 加入RunLoop中
    [[NSRunLoop mainRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
}

#pragma mark - 关闭定时器
#pragma mark -- invalidateTimer
- (void)invalidateTimer {
    [self.timer1 invalidate];
    self.timer1 = nil;
}
#pragma mark - 监听设备值变化
#pragma mark -- monitorCharacteristicValue
- (void)monitorCharacteristicValue{
    self.secondCount += 1;
    if (self.secondCount % 2 == 0) {
        [self checkBlueStatus];
    }
    if (self.secondCount % 1 == 0) {
        [self checkDevicePeripheralStateConnected];
    }
}

#pragma mark - 检查设备连接状态
#pragma mark -- checkDevicePeripheralStateConnected
- (void)checkDevicePeripheralStateConnected{
    NSString *leftBluIconStr;
    leftBluIconStr = CBPeripheralStateConnected == self.discoveredPeripheral.state ? @"bluetooth_icon_selected":@"bluetooth_icon_normal";
    [self.bottomLeftBluetoothButton setImage: [UIImage imageNamed:leftBluIconStr] forState:UIControlStateNormal];
    
    if (CBPeripheralStateConnected == self.discoveredPeripheral.state) {
        
    }else{
        if (CBPeripheralStateDisconnected == self.discoveredPeripheral.state && self.discoveredPeripheral) {
            if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
                if (self.isShowLostMessage1) {
                    
                }else{
                    self.isShowLostMessage1 = YES;
                    [MBProgressHUD showError:@"Left:No device found"];
                }
                 
            }else{
                if (self.isShowLostMessage1) {
                    
                }else{
                    self.isShowLostMessage1 = YES;
                    [MBProgressHUD showError:@"No device found"];
                }
                 
            }
        }
    }
    if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
        NSString *rightBluIconStr;
          rightBluIconStr = CBPeripheralStateConnected == self.discoveredPeripheral2.state ? @"bluetooth_icon_selected":@"bluetooth_icon_normal";
          [self.bottomRightBluetoothButton setImage: [UIImage imageNamed:rightBluIconStr] forState:UIControlStateNormal];
        
        if (CBPeripheralStateDisconnected == self.discoveredPeripheral2.state && self.discoveredPeripheral2) {

            if (self.isShowLostMessage2) {
                
            }else{
                self.isShowLostMessage2 = YES;
                [MBProgressHUD showError:@"Right:No device found"];
            }
        }else{
            
        }
    }else{
        [self.bottomRightBluetoothButton setImage: [UIImage imageNamed:@"none"] forState:UIControlStateNormal];
    }
    
    [self updateTopIconImageView:self.positionType];
    

}
#pragma mark -  检查蓝牙状态
#pragma mark -- checkBlueStatus
- (void)checkBlueStatus{
     switch (self.centralManager.state) {
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
                [self resetTemperatureViewControllerView];
                [self alertMessageController];
               break;
           case CBManagerStatePoweredOn:
           {
//               // 开始扫描周围的外设。
//               [self startScan];
           }
               break;
           default:
               break;
       }
}
#pragma mark - 重置页面
#pragma mark -- resetTemperatureViewControllerView
- (void)resetTemperatureViewControllerView{
    self.bluetoothState = BluetoothStateDisconnect;
    [self.bottomLeftBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
    [self.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
}
#pragma mark -  更新左上角图标
#pragma mark -- updateTopIconImageView
- (void)updateTopIconImageView:(NSInteger)position{
    NSString *imageStr;
    switch (position) {
        case 1:
        case 2:
            imageStr = @"temperatuee_foot_normal_icon";
            if (CBPeripheralStateConnected == self.discoveredPeripheral.state) {
                if (CBPeripheralStateConnected == self.discoveredPeripheral2.state) {
                    imageStr = @"temperatuee_foot_select_icon";
                }else{
                    imageStr = @"device_list_left_select_icon";
                }
            }else{
                if (CBPeripheralStateConnected == self.discoveredPeripheral2.state) {
                    imageStr = @"device_list_right_select_icon";
                }else{
                    imageStr = @"temperatuee_foot_normal_icon";
                }
            }
           
            break;
        case 3:
        {
            imageStr = CBPeripheralStateConnected == self.discoveredPeripheral.state ? @"temperature_top_select_icon":@"temperature_top_normal_icon";
        }
            
            break;
        case 4:
        {
            imageStr = CBPeripheralStateConnected == self.discoveredPeripheral.state ? @"device_list_bottom_select_icon":@"device_list_bottom_normal_icon";
        }
            break;
        case 5:
        {
            imageStr = CBPeripheralStateConnected == self.discoveredPeripheral.state ?@"device_list_heatingpad_select_icon":@"device_list_heatingpad_normal_icon";
            
        }
            break;
        default:
            break;
    }
    self.topIconImageView.image = [UIImage imageNamed:imageStr];
}
#pragma mark - 初始化数据
#pragma mark -- initDatas
- (void)initDatas{
    self.isShowConnectionError = YES;
    self.isFirst = YES;
    // 初始化的温度值
    self.currentTemperature = 10;
    self.sendFlag = NO;
    self.sendTemperature = -1;
    self.secondCount = 0;
    [self startTimer];
}

#pragma mark - 返回根视图控制器
#pragma mark -- goBackBtnAction
- (void)goBackBtnAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    // 关闭蓝牙
    [self closeBluetooth];
    
    // 手动返回则清空状态
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(-1) forKey:kLastPosition];
    [userDefaults synchronize];
}

- (void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view];
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.pickerView reloadAllComponents];
}
- (void)dealloc{
    // 关闭定时器
    [self invalidateTimer];
}
#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    
//    [self.view addSubview:self.topIconBgView];
    [self.view addSubview:self.topIconImageView];
    
    [self.view addSubview:self.setTemperatureSwitch];
    [self.view addSubview:self.leftTipsLabel];
    [self.view addSubview:self.rightTipsLabel];
    
    [self.view addSubview:self.temperatureCircleView];
    
    [self.view addSubview:self.pickerView];
    [self.pickerView addSubview:self.middleBgView];
    
    [self.view addSubview:self.bottomLeftTipsLabel];
    [self.view addSubview:self.bottomLeftIconImageView];
    [self.view addSubview:self.bottomLeftBluetoothButton];
    
    [self.view addSubview:self.bottomRightTipsLabel];
    [self.view addSubview:self.bottomRightBluetoothButton];
    [self.view addSubview:self.bottomRightIconImageView];
       
    
//    [self.topIconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view).offset(kMargin);
//        make.width.height.mas_equalTo(kWidth6(60));
//        make.top.equalTo(self.view).offset(kWidth6(6));
//    }];
    
    [self.topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(kMargin);
        make.top.equalTo(self.view).offset(kWidth6(8));
    }];
   
    [self.setTemperatureSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(56));
        make.height.mas_equalTo(kWidth6(26));
        make.width.mas_equalTo(kWidth6(50));
        make.centerX.equalTo(self.view);
    }];
    [self.leftTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.setTemperatureSwitch.mas_leading).offset(-15);
        make.centerY.equalTo(self.setTemperatureSwitch);
    }];
    [self.rightTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.setTemperatureSwitch.mas_trailing).offset(15);
        make.centerY.equalTo(self.setTemperatureSwitch);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.temperatureCircleView.mas_bottom).offset(kWidth6(2));
        make.height.mas_offset(kWidth6(70));
        make.width.mas_offset(kWidth6(100));
    }];
    [self.middleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.pickerView);
        make.trailing.leading.equalTo(self.pickerView);
        make.height.mas_offset(kWidth6(26));
    }];
    
    [self.bottomLeftIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(kMargin * 2);
        make.bottom.equalTo(self.view).offset(-kWidth6(60));
        make.height.mas_equalTo(kWidth6(20));
        make.width.mas_equalTo(kWidth6(36));
    }];
    
    [self.bottomLeftBluetoothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomLeftIconImageView.mas_trailing).offset(kWidth6(15));
        make.centerY.equalTo(self.bottomLeftIconImageView);
        make.height.with.mas_offset(kWidth6(30));
    }];
    [self.bottomLeftTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomLeftIconImageView);
        make.bottom.equalTo(self.bottomLeftIconImageView).offset(-kWidth6(24));
    }];
 
    [self.bottomRightIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-kMargin*2);
        make.centerY.height.width.equalTo(self.bottomLeftIconImageView);
    }];
    [self.bottomRightBluetoothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bottomRightIconImageView.mas_leading).offset(-kWidth6(15));
        make.centerY.equalTo(self.bottomLeftIconImageView);
        make.height.with.mas_offset(kWidth6(30));
    }];
    
    [self.bottomRightTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomRightIconImageView);
        make.bottom.equalTo(self.bottomLeftIconImageView).offset(-kWidth6(24));
    }];
    
    kWeakSelf
    self.menuViewCellTapBlock = ^(NSInteger index) {
        if ( index < 3) {
            // 关闭蓝牙
            [weakSelf closeBluetooth];
        }else{
            
        }
        if (2 == index) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MECMineViewControllerStatusNotification object:@"1"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (1 == index){
    
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else if (0 == index){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:MECMineViewControllerStatusNotification object:@"2"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            MECWebViewController *vc = [[MECWebViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
}

#pragma mark --
#pragma mark -- UIPickerViewDataSource && UIPickerViewDelegate
//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 4;
}

- (CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component {
    return kWidth6(20);
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    UILabel *label;
    if (!label) {
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, kWidth6(100), kWidth6(20));
        label.textColor = kColorHex(0x3D3A39);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = MEC_Helvetica_Bold_Font(14);
    }
    NSString *tempStr = [self.positionArr objectAtIndex:row];
    label.text = tempStr;
   
    // 去掉上下横线 pickerView 上面添加了一个背景视图，椭圆框，所以这边下标加1，正常是 3个子视图
    if (pickerView.subviews.count == 3) {
      ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
      ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    }else if (pickerView.subviews.count == 4){
        ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
        ((UIView *)[pickerView.subviews objectAtIndex:3]).backgroundColor = [UIColor clearColor];
    }
 
    return label;
}
//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.currentRow = row;
    if (2 == row) {
        if (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0 && [self checkDeviceIsExist:self.bindDeviceListInfoModel.leftDeviceModel.dmac] && [self checkDeviceIsExist:self.bindDeviceListInfoModel.rightDeviceModel.dmac]) {
            
            [self connectDeviceWithPosition:PositionTypeFootLeft];
        }else{
            [MBProgressHUD showError:@"No device found"];
            [self.pickerView selectRow:self.lastRow inComponent:0 animated:YES];
        }
    }else if (0 == row){
        if (self.bindDeviceListInfoModel.topDeviceModel.dmac.length > 0 && [self checkDeviceIsExist:self.bindDeviceListInfoModel.topDeviceModel.dmac]) {
            
             [self connectDeviceWithPosition:PositionTypeFootTop];
        }else{
            [MBProgressHUD showError:@"No device found"];
            [self.pickerView selectRow:self.lastRow inComponent:0 animated:YES];
        }
    }else if (1 == row){
        if (self.bindDeviceListInfoModel.bottomDeviceModel.dmac.length > 0 && [self checkDeviceIsExist:self.bindDeviceListInfoModel.bottomDeviceModel.dmac]) {
             
             [self connectDeviceWithPosition:PositionTypeFootBottom];
        }else{
            [MBProgressHUD showError:@"No device found"];
            [self.pickerView selectRow:self.lastRow inComponent:0 animated:YES];
        }
    }else{
        if (self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac.length > 0 && [self checkDeviceIsExist:self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac]) {
             
             [self connectDeviceWithPosition:PositionTypeFootHeatingPad];
        }else{
            [MBProgressHUD showError:@"No device found"];
            [self.pickerView selectRow:self.lastRow inComponent:0 animated:YES];
        }
    }
}

#pragma mark - 检查当前搜索设备列表是否包含之前配对的设备
#pragma mark -- checkDeviceIsExist
- (BOOL)checkDeviceIsExist:(NSString *)macStr{
   return YES;
}
- (void)connectDeviceWithPosition:(NSInteger)position{
    NSString *macStr;
    NSString *dbtnameStr;
    switch (position) {
        case 1:
            macStr = self.bindDeviceListInfoModel.leftDeviceModel.dmac;
            dbtnameStr = self.bindDeviceListInfoModel.leftDeviceModel.dbtname;
            break;
        case 2:
            macStr = self.bindDeviceListInfoModel.rightDeviceModel.dmac;
            dbtnameStr = self.bindDeviceListInfoModel.rightDeviceModel.dbtname;
            break;
        case 3:
            macStr = self.bindDeviceListInfoModel.topDeviceModel.dmac;
            dbtnameStr = self.bindDeviceListInfoModel.topDeviceModel.dbtname;
            break;
        case 4:
            macStr = self.bindDeviceListInfoModel.bottomDeviceModel.dmac;
            dbtnameStr = self.bindDeviceListInfoModel.bottomDeviceModel.dbtname;
            break;
        case 5:
            macStr = self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac;
            dbtnameStr = self.bindDeviceListInfoModel.heatingPadDeviceModel.dbtname;
            break;
        default:
            break;
    }
    self.macAddressStr = macStr;
    self.dbtname = dbtnameStr;
    self.positionType = position;
    self.isFirst = YES;
    self.lastValueStr = @"";
    self.isPickerConnect = YES;
    self.isTryConnect = NO;
   
    self.isShowLostMessage1 = NO;
    self.isShowLostMessage2 = NO;
    // 取消之前的链接
    if (self.discoveredPeripheral) {
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
        self.discoveredPeripheral = nil;
        self.characteristic = nil;
    }
    if (self.discoveredPeripheral2) {
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral2];
        self.discoveredPeripheral2 = nil;
        self.characteristic2 = nil;
    }
    
    [self startScan];

   
    /// 延迟2秒检查状态
    kWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [MBProgressHUD hideHUDForView:weakSelf.view];
        // foot
        if (PositionTypeFootLeft == weakSelf.positionType || PositionTypeFootRight == weakSelf.positionType) {
            if (weakSelf.isTryConnect) {
                // 链接成功
                if (CBPeripheralStateConnected == weakSelf.discoveredPeripheral.state || CBPeripheralStateConnected == weakSelf.discoveredPeripheral2.state ) {
                    weakSelf.lastRow = weakSelf.currentRow;
                    weakSelf.bottomLeftTipsLabel.text = @"Left";
                    weakSelf.bottomRightTipsLabel.text = @"Right";
                    return ;
                }
            }
        
        }else{
            // top、 bottom、heatingpad
            weakSelf.bottomLeftTipsLabel.text = @"";
            weakSelf.bottomRightTipsLabel.text = @"";
            weakSelf.bottomRightIconImageView.image = [UIImage imageNamed:@"none"];
            [weakSelf.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
            if (weakSelf.isTryConnect) {
                if (CBPeripheralStateConnected == weakSelf.discoveredPeripheral.state ) {
                    // 链接成功
                    weakSelf.lastRow = weakSelf.currentRow;
                    return;
                }
            }
        }
        // 尝试链接其它绑定设备失败则给出提示并切换回去 重新链接
        weakSelf.macAddressStr = weakSelf.lastMacAddressStr;
        weakSelf.dbtname = weakSelf.lastMacDbtnameStr;
        weakSelf.positionType = weakSelf.lastPositionType;
        if (PositionTypeFootLeft == weakSelf.positionType || PositionTypeFootRight == weakSelf.positionType) {
            weakSelf.bottomLeftTipsLabel.text = @"Left";
            weakSelf.bottomRightTipsLabel.text = @"Right";
            weakSelf.bottomRightIconImageView.image = [UIImage imageNamed:@"battery_icon_4"];
            [weakSelf.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
        }else{
            weakSelf.bottomLeftTipsLabel.text = @"";
            weakSelf.bottomRightTipsLabel.text = @"";
            weakSelf.bottomRightIconImageView.image = [UIImage imageNamed:@"none"];
            [weakSelf.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
        }
        [weakSelf startScan];
        [MBProgressHUD showError:@"Device Connection failed" toView:weakSelf.view];
        [weakSelf.pickerView selectRow:weakSelf.lastRow inComponent:0 animated:YES];
    });
    

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
            [self startScan];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 打开蓝牙开始扫描
#pragma mark -- startScan
- (void)startScan{
    //判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备  你可以
    //指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
    //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
    //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    //记录目前是扫描状态
    self.bluetoothState = BluetoothStateScaning;
    //清空所有外设数组
    [self.searchBluDataMuArr removeAllObjects];
 
    [MBProgressHUD showLoadingMessage:@"Connecting" toView:self.view];
    
    /// 注释
    kWeakSelf
    // 延迟3秒隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf.view];
    });
}
#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral == nil||peripheral.identifier == nil)
    {
        return;
    }

//    if([self.searchBluDataMuArr containsObject:peripheral] == NO && [peripheral.name isEqualToString:kServiceName]){
//
//        [self.searchBluDataMuArr addObject:peripheral];
//    }
    
    NSString *manufacturerDataStr = [[advertisementData objectForKey:@"kCBAdvDataManufacturerData"] description];
    if(peripheral.name.length > 0 && peripheral.name != nil && manufacturerDataStr.length > 0 && manufacturerDataStr != nil){
    
        // 英文字母转大写
        manufacturerDataStr = [manufacturerDataStr uppercaseString];
        // 替换空格
        manufacturerDataStr = [manufacturerDataStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (@available(iOS 13.0, *)) {
            // 13.0 系统及以上获取格式为： kCBAdvDataManufacturerData = {length = 6, bytes = 0x615e084d23dc};
            manufacturerDataStr = [manufacturerDataStr substringWithRange:NSMakeRange(1, manufacturerDataStr.length - 2)];
            if (manufacturerDataStr.length >= 12) {
                manufacturerDataStr = [manufacturerDataStr substringFromIndex:manufacturerDataStr.length - 12];
            }
            
        } else {
            // 13.0 系统及以下获取格式为： kCBAdvDataManufacturerData = <605e084d 23dc>;
            manufacturerDataStr = [manufacturerDataStr substringWithRange:NSMakeRange(1, manufacturerDataStr.length - 2)];
        }
        
        NSMutableString *tempMuStr = [NSMutableString stringWithString:manufacturerDataStr];
        
        // 每个2位插入冒号，和安卓统一蓝牙mac地址格式
        for(NSInteger i = tempMuStr.length - 2; i > 0; i -=2) {
            [tempMuStr insertString:@":" atIndex:i];
        }
        
        if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
            if ([tempMuStr isEqualToString:self.bindDeviceListInfoModel.leftDeviceModel.dmac]) {

                 [self connectDevicePeripheral:peripheral];
            }
            if ([tempMuStr isEqualToString:self.bindDeviceListInfoModel.rightDeviceModel.dmac]) {
                // 判断如果是之前绑定的，则自动链接
                //设定周边设备，指定代理者
                self.discoveredPeripheral2 = peripheral;
                self.discoveredPeripheral2.delegate = self;
                //连接设备
                [self.centralManager connectPeripheral:peripheral
                                               options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
            }
    
        }else{
            // top、bottom、heatingpad
            if ([tempMuStr isEqualToString:self.macAddressStr]) {
                // 取消之前的链接
                if (self.discoveredPeripheral) {
                    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
                    self.discoveredPeripheral = nil;
                    self.characteristic = nil;
                }else{
                    
                }
                [self connectDevicePeripheral:peripheral];
                // 开始匹配中
                       self.bluetoothState = BluetoothStateConnecting;
            }
        }
       
    }else{
        if (self.isShowConnectionError) {
            
        }else{
            self.isShowConnectionError = YES;
//            [self pushNODeviceVC];
        }
    }
}
#pragma mark - 链接设备
#pragma mark -- connectPeripheral
- (void)connectDevicePeripheral:(CBPeripheral *)peripheral{
    // 是否切换链接
    if (self.isPickerConnect) {
        // 是否尝试链接
        self.isTryConnect = YES;
    }else{
//        [MBProgressHUD showLoadingMessage:@"Connecting" toView:self.view];
    }
    
    //设定周边设备，指定代理者
    self.discoveredPeripheral = peripheral;
    self.discoveredPeripheral.delegate = self;
    //连接设备
    [self.centralManager connectPeripheral:peripheral
                                   options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
    
}
#pragma mark - 连接到外围设备成功回调
#pragma mark -- centralManager
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    if (self.isPickerConnect) {
        
    }else{
        
    }
   
    // 链接成功切换左上角按钮图标
    self.lastRow = self.currentRow;
    [self updateTopIconImageView:self.positionType];
    self.lastMacAddressStr = self.macAddressStr;
    self.lastMacDbtnameStr = self.dbtname;
    self.lastPositionType = self.positionType;
    self.bluetoothState = BluetoothStateConnected;
    // 停止扫描
    [self.centralManager stopScan];
    //设置外围设备的代理为当前视图控制器
    peripheral.delegate = self;
    //外围设备开始寻找服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    // 链接成功
    [self.bottomLeftBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_selected"] forState:UIControlStateNormal];
    if (self.discoveredPeripheral2 == peripheral) {
        // 右边蓝牙设备
        self.bottomRightTipsLabel.text = @"Right";
        [self.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_selected"] forState:UIControlStateNormal];
    }
    
    
    self.temperatureCircleView.deviceType = self.lastMacDbtnameStr;
    // 绑定成功记录状态
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(self.positionType) forKey:kLastPosition];
    [userDefaults synchronize];
}
//连接外围设备失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    self.bluetoothState  = BluetoothStateDisconnect;
    if (self.isPickerConnect) {
        
    }else{
        [MBProgressHUD hideHUDForView:self.view];
    }
   
    [MBProgressHUD showError:@"Device Connection failed"];
    [self updateTopIconImageView:self.positionType];
    // 链接失败
    [self.bottomLeftBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
    if (self.discoveredPeripheral2 == peripheral) {
        // 右边蓝牙设备
         self.bottomRightTipsLabel.text = @"Right";
         [self.bottomRightBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
    }
    
    // 绑定失败记录状态
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(self.positionType) forKey:kLastPosition];
    [userDefaults synchronize];
}

#pragma mark - 获取当前设备服务services
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error) {
        return;
    }

    //遍历所有service
    for (CBService *service in peripheral.services)
    {
        
        //找到你需要的servicesuuid
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]])
        {
            //监听它
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
//    NSLog(@"此时链接的peripheral：%@",peripheral);
    
}

#pragma mark - 外围设备寻找到特征后
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    if (error)
    {
//        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }

    if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
        if (self.discoveredPeripheral.identifier == service.peripheral.identifier) {
            // 特征
            for (CBCharacteristic *characteristic in service.characteristics){
                //发现特征 注意：uuid 分为可读，可写，区别对待
                // 通知
                if ((characteristic.properties & CBCharacteristicPropertyNotify) || (characteristic.properties & CBCharacteristicPropertyIndicate)) {
                    // 订阅通知监听
                    self.characteristic = characteristic;
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
                // 写入
                if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
                    // 写入
                    self.writeCharacteristic = characteristic;
                }
            }
        }
        if (self.discoveredPeripheral2.identifier == service.peripheral.identifier) {
            // 特征
            for (CBCharacteristic *characteristic in service.characteristics){
                //发现特征 注意：uuid 分为可读，可写，区别对待
                // 通知
                if ((characteristic.properties & CBCharacteristicPropertyNotify) || (characteristic.properties & CBCharacteristicPropertyIndicate)) {
                    // 订阅通知监听
                    self.characteristic2 = characteristic;
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
                // 写入
                if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
                    // 写入
                    self.writeCharacteristic2 = characteristic;
                }
            }
        }
    }else{
        // 特征
        for (CBCharacteristic *characteristic in service.characteristics){
            //发现特征 注意：uuid 分为可读，可写，区别对待
            // 通知
            if ((characteristic.properties & CBCharacteristicPropertyNotify) || (characteristic.properties & CBCharacteristicPropertyIndicate)) {
                // 订阅通知监听
                self.characteristic = characteristic;
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            // 写入
            if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
                // 写入
                self.writeCharacteristic = characteristic;
            }
        }
    }
}

#pragma mark - 数据写入成功回调
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    NSLog(@"写入成功");
}
#pragma mark - 特征值被更新后
#pragma mark --
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (error) {
//        NSLog(@"更新通知状态时发生错误，错误信息：%@",error.localizedDescription);
    }
     
    //给特征值设置新的值
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    if ([characteristic.UUID isEqual:characteristicUUID]) {
        if (characteristic.isNotifying) {
            if (characteristic.properties == CBCharacteristicPropertyNotify) {
//                NSLog(@"已订阅特征通知.");
                return;
            }else if (characteristic.properties == CBCharacteristicPropertyRead){

//                [peripheral readValueForCharacteristic:characteristic];
            }else{
                
            }
        }else{
//            NSLog(@"停止已停止.");
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
//        NSLog(@"更新特征值时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
     
        if (self.secondCount %1 == 0) {
           
            if (peripheral == self.discoveredPeripheral ) {
                if (characteristic == self.characteristic) {
                   
                    if (characteristic.value) {
                        self.valueStr1 = [self handelOriginalCharacteristicValue:characteristic.value.description];
                        self.valueStr1 = [self handelBlueCharacteristicValueFormat:self.valueStr1];
                    }
                }
            }
        }
        if (self.secondCount %2 == 0) {
            
            if (peripheral == self.discoveredPeripheral2) {
                if (characteristic == self.characteristic2) {
                    
                    if (characteristic.value) {
                        self.valueStr2 = [self handelOriginalCharacteristicValue:characteristic.value.description];
                        self.valueStr2 = [self handelBlueCharacteristicValueFormat:self.valueStr2];
                    }
                }
            }
        }
        if (self.secondCount %2 == 0) {

            [self handleFeetCharacteristicValue:self.valueStr1 characteristicValue2:self.valueStr2];
        }
    }else{
        // top、bottom、heating pad
        if (characteristic.value) {
        
            if (peripheral == self.discoveredPeripheral) {
                if (characteristic == self.characteristic ) {
                    NSString *value = [self handelOriginalCharacteristicValue:characteristic.value.description];
                    if ([self.lastValueStr isEqualToString:value]) {
                        
                    }else{
                        self.lastValueStr = value;
                        value = [self handelBlueCharacteristicValueFormat:value];
                        [self handleCharacteristicValue:value position:1];
//                        NSLog(@"characteristic is %@",characteristic);
//                        NSLog(@"self.characteristic is %@",self.characteristic);
//                        NSLog(@"发现特征值 is %@",value);
                    }
                }
            }
            
        }else{
//            NSLog(@"未发现特征值");
        }
    }
}
#pragma mark - 处理原始特征值
#pragma mark -- handelOriginalCharacteristicValue
- (NSString *)handelOriginalCharacteristicValue:(NSString *)value{
    NSString *valueStr;
    if (@available(iOS 13.0, *)) {
        // 13.0 系统及以上获取格式为：{length = 8, bytes = 0xcc00000000020066}
        valueStr = [value substringWithRange:NSMakeRange(1, value.length - 2)];
        if (valueStr.length >= 16) {
            valueStr = [valueStr substringFromIndex:valueStr.length - 16];
        }
        
    } else {
        valueStr = value;
    }
    return valueStr;
}
#pragma mark -  处理蓝牙监听格式
#pragma mark -- handelBlueCharacteristicValueFormat
- (NSString *)handelBlueCharacteristicValueFormat:(NSString *)valueStr{
    NSString *tempStr;
    tempStr = valueStr;
    //iOS 13 之前返回数值 <cc000000 00020066> ；13之后返回 cc00000000020066
    if (@available(iOS 13.0, *)) {
        
    }else{
        // 替换空格 并去掉首尾 "<>" 符号
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        tempStr = [tempStr substringWithRange:NSMakeRange(1, tempStr.length - 2)];
    }
    return tempStr;
}
      
#pragma mark -
#pragma mark -- handleFeetCharacteristicValue
- (void)handleFeetCharacteristicValue:(NSString *)value1 characteristicValue2:(NSString *)value2{
    
    NSString *startFlag1 = [value1 substringWithRange:NSMakeRange(0, 2)];
    NSString *endFlag1 = [value1 substringWithRange:NSMakeRange(value1.length - 2, 2)];
    NSString *electricValue1 = [value1 substringWithRange:NSMakeRange(6, 2)];
   
    NSString *startFlag2 = [value2 substringWithRange:NSMakeRange(0, 2)];
    NSString *endFlag2 = [value2 substringWithRange:NSMakeRange(value2.length - 2, 2)];
    NSString *electricValue2 = [value2 substringWithRange:NSMakeRange(6, 2)];
   
    if (([startFlag1 isEqualToString:@"cc"] && [endFlag1 isEqualToString:@"66"]) || ([startFlag2 isEqualToString:@"cc"] && [endFlag2 isEqualToString:@"66"])) {
        self.bottomLeftIconImageView.image = [UIImage imageNamed:[self handleElectricValueWithElectricValue:electricValue1]];
        self.bottomRightIconImageView.image = [UIImage imageNamed:[self handleElectricValueWithElectricValue:electricValue2]];
        
        NSString *receiveFlagStr1 = [value1 substringWithRange:NSMakeRange(2, 2)];
        NSString *receiveTemperature1 = [value1 substringWithRange:NSMakeRange(4, 2)];
        BOOL receiveFlag1 = [receiveFlagStr1 isEqualToString:@"01"] ? YES:NO;
        NSInteger receiveTemperatureInt1 = [self handleReceiveTemperature:receiveTemperature1];
        
        
        NSString *receiveFlagStr2 = [value2 substringWithRange:NSMakeRange(2, 2)];
        NSString *receiveTemperature2 = [value2 substringWithRange:NSMakeRange(4, 2)];
        BOOL receiveFlag2 = [receiveFlagStr2 isEqualToString:@"01"] ? YES:NO;
        NSInteger receiveTemperatureInt2 = [self handleReceiveTemperature:receiveTemperature2];
        
        // 0X01 是按键控制模式，0X02 是 APP 控制模式;
//        NSString *typeStr1 = [value1 substringWithRange:NSMakeRange(10, 2)];
//        NSString *typeStr2 = [value2 substringWithRange:NSMakeRange(10, 2)];
       
        self.sendTemperature = MAX(receiveTemperatureInt1, receiveTemperatureInt2);
        if (self.isFirst ) {
            self.isFirst = NO;
            self.sendFlag = receiveFlag1 | receiveFlag2;
            self.setTemperatureSwitch.on = self.sendFlag == YES;
            
            self.temperatureCircleView.temperInter = self.sendTemperature;
            self.temperatureCircleView.isClose = self.setTemperatureSwitch.on == NO;
            
        }
        
        // 默认是App 模式
        if (CBPeripheralStateConnected == self.discoveredPeripheral.state) {
            if ([receiveTemperature1 isEqualToString:@"00"]) {
                
                [self writeDataWithStatus:YES temperature:self.sendTemperature];
            }
        }
        if (CBPeripheralStateConnected == self.discoveredPeripheral2.state) {
           if ([receiveTemperature2 isEqualToString:@"00"]) {
                
                [self writeDataWithStatus:YES temperature:self.sendTemperature];
            }
        }
    }
    
    if (self.isPickerConnect) {
        
    }else{
         [MBProgressHUD hideHUDForView:self.view];
    }
}

//
#pragma mark -
#pragma mark -- handleCharacteristicValue
- (void)handleCharacteristicValue:(NSString *)value position:(NSInteger)position{
    
    NSString *startFlag = [value substringWithRange:NSMakeRange(0, 2)];
    NSString *endFlag = [value substringWithRange:NSMakeRange(value.length - 2, 2)];
    NSString *electricValue = [value substringWithRange:NSMakeRange(6, 2)];
    
    
    self.bottomLeftIconImageView.image = [UIImage imageNamed:[self handleElectricValueWithElectricValue:electricValue]];
    self.bottomRightIconImageView.image = [UIImage imageNamed:@"none"];
    [self.bottomRightBluetoothButton setImage: [UIImage imageNamed:@"none"] forState:UIControlStateNormal];
    if ([startFlag isEqualToString:@"cc"] && [endFlag isEqualToString:@"66"]) {
        NSString *receiveFlagStr = [value substringWithRange:NSMakeRange(2, 2)];
        NSString *receiveTemperature = [value substringWithRange:NSMakeRange(4, 2)];
        self.receiveFlag  = [receiveFlagStr isEqualToString:@"01"] ? YES:NO;
        self.receiveTemperature = [self handleReceiveTemperature:receiveTemperature];
        // 0X01 是按键控制模式，0X02 是 APP 控制模式;
        NSString *typeStr;
        if (value.length >= 12) {
             typeStr = [value substringWithRange:NSMakeRange(10, 2)];
        }
       
        // 默认是App 模式
        if (self.isFirst || [typeStr isEqualToString:@"01"]) {
            self.isFirst = NO;
            self.sendFlag = self.receiveFlag;
            self.setTemperatureSwitch.on = self.receiveFlag == YES;

            self.sendTemperature = self.receiveTemperature;
            self.temperatureCircleView.temperInter = self.receiveTemperature;
            self.temperatureCircleView.isClose = self.setTemperatureSwitch.on == NO;
        }else{
            if (self.sendFlag == self.receiveFlag) {
                
            }else{
                self.sendFlag = self.receiveFlag;
//                self.setTemperatureSwitch.on = self.receiveFlag == YES;
            }
            if (self.sendTemperature == self.receiveTemperature) {
                
            }else{
                self.sendTemperature = self.receiveTemperature;
//                self.temperatureCircleView.temperInter = self.receiveTemperature;
//                self.temperatureCircleView.isClose = self.setTemperatureSwitch.on == NO;
            }
        }
    }
    if (self.isPickerConnect) {
        
    }else{
         [MBProgressHUD hideHUDForView:self.view];
    }
   
    
//    NSLog(@"读取到特征值：%@",value);
}
#pragma mark - 处理电量
#pragma mark -- handleElectricValueWithElectricValue
- (NSString *)handleElectricValueWithElectricValue:(NSString *)electricValue {
    // 默认不显示电量
    NSInteger tempInt = 0;
    if ([electricValue isEqualToString:@"00"]) {
        // 不显示电池图标
        tempInt = 0;
    }else if ([electricValue isEqualToString:@"11"]){
        // 显示1格电池图标
        tempInt = 1;
    }else if ([electricValue isEqualToString:@"12"]){
        // 显示2格电池图标
        tempInt = 2;
    }else if ([electricValue isEqualToString:@"13"]){
        // 显示3格电池图标
        tempInt = 3;
    }else if ([electricValue isEqualToString:@"14"]){
        // 显示4格电池图标
        tempInt = 4;
    }else if ([electricValue isEqualToString:@"10"]){
        // 显示空电池图标 新增
        tempInt = 5;
    }
 
    NSString *imageStr = [NSString stringWithFormat:@"battery_icon_%ld",(long)tempInt];
    return imageStr;
}

#pragma mark -  push到链接失败提示页面
#pragma mark -- pushNODeviceVC
- (void)pushNODeviceVC{
    [MBProgressHUD hideHUDForView:self.view];
    MECNoDeviceFoundViewController *vc = [[MECNoDeviceFoundViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  处理开关及温度值
#pragma mark -- handleTemperatureSwitchAndTemperatureView
- (void)handleTemperatureSwitchAndTemperatureView{
    
}
#pragma mark - 写入数据
#pragma mark -- writeDataWithHexStr
- (void)writeDataWithHexStr:(NSString *)hexStr {
    // 方法一 字符串转NSData
    NSData *data = [self convertHexStrToData:hexStr];
    // 方法w二 字节数组转NSData
//    unsigned char send[8] = {0xAA, 0x01, 0x10, 0x00, 0x00, 0x00, 0x00,0x055};
//    NSData *sendData = [NSData dataWithBytes:send length:8];
//    self.isFirst = YES;
//    self.lastValueStr = @"";
    [self.discoveredPeripheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    if (PositionTypeFootLeft == self.positionType || PositionTypeFootRight == self.positionType) {
        if (self.writeCharacteristic2 && self.discoveredPeripheral2) {
             [self.discoveredPeripheral2 writeValue:data forCharacteristic:self.writeCharacteristic2 type:CBCharacteristicWriteWithoutResponse];
        }
    }
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
    if (self.discoveredPeripheral2) {
         [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
    }
    self.centralManager = nil;
    self.discoveredPeripheral = nil;
    self.characteristic = nil;
    self.discoveredPeripheral2 = nil;
    self.characteristic2 = nil;
   
}

#pragma mark -
#pragma mark -- alertMessageController
- (void)alertMessageController{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"To successfully connect the Heat device,Please allow bluetooth permissions to be enabled" preferredStyle:UIAlertControllerStyleAlert];
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


#pragma mark Event
#pragma mark -- setTemperatureSwitchAction
- (void)setTemperatureSwitchAction:(UISwitch *)mySwitch {
 
    
    if (CBPeripheralStateConnected == self.discoveredPeripheral.state || CBPeripheralStateConnected == self.discoveredPeripheral2.state) {
        
        if (mySwitch.on) {
            self.currentTemperature = 10;
            self.temperatureCircleView.temperInter = 10;
        }
        
        self.temperatureCircleView.isClose = mySwitch.on == NO;
        
        [self writeDataWithStatus:self.setTemperatureSwitch.on temperature:self.temperatureCircleView.temperInter];
    }else{
        mySwitch.on = !mySwitch.on;
        [MBProgressHUD showError:@"Device not Connection"];
    }
}

- (NSInteger )handleReceiveTemperature:(NSString *)receiveTemperature{
    NSInteger tempTemperature;
    //十六进制的 0a 代表10
    if ([receiveTemperature isEqualToString:@"0a"]) {
        tempTemperature = 10;
    }else{
        // 截取最后一位 0 - 9
        tempTemperature = [receiveTemperature substringFromIndex:1].integerValue;
    }
    return tempTemperature;
}


#pragma mark - 懒加载
#pragma mark -- lazy
- (UIView *)topIconBgView{
    if (!_topIconBgView) {
        _topIconBgView = [[UIView alloc] init];
        _topIconBgView.backgroundColor = kColorRGB(230, 230, 230);
        _topIconBgView.layer.cornerRadius = kWidth6(30);
        _topIconBgView.layer.masksToBounds = YES;
    }
    return _topIconBgView;
}
- (UIImageView *)topIconImageView{
    if (!_topIconImageView) {
        _topIconImageView = [[UIImageView alloc] init];
        _topIconImageView.image = [UIImage imageNamed:@"none"];
    }
    return _topIconImageView;
}
- (UIView *)switchBgView{
    if (!_switchBgView) {
        _switchBgView = [[UIView alloc] init];
        // 通过添加到view上面，然后缩放比例来修改大小
        [_switchBgView addSubview:self.setTemperatureSwitch];
        _switchBgView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    }
    return _switchBgView;
}
- (UISwitch *)setTemperatureSwitch {
    if (!_setTemperatureSwitch) {
        _setTemperatureSwitch = [[UISwitch alloc] init];
        _setTemperatureSwitch.onTintColor = kColorRGB(63, 220, 31);
        // 默认不选中
        _setTemperatureSwitch.on = NO;

        [_setTemperatureSwitch addTarget:self action:@selector(setTemperatureSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setTemperatureSwitch;
}

- (UILabel *)leftTipsLabel{
    if (!_leftTipsLabel) {
        _leftTipsLabel = [[UILabel alloc] init];
        _leftTipsLabel.font = MEC_Helvetica_Regular_Font(15);
        _leftTipsLabel.text = @"OFF";
        _leftTipsLabel.textAlignment = NSTextAlignmentCenter;
        _leftTipsLabel.textColor = kColorHex(0x717071);
    }
    return _leftTipsLabel;
}
- (UILabel *)rightTipsLabel{
    if (!_rightTipsLabel) {
        _rightTipsLabel = [[UILabel alloc] init];
        _rightTipsLabel.font = MEC_Helvetica_Regular_Font(15);
        _rightTipsLabel.text = @"ON";
        _rightTipsLabel.textAlignment = NSTextAlignmentCenter;
        _rightTipsLabel.textColor = kColorHex(0x717071);
    }
    return _rightTipsLabel;
}

- (MECTemperatureCircleAnimationView *)temperatureCircleView{
    if (!_temperatureCircleView) {
       
        _temperatureCircleView = [[MECTemperatureCircleAnimationView alloc] initWithFrame:CGRectMake((kScreenWidth - kWidth6(290))/2, kWidth6(140), kWidth6(280), kWidth6(280)) deviceType:self.dbtname];
        _temperatureCircleView.temperInter = self.currentTemperature;
        _temperatureCircleView.isClose = YES;
        kWeakSelf
        _temperatureCircleView.temperatureCircleBlock = ^(NSInteger temperature) {

            if (CBPeripheralStateConnected == weakSelf.discoveredPeripheral.state || CBPeripheralStateConnected == weakSelf.discoveredPeripheral2.state) {
                weakSelf.currentTemperature = temperature;
                [weakSelf writeDataWithStatus:weakSelf.setTemperatureSwitch.on temperature:temperature];
            }
        };
    }
    return _temperatureCircleView;
}

- (void)writeDataWithStatus:(BOOL)status temperature:(NSInteger)temperature{
    NSString *flagStr = self.setTemperatureSwitch.on ? @"01":@"00";
    NSString *temperatureStr;
    // 小余1直接返回
    if (temperature < 1)  return ;
    // 十进制转十六进制
    switch (temperature) {
        case 0:
            temperatureStr = @"00";
            break;
        case 1:
            temperatureStr = @"01";
            break;
        case 2:
            temperatureStr = @"02";
            break;
        case 3:
            temperatureStr = @"03";
            break;
        case 4:
            temperatureStr = @"04";
            break;
        case 5:
            temperatureStr = @"05";
            break;
        case 6:
            temperatureStr = @"06";
            break;
        case 7:
            temperatureStr = @"07";
            break;
        case 8:
            temperatureStr = @"08";
            break;
        case 9:
            temperatureStr = @"09";
            break;
        case 10:
            temperatureStr = @"0a";
            break;
        default:
            break;
    }
    // 关闭则默认给最大值
    if (!self.setTemperatureSwitch.on) {
        temperatureStr = @"0a";
        temperature = 10;
        self.currentTemperature = 10;
    }
    self.sendFlag = self.setTemperatureSwitch.on;
    self.sendTemperature = temperature;
    NSString *sendDataStr = [NSString stringWithFormat:@"AA%@%@0000000055",flagStr,temperatureStr];
    [self writeDataWithHexStr:sendDataStr];
}
#pragma mark -
#pragma mark -- bottomLeftBluetoothButtonAction
- (void)bottomLeftBluetoothButtonAction{
    if (CBPeripheralStateConnected == self.discoveredPeripheral.state ) {
        [MBProgressHUD showError:@"Device has connected"];
    }else{
        self.isShowConnectionError = NO;
       
        [self startScan];
    }
}
#pragma mark -
#pragma mark -- bottomRightBluetoothButtonAction
- (void)bottomRightBluetoothButtonAction{
    if (CBPeripheralStateConnected == self.discoveredPeripheral2.state ) {
        [MBProgressHUD showError:@"Device has connected"];
    }else{
        self.isShowConnectionError = NO;
        
        [self startScan];
    }
}
//懒加载
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
- (UIView *)middleBgView{
    if (!_middleBgView) {
        _middleBgView = [[UIView alloc] init];
        _middleBgView.layer.masksToBounds = YES;
        _middleBgView.backgroundColor = [UIColor clearColor];
        _middleBgView.layer.cornerRadius = kWidth6(13);
        _middleBgView.layer.borderColor = kColorHex(0x717071).CGColor;
        _middleBgView.layer.borderWidth = kWidth6(1);
    }
    return _middleBgView;
}
- (UILabel *)bottomLeftTipsLabel{
    if (!_bottomLeftTipsLabel) {
        _bottomLeftTipsLabel = [[UILabel alloc] init];
        _bottomLeftTipsLabel.font = MEC_Helvetica_Regular_Font(15);
        _bottomLeftTipsLabel.text = @"Left";
        _bottomLeftTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLeftTipsLabel.textColor = kColorHex(0x717071);
    }
    return _bottomLeftTipsLabel;
}
- (UIImageView *)bottomLeftIconImageView{
    if (!_bottomLeftIconImageView) {
        _bottomLeftIconImageView = [[UIImageView alloc] init];
        _bottomLeftIconImageView.image = [UIImage imageNamed:@"battery_icon_4"];
    }
    return _bottomLeftIconImageView;
}
- (UIButton *)bottomLeftBluetoothButton{
    if (!_bottomLeftBluetoothButton) {
        _bottomLeftBluetoothButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomLeftBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
        [_bottomLeftBluetoothButton addTarget:self action:@selector(bottomLeftBluetoothButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottomLeftBluetoothButton;
}
- (UILabel *)bottomRightTipsLabel{
    if (!_bottomRightTipsLabel) {
        _bottomRightTipsLabel = [[UILabel alloc] init];
        _bottomRightTipsLabel.font = MEC_Helvetica_Regular_Font(15);
        _bottomRightTipsLabel.text = @"Right";
        _bottomRightTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomRightTipsLabel.textColor = kColorHex(0x717071);
    }
    return _bottomRightTipsLabel;
}

- (UIButton *)bottomRightBluetoothButton{
    if (!_bottomRightBluetoothButton) {
        _bottomRightBluetoothButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomRightBluetoothButton setImage:[UIImage imageNamed:@"bluetooth_icon_normal"] forState:UIControlStateNormal];
        [_bottomRightBluetoothButton addTarget:self action:@selector(bottomRightBluetoothButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottomRightBluetoothButton;
}
- (UIImageView *)bottomRightIconImageView{
    if (!_bottomRightIconImageView) {
        _bottomRightIconImageView = [[UIImageView alloc] init];
        _bottomRightIconImageView.image = [UIImage imageNamed:@"battery_icon_4"];
    }
    return _bottomRightIconImageView;
}

- (NSMutableArray *)searchBluDataMuArr{
    if (!_searchBluDataMuArr) {
        _searchBluDataMuArr = [NSMutableArray array];
    }
    return _searchBluDataMuArr;
}

- (NSArray *)positionArr{
    if (!_positionArr) {
        _positionArr = [NSArray arrayWithObjects: @"Top", @"Bottom",@"Foot",@"Heating Pad", nil];
    }
    return _positionArr;
}
@end
