//
//  KGRegisterVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGRegisterVC.h"

@interface KGRegisterVC ()

@end

@implementation KGRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleRegisterBtnAction:(id)sender{
    [self.userNameTF resignFirstResponder];
    [self.userPasswordTF resignFirstResponder];
    [self.userConfirmPasswordTF resignFirstResponder];
    
    NSString *userPhone = [self.userNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *userPwd = [self.userPasswordTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *userConfirmPwd = [self.userConfirmPasswordTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (userPhone == nil || [userPhone isEqualToString:@""] || userPhone.length != 11) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码有误！请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        return;
    }
    
    if (userPwd.length >= 6 && [userPwd isEqualToString:userConfirmPwd]) {
        //查询是否被注册
        AVQuery *users = [[AVQuery alloc] initWithClassName:@"UserClass"];
        [users whereKey:@"userPhone" equalTo:userPhone];
        [users findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error && objects.count > 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该手机号已经注册！请更换手机号或直接登录！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }else{
                //注册
                AVObject *user = [AVObject objectWithClassName:@"UserClass"];
                [user setObject:userPhone forKey:@"userPhone"];
                [user setObject:userPwd forKey:@"userPassword"];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [user fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
                            NSLog(@"%@",object);
                            [self registerSuccessedWithObject:user];
                        }];
                    }
                }];
            }
        }];

    }else{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码或确认密码有误！请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        return;
    }
}

- (void)registerSuccessedWithObject:(AVObject *)user{
    [self.globalDataModel didLoginWithReturnInfo:@{@"userName":user[@"userName"],
                                                   @"userAccount":user[@"userAccount"],
                                                   @"userPassword":user[@"userPassword"],
                                                   @"userNick":user[@"userNick"],
                                                   @"userType":user[@"userType"],
                                                   @"userPhone":user[@"userPhone"]}];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
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
