//
//  MECBaseMenuView.m
//  MEC
//
//  Created by John on 2020/7/30.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseMenuView.h"
#import "MECBaseMenuViewTableViewCell.h"


#define kHeadViewHeight kWidth6(50)

@interface MECBaseMenuView ()<UITableViewDelegate,UITableViewDataSource>


///背景视图
@property (nonatomic ,strong) UIImageView *bgImageView;

///tableview
@property (nonatomic ,strong) UITableView *tableView;

///背景视图
@property (nonatomic ,strong) UIView *bgView;

@end
@implementation MECBaseMenuView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{

    [self addSubview:self.bgView];
    [self addSubview:self.bgImageView];
    [self addSubview:self.tableView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-kWidth6(10));
        make.top.equalTo(self);
        make.width.mas_equalTo(kWidth6(210));
        make.height.mas_equalTo(kWidth6(240));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-kWidth6(10));
        make.top.equalTo(self).offset(kMargin);
        make.width.mas_equalTo(kWidth6(200));
        make.height.mas_equalTo(kWidth6(220));
    }];
    
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth6(46);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeadViewHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - kWidth6(200) - kWidth6(10), 0, kWidth6(200), kHeadViewHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth6(200) - kWidth6(84))/2, (kHeadViewHeight - kWidth6(20))/2, kWidth6(84), kWidth6(26))];
    logoImageView.image = [UIImage imageNamed:@"mine_base_menu_logo"];
    [headerView addSubview:logoImageView];
    return headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MECBaseMenuViewTableViewCell *cell = [MECBaseMenuViewTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    NSString *iconStr;
    NSString *textStr;
    switch (indexPath.row) {
        case 0:
        {
            iconStr = @"menu_pairing_icon";
            textStr = @"PAIR DEVICE";
        }
            break;
        case 1:
        {
            iconStr = @"menu_list_icon";
            textStr = @"BLUETOOTH";
        }
            break;
        case 2:
        {
            iconStr = @"menu_setting_icon";
            textStr = @"SETTINGS";
        }
            break;
            
        default:
            break;
    }
    cell.iconStr = iconStr;
    cell.textStr = textStr;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.cellTapBlock) {
        self.cellTapBlock(indexPath.row);
    }
}



#pragma mark - lazy
#pragma mark - tableview
- (void)tapAction{
    self.hidden = YES;
}
#pragma mark - lazy
#pragma mark - tableview
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"mine_menu_bg"];
    }
    return _bgImageView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kWidth6(40);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _tableView;
}

@end
