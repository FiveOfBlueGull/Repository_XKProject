//
//  KGRegisterVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGRegisterVC : KGCommonBaseVC

@property (nonatomic ,weak)IBOutlet UITextField *userNameTF;
@property (nonatomic ,weak)IBOutlet UITextField *userPasswordTF;
@property (nonatomic, weak)IBOutlet UITextField *userConfirmPasswordTF;

- (IBAction)handleRegisterBtnAction:(id)sender;

@end
