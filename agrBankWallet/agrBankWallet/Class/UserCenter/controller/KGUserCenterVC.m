//
//  KGUserCenterVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGUserCenterVC.h"
#import "KGUserCenterCell.h"//

#import "KGLoginVC.h"          //登录
#import "KGCommonBaseNVC.h"    //
#import "KGOrderListVC.h"      //预约列表
#import "KGVoucherListVC.h"    //优惠券列表
#import "KGRateExchangeVC.h"   //汇率换算
#import "KGOrderListVC.h"      //订单列表
#import "MyAppointmentVC.h"
#import "KGBankDepositVC.h"    //存款换算

#import "KGLuckyDrawGiftVC.h"  //抽奖
#import "KGExchangeGiftVC.h"   //兑换
@interface KGUserCenterVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *sectionTitleArray;

@property (nonatomic, strong)NSMutableArray *cellImageArray;

@end

@implementation KGUserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人中心";
    
    self.sectionTitleArray = [NSMutableArray arrayWithArray:@[@"积分",@"我的",@"小工具"]];
    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@[@"积分抽奖",@"我的礼品"],
                                                            @[@"我的预约",@"我的优惠券"],
                                                            @[@"汇率换算",@"存款计算"]]];
    self.cellImageArray = [NSMutableArray arrayWithArray:@[@[@"jifenchoujiang",@"jifenduihuan"],
                                                           @[@"yuyue",@"youhuiquan"],
                                                           @[@"huilvhuansuan",@"cunkuanhuansuan"]]];
    [self checkLogin];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:kShouldRefreshUserInfoNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.globalDataModel isLogin]) {
        self.userNameLbl.text = self.globalDataModel.userName;
        self.userAccountLbl.text = [NSString stringWithFormat:@"%@积分",self.globalDataModel.userAccount];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --

- (void)checkLogin{
    if (![self.globalDataModel isLogin]) {
        KGLoginVC *vc = [[KGLoginVC alloc] initWithNibName:@"KGLoginVC" bundle:nil];
        KGCommonBaseNVC *nvc = [[KGCommonBaseNVC alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nvc animated:YES completion:^{
            
        }];
    }
}

- (void)refreshUserInfo{
    AVQuery *users = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [users whereKey:@"userPhone" equalTo:self.globalDataModel.userPhone];
    [users findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count > 0) {
            AVObject *user = [objects firstObject];
            [self didGetUserInfo:user];
        }else{
            
        }
    }];

}

- (void)didGetUserInfo:(AVObject *)user{
    [self.globalDataModel didLoginWithReturnInfo:@{@"userName":user[@"userName"],
                                                   @"userAccount":user[@"userAccount"],
                                                   @"userPassword":user[@"userPassword"],
                                                   @"userNick":user[@"userNick"],
                                                   @"userType":user[@"userType"],
                                                   @"userPhone":user[@"userPhone"],
                                                   @"userObjectID":user[@"objectId"]}];
    self.userNameLbl.text = self.globalDataModel.userName;
    self.userAccountLbl.text = [NSString stringWithFormat:@"%@积分",self.globalDataModel.userAccount];
}

#pragma mark -- tableView datasource --


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourceArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGUserCenterCell *cell = (KGUserCenterCell *)[tableView dequeueReusableCellWithIdentifier:@"KGUserCenterCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGUserCenterCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell fillCellWithObject:self.dataSourceArray[indexPath.section][indexPath.row]];
    cell.leftImageView.image = [UIImage imageNamed:self.cellImageArray[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return [self.sectionTitleArray objectAtIndex:section];
    return @" ";
}

#pragma mark -- tableView delegate --

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[indexPath description]);
    if ([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:0]] == NSOrderedSame) {
        //积分抽奖
        KGLuckyDrawGiftVC *vc = [[KGLuckyDrawGiftVC alloc] initWithNibName:@"KGLuckyDrawGiftVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:0]] == NSOrderedSame){
        //我的礼品
        KGExchangeGiftVC *vc = [[KGExchangeGiftVC alloc] initWithNibName:@"KGExchangeGiftVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:1]] == NSOrderedSame) {
        KGOrderListVC *vc = [[KGOrderListVC alloc] initWithNibName:@"KGOrderListVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:1]] == NSOrderedSame){
        KGVoucherListVC *vc = [[KGVoucherListVC alloc] initWithNibName:@"KGVoucherListVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:2]] == NSOrderedSame){
        KGRateExchangeVC *vc = [[KGRateExchangeVC alloc]  initWithNibName:@"KGRateExchangeVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];
        /*
        MyAppointmentVC *appointmentVC = [[UIStoryboard storyboardWithName:@"AppointmentStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MyAppointmentVC"];
        [self.navigationController pushViewController:appointmentVC animated:YES];
         */
    }else if ([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:2]] == NSOrderedSame){
        //存款计算
        KGBankDepositVC *vc = [[KGBankDepositVC alloc] initWithNibName:@"KGBankDepositVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}

@end
