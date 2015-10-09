//
//  SubmitApplyVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/9/29.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "SubmitApplyVC.h"

@interface SubmitApplyVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIView *bgView3;
@property (weak, nonatomic) IBOutlet UIView *bgView4;

@end

@implementation SubmitApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _applyType;
    
    _bgView1.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    _bgView2.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    _bgView3.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    _bgView4.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
