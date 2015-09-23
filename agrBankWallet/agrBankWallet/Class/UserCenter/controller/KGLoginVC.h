//
//  KGLoginVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGLoginVC : KGCommonBaseVC

@property (nonatomic, weak)IBOutlet UITextField *userName;

@property (nonatomic, weak)IBOutlet UITextField *userPassword;

- (IBAction)handleLoginBtnAction:(id)sender;

- (IBAction)handleRegisterBtnAction:(id)sender;

@end
