//
//  FormQord.m
//  agrBankWallet
//
//  Created by Neely on 15/10/13.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "FormQord.h"
#import "UIImageView+WebCache.h"

@interface FormQord ()

@property (nonatomic,strong) UIImageView *qrView;

@end

@implementation FormQord

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"我的预约";
    
    
    [self.view addSubview:self.qrView];
    
    [self.qrView sd_setImageWithURL:[NSURL URLWithString:self.qrUrl]];
    
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- getter - 

- (UIImageView *)qrView{
    
    if (!_qrView) {
        
        _qrView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 202)/2.0, 100, 202, 202)];
    }
    return _qrView;
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
