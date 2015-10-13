//
//  KGVoucherDetailVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/3.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGVoucherDetailVC.h"
#import "KGDescriptionView.h"
#import "KGQRCodeVC.h"

@interface KGVoucherDetailVC ()

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView       *activityView;
@property (nonatomic, strong)UIView       *shopView;

@property (nonatomic, weak)IBOutlet UIView       *voucherStateView;
@property (nonatomic, weak)IBOutlet UIButton       *hasUsedBtn;
@property (nonatomic, weak)IBOutlet UIButton       *hasGetAccountBtn;

@end

@implementation KGVoucherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"优惠券详情";
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- set/get

- (UIView *)activityView{
    if (_activityView == nil) {
        _activityView = [[UIView alloc] init];
    }
    return _activityView;
}

- (UIView *)shopView{
    if (_shopView == nil) {
        _shopView = [[UIView alloc] init];
    }
    return _shopView;
}

#pragma mark -- setup

- (void)setup{
    [self setupVoucherStateViewWith:self.voucher];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 80, self.view.frame.size.width, self.view.frame.size.height - 64 - 80)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self setupActivityViewWith:self.activity];
    [self setupShopViewWith:self.shop];
}

- (void)setupVoucherStateViewWith:(AVObject *)voucher{
    NSNumber *num = voucher[@"hasUsed"];
    if ([num integerValue] == 0) {
        [self.hasUsedBtn setTitle:@"查看优惠码" forState:UIControlStateNormal];
        self.hasUsedBtn.enabled = YES;
    }else{
        [self.hasUsedBtn setTitle:@"优惠码以使用" forState:UIControlStateNormal];
        self.hasUsedBtn.enabled = NO;
    }
    num = voucher[@"hasGetAccount"];
    if ([num integerValue] == 0) {
        [self.hasGetAccountBtn setTitle:@"可领取积分" forState:UIControlStateNormal];
        self.hasGetAccountBtn.enabled = YES;
    }else{
        [self.hasGetAccountBtn setTitle:@"已获取积分" forState:UIControlStateNormal];
        self.hasGetAccountBtn.enabled = NO;
    }
}

- (void)setupActivityViewWith:(AVObject *)activity{
    [self.scrollView addSubview:self.activityView];
//    self.activityView.backgroundColor = [UIColor purpleColor];
    self.activityView.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
    CGFloat viewH = 0.0f;
    if (activity) {
        NSString *activityName = activity[@"ActivityName"];
        UIView *activityNameView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"活动:" rightString:activityName isFistItem:YES isLastItem:NO];
        [self.activityView addSubview:activityNameView];
        activityNameView.frame = CGRectMake(0, viewH, activityNameView.frame.size.width, activityNameView.frame.size.height);
        viewH += activityNameView.frame.size.height;
        self.activityView.frame = CGRectMake(self.activityView.frame.origin.x, self.activityView.frame.origin.y, self.activityView.frame.size.width, viewH);
        
        UIView *activityDescriptionView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"介绍:" rightString:activity[@"ActivityDescription"] isFistItem:NO isLastItem:NO];
        [self.activityView addSubview:activityDescriptionView];
        activityDescriptionView.frame = CGRectMake(0, viewH, activityDescriptionView.frame.size.width, activityDescriptionView.frame.size.height);
        viewH += activityDescriptionView.frame.size.height;
        self.activityView.frame = CGRectMake(self.activityView.frame.origin.x, self.activityView.frame.origin.y, self.activityView.frame.size.width, viewH);
        
        
        UIView *activityRuleView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"规则:" rightString:activity[@"UseRule"] isFistItem:NO isLastItem:YES];
        [self.activityView addSubview:activityRuleView];
        activityRuleView.frame = CGRectMake(0, viewH, activityRuleView.frame.size.width, activityRuleView.frame.size.height);
        viewH += activityRuleView.frame.size.height;
        self.activityView.frame = CGRectMake(self.activityView.frame.origin.x, self.activityView.frame.origin.y, self.activityView.frame.size.width, viewH);
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.activityView.frame.size.height);
}

