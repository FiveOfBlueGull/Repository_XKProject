//
//  KGBankDepositVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGBankDepositVC.h"

@interface KGBankDepositVC ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, assign)float currentRate;

@property (nonatomic, assign)float multiple;

@property (nonatomic, strong)NSArray *rateArray;

@end

@implementation KGBankDepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"存款计算";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    self.currentRate = 0.35 / 100.0f;
    self.multiple = 1.0f;
    
    self.rateArray = @[@{@"qixian":@"3个月定期",@"lilv":@(1.35),@"multiple":@(0.25)},
                       @{@"qixian":@"6个月定期",@"lilv":@(1.55),@"multiple":@(0.5)},
                       @{@"qixian":@"1年定期",@"lilv":@(1.75),@"multiple":@(1.0)},
                       @{@"qixian":@"2年定期",@"lilv":@(2.35),@"multiple":@(2.0)},
                       @{@"qixian":@"3年定期",@"lilv":@(3.0),@"multiple":@(3.0)},
                       @{@"qixian":@"5年定期",@"lilv":@(3.0),@"multiple":@(5.0)}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeHuoqi_Dingqi:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.huoqiView.hidden = NO;
        self.dingqiView.hidden = YES;
        
        self.currentRate = 0.35 / 100.0f;
        self.multiple = 1.0f;
    }else if (sender.selectedSegmentIndex == 1){
        self.huoqiView.hidden = YES;
        self.dingqiView.hidden = NO;
        [self setSubviewWithDic:[self.rateArray firstObject]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.jiner_huoqiTF) {
        float lixi = [self getLixi_Huoqi];
        self.lixiLbl.text = [NSString stringWithFormat:@"%.2f",lixi];
        float lixi_benjin = [self getLixiAndBenjin_Huoqi];
        self.lixi_benjinLbl.text = [NSString stringWithFormat:@"%.2f",lixi_benjin];
    }else if(textField == self.qixian_huoqiTF){
        float lixi = [self getLixi_Huoqi];
        self.lixiLbl.text = [NSString stringWithFormat:@"%.2f",lixi];
        float lixi_benjin = [self getLixiAndBenjin_Huoqi];
        self.lixi_benjinLbl.text = [NSString stringWithFormat:@"%.2f",lixi_benjin];
    }else if (textField == self.jiner_dingqiTF){
        float lixi = [self getLixi_Dingqi];
        self.lixiLbl.text = [NSString stringWithFormat:@"%.2f",lixi];
        float lixi_benjin = [self getLixiAndBenjin_Dingqi];
        self.lixi_benjinLbl.text = [NSString stringWithFormat:@"%.2f",lixi_benjin];
    }
}

- (float)getLixi_Huoqi{
    NSInteger benjin = [self.jiner_huoqiTF.text integerValue];
    NSInteger qixian = [self.qixian_huoqiTF.text integerValue];
    float lixi = benjin * (qixian / 365.0f) * self.currentRate * self.multiple;
    return lixi;
}

- (float)getLixiAndBenjin_Huoqi{
    NSInteger benjin = [self.jiner_huoqiTF.text integerValue];
    float lixi_benjin = benjin + [self getLixi_Huoqi];
    return lixi_benjin;
}

- (void)setSubviewWithDic:(NSDictionary *)dic{
    self.qixian_dingqiLbl.text = dic[@"qixian"];
    self.lilv_dingqiLbl.text = [dic[@"lilv"] description];
    self.currentRate = [dic[@"lilv"] floatValue];
    self.multiple = [dic[@"multiple"] floatValue];
}

- (float)getLixi_Dingqi{
    NSInteger benjin = [self.jiner_dingqiTF.text integerValue];
    float lixi = benjin * (self.currentRate / 100.0f) * self.multiple;
    return lixi;
}

- (float)getLixiAndBenjin_Dingqi{
    NSInteger benjin = [self.jiner_dingqiTF.text integerValue];
    float lixi_benjin = benjin + [self getLixi_Dingqi];
    return lixi_benjin;
}

- (void)showPicherView:(id)sender{
    self.rateChoiceView.hidden = NO;
}

- (void)handleRateCancelBtnAction:(id)sender{
    self.rateChoiceView.hidden = YES;
}

- (void)handleRateConfirmBtnAction:(id)sender{
    self.rateChoiceView.hidden = YES;

    [self setSubviewWithDic:[self.rateArray objectAtIndex:[self.ratePickerView selectedRowInComponent:0]]];
    float lixi = [self getLixi_Dingqi];
    self.lixiLbl.text = [NSString stringWithFormat:@"%.2f",lixi];
    float lixi_benjin = [self getLixiAndBenjin_Dingqi];
    self.lixi_benjinLbl.text = [NSString stringWithFormat:@"%.2f",lixi_benjin];
}

#pragma mark -- UIPickerView dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.rateArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.rateArray objectAtIndex:row] objectForKey:@"qixian"];
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
