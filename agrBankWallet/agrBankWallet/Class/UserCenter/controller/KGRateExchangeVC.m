//
//  KGRateExchangeVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/7.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGRateExchangeVC.h"

@interface KGRateExchangeVC ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong)NSMutableDictionary *rateDictionary;

@property (nonatomic, assign)float                currentRate;

@end

@implementation KGRateExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"汇率换算";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    self.rateDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"人民币":@(1.00f),
                                                                          @"美元":@(6.37f),
                                                                          @"港币":@(0.82f),
                                                                          @"新台币":@(0.19f),
                                                                          @"澳门币":@(0.79f),
                                                                          @"欧元":@(7.20f),
                                                                          @"韩元":@(0.0054f),
                                                                          @"日元":@(0.053f),
                                                                          @"英镑":@(9.72f)}];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResult) name:UIKeyboardDidHideNotification object:self.dollarTF];
    self.currentRate = [[self.rateDictionary objectForKey:@"美元"] floatValue];
    self.descriptionLbl.text = @"1美元＝6.37人民币,当前参考汇率6.37";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 

- (void)resetRateWithText:(NSString *)text{
    [self.dollarBtn setTitle:text forState:UIControlStateNormal];
    self.currentRate = [[self.rateDictionary objectForKey:text] floatValue];
    float dollar = [self.dollarTF.text floatValue];
    float result = dollar * self.currentRate;
    self.rmbTF.text = [@(result) description];
    self.descriptionLbl.text = [NSString stringWithFormat:@"1%@=%@人民币,当前参考汇率%@",text,[@(self.currentRate) description],[@(self.currentRate) description]];
}

#pragma mark -- 

- (void)didClickDollarBtn:(id)sender{
    self.rateChoiceView.hidden = NO;
}

- (void)handleRateCancelBtnAction:(id)sender{
    self.rateChoiceView.hidden = YES;
}

- (void)handleRateConfirmBtnAction:(id)sender{
    self.rateChoiceView.hidden = YES;
    NSInteger index = [self.ratePickerView selectedRowInComponent:0];
    [self resetRateWithText:[[self.rateDictionary allKeys] objectAtIndex:index]];
}
#pragma mark -- UIPickerView dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.rateDictionary allKeys].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.rateDictionary allKeys] objectAtIndex:row];
}

#pragma mark --

- (void)getResult{
    float dollar = [self.dollarTF.text floatValue];
    float result = dollar * self.currentRate;
    self.rmbTF.text = [@(result) description];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    float dollar = [self.dollarTF.text floatValue];
    float result = dollar * self.currentRate;
    self.rmbTF.text = [@(result) description];
}

@end