- (void)setupShopViewWith:(AVObject *)shop{
    [self.scrollView addSubview:self.shopView];
//    self.shopView.backgroundColor = [UIColor greenColor];
    self.shopView.frame = CGRectMake(0, self.activityView.frame.size.height, self.view.frame.size.width, 0.0f);
    CGFloat viewH = 50.0f;
    if (shop) {
        NSString *shopName = shop[@"shopName"];
        UIView *shopNameView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"店铺:" rightString:shopName isFistItem:YES isLastItem:NO];
        [self.shopView addSubview:shopNameView];
        shopNameView.frame = CGRectMake(0, viewH, shopNameView.frame.size.width, shopNameView.frame.size.height);
        viewH += shopNameView.frame.size.height;
        self.shopView.frame = CGRectMake(self.shopView.frame.origin.x, self.shopView.frame.origin.y, self.shopView.frame.size.width, viewH);
        
        NSString *shopAddress = shop[@"shopAddress"];
        UIView *shopAddressView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"地址:" rightString:shopAddress isFistItem:NO isLastItem:NO];
        [self.shopView addSubview:shopAddressView];
        shopAddressView.frame = CGRectMake(0, viewH, shopAddressView.frame.size.width, shopAddressView.frame.size.height);
        viewH += shopAddressView.frame.size.height;
        self.shopView.frame = CGRectMake(self.shopView.frame.origin.x, self.shopView.frame.origin.y, self.shopView.frame.size.width, viewH);
        
        
        NSString *shopDescription = shop[@"shopDescription"];
        UIView *shopDescriptionView = [[KGDescriptionView alloc] initWithWidth:self.view.frame.size.width leftString:@"描述:" rightString:shopDescription isFistItem:NO isLastItem:YES];
        [self.shopView addSubview:shopDescriptionView];
        shopDescriptionView.frame = CGRectMake(0, viewH, shopDescriptionView.frame.size.width, shopDescriptionView.frame.size.height);
        viewH += shopDescriptionView.frame.size.height;
        self.shopView.frame = CGRectMake(self.shopView.frame.origin.x, self.shopView.frame.origin.y, self.shopView.frame.size.width, viewH);
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.activityView.frame.size.height + self.shopView.frame.size.height);
}

#pragma mark --

- (IBAction)showVoucherNumber{
    KGQRCodeVC *_QRCodeVC = [[KGQRCodeVC alloc] initWithNibName:@"KGQRCodeVC" bundle:nil customBackButton:YES];
    _QRCodeVC.targetObject = _voucher;
    if (self.shop) {
         _QRCodeVC.activityObject = _shop;
    } else {
        _QRCodeVC.activityObject = _activity;
    }
   
    [self.navigationController pushViewController:_QRCodeVC animated:YES];
}

- (IBAction)getAccount{
    NSNumber *accountCanGet = self.activity[@"Account"];
    __weak typeof(self) weakself = self;
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [query whereKey:@"objectId" equalTo:self.globalDataModel.userObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count] > 0) {
            AVObject *user = [objects firstObject];
            NSNumber *accountUserHas = user[@"userAccount"];
            accountUserHas = [NSNumber numberWithInt:(int)([accountUserHas integerValue] + [accountCanGet integerValue])];
            [user setObject:[accountUserHas description] forKey:@"userAccount"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"领取积分成功！");
                    AVQuery *query = [AVQuery queryWithClassName:@"VoucherListClass"];
                    [query whereKey:@"objectId" equalTo:self.voucher[@"objectId"]];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error && [objects count] > 0) {
                            AVObject *user = [objects firstObject];
                            [user setObject:[NSNumber numberWithInt:1] forKey:@"hasGetAccount"];
                            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (succeeded) {
                                    [weakself.hasGetAccountBtn setTitle:@"以获取积分" forState:UIControlStateNormal];
                                    weakself.hasGetAccountBtn.enabled = NO;
                                    [[NSNotificationCenter defaultCenter] postNotificationName:kShouldRefreshUserInfoNotification object:nil];
                                }else{
                                    
                                }
                            }];
                        }else{
                            NSLog(@"设置状态失败!");
                        }
                    }];
                }else{
                    NSLog(@"领取积分失败！");
                }
            }];
        }else{
            NSLog(@"领取积分失败！");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
