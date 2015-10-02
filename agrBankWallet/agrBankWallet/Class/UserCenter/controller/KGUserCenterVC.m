//
//  KGUserCenterVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGUserCenterVC.h"
#import "KGUserCenterCell.h"//

#import "KGLoginVC.h"//
#import "KGCommonBaseNVC.h"//
#import "KGOrderListVC.h"//


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
    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@[@"积分抽奖",@"积分兑换"],
                                                            @[@"我的预约",@"我的优惠券"],
                                                            @[@"汇率换算",@"存款计算"]]];
    self.cellImageArray = [NSMutableArray arrayWithArray:@[@[@"jifenchoujiang",@"jifenduihuan"],
                                                           @[@"yuyue",@"youhuiquan"],
                                                           @[@"huilvhuansuan",@"cunkuanhuansuan"]]];
    [self checkLogin];
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
    if ([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:1]] == NSOrderedSame) {
        KGOrderListVC *vc = [[KGOrderListVC alloc] initWithNibName:@"KGOrderListVC" bundle:nil customBackButton:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
