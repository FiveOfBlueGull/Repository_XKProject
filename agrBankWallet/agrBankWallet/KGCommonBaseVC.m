//
//  KGCommonBaseVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGCommonBaseVC ()

@property (nonatomic, assign)BOOL showingCustomBackButton;

@end

@implementation KGCommonBaseVC

- (instancetype)initWithCustomBackButton:(BOOL)showing{
    self = [super init];
    if (self) {
        self.showingCustomBackButton = showing;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil customBackButton:(BOOL)showing{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.showingCustomBackButton = showing;
    }
    return self;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.showingCustomBackButton = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.showingCustomBackButton = YES;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.globalDataModel = [GlobalDataModel shareInstance];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupLeftBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- private 

- (void)setupLeftBarButtonItem{
    if (self.showingCustomBackButton) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem = item;

    }else{
        self.navigationItem.hidesBackButton = YES;
    }
}

- (void)goBack{
    // override by subClass
}

#pragma mark -- public

- (RDVTabBarController *)rootTabBarVC{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return (RDVTabBarController *)window.rootViewController;
}

- (UIWindow *)window{
    return [[[UIApplication sharedApplication] delegate] window];
}

- (void)alertWithMessage:(NSString *)message{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
}

- (void)alertWithMessage:(NSString *)message delay:(NSTimeInterval)delay{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view performSelector:@selector(show) withObject:nil afterDelay:delay];
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
