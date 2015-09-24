//
//  KGLoginVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGLoginVC.h"
#import "KGRegisterVC.h"

@interface KGLoginVC ()

@end

@implementation KGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)handleLoginBtnAction:(id)sender{
    [self.view resignFirstResponder];
}


- (void)handleRegisterBtnAction:(id)sender{
    KGRegisterVC *vc = [[KGRegisterVC alloc] initWithNibName:@"KGRegisterVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
