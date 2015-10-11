//
//  KGRateExchangeVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/7.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGRateExchangeVC : KGCommonBaseVC

@property (nonatomic, weak)IBOutlet UIView *rateChoiceView;
@property (nonatomic, weak)IBOutlet UIPickerView *ratePickerView;

@property (nonatomic, weak)IBOutlet UIButton *dollarBtn;
@property (nonatomic, weak)IBOutlet UIButton *rmbBtn;

@property (nonatomic, weak)IBOutlet UITextField *dollarTF;
@property (nonatomic, weak)IBOutlet UITextField *rmbTF;

@property (nonatomic, weak)IBOutlet UILabel *descriptionLbl;

- (IBAction)didClickDollarBtn:(id)sender;

- (IBAction)handleRateConfirmBtnAction:(id)sender;

- (IBAction)handleRateCancelBtnAction:(id)sender;

@end
