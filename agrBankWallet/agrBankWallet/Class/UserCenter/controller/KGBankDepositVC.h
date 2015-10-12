//
//  KGBankDepositVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGBankDepositVC : KGCommonBaseVC

@property (nonatomic, weak)IBOutlet UIView *rateChoiceView;
@property (nonatomic, weak)IBOutlet UIPickerView *ratePickerView;

@property (nonatomic, weak)IBOutlet UILabel *lixiLbl;
@property (nonatomic, weak)IBOutlet UILabel *lixi_benjinLbl;


@property (nonatomic, weak)IBOutlet UIView      *huoqiView;
@property (nonatomic, weak)IBOutlet UITextField *jiner_huoqiTF;
@property (nonatomic, weak)IBOutlet UITextField *qixian_huoqiTF;


@property (nonatomic, weak)IBOutlet UIView      *dingqiView;
@property (nonatomic, weak)IBOutlet UITextField *jiner_dingqiTF;
@property (nonatomic, weak)IBOutlet UILabel     *qixian_dingqiLbl;
@property (nonatomic, weak)IBOutlet UILabel     *lilv_dingqiLbl;

- (IBAction)changeHuoqi_Dingqi:(UISegmentedControl *)sender;

- (IBAction)showPicherView:(id)sender;

- (IBAction)handleRateConfirmBtnAction:(id)sender;

- (IBAction)handleRateCancelBtnAction:(id)sender;

@end
