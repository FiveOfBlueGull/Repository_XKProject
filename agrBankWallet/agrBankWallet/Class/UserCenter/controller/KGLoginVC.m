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
    [self.userName resignFirstResponder];
    [self.userPassword resignFirstResponder];
    NSString *userName = [self.userName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *userPassword = [self.userPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!userName || [userName isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名格式有误！请重新输入！！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (!userPassword || [userPassword isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码格式有误！请重新输入！！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //查询
//    AVObject *user = [[AVObject alloc] initWithClassName:@""];
    AVQuery *users = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [users whereKey:@"userPhone" equalTo:userName];
    [users findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count > 0) {
            AVObject *user = [objects firstObject];
            if ([user[@"userPassword"] isEqualToString:userPassword]) {
                NSLog(@"%@",[user description]);
                [self didLoginWithUserInfo:user];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码有误！请重新输入！！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名有误！请重新输入用户名！！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            return;

        }
    }];
}


- (void)didLoginWithUserInfo:(AVObject *)user{
    [self.globalDataModel didLoginWithReturnInfo:@{@"userName":user[@"userName"],
                                                   @"userAccount":user[@"userAccount"],
                                                   @"userPassword":user[@"userPassword"],
                                                   @"userNick":user[@"userNick"],
                                                   @"userType":user[@"userType"],
                                                   @"userPhone":user[@"userPhone"],
                                                   @"userObjectID":user[@"objectId"]}];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleRegisterBtnAction:(id)sender{
    KGRegisterVC *vc = [[KGRegisterVC alloc] initWithNibName:@"KGRegisterVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
