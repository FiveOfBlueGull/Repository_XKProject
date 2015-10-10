//
//  SubmitApplyVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/9/29.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "SubmitApplyVC.h"

@interface SubmitApplyVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIView *bgView4;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *ensureField;
@property (weak, nonatomic) IBOutlet UITextField *postcardField;

@end

@implementation SubmitApplyVC
- (IBAction)submitAction:(id)sender {
    if (_phoneField.text.length == 11 && [_ensureField.text isEqualToString:_phoneField.text] && _postcardField.text.length > 0) {
        NSString *_orderNum = @"A1437";
        for (int i = 0; i < 6; i++) {
            int randomNum = arc4random()%10;
            _orderNum = [NSString stringWithFormat:@"%@%d", _orderNum, randomNum];
        }
        
        UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@"预约成功" message:[NSString stringWithFormat:@"预约号%@", _orderNum] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        _alertView.tag = 1000;
        [_alertView show];
        
        //预约存本地
        
        //过期时间
        NSInteger _second = [[NSDate date] timeIntervalSince1970];
        _second = _second + 24 * 60 * 60;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_second];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *outTime = [dateFormatter stringFromDate:date];
        
        NSDictionary *_dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneField.text, @"phoneNum", _postcardField.text, @"pstcard", _applyType, @"applyType", _orderNum, @"orderNum", outTime, @"outTime", nil];
        NSMutableArray *_tempArray = [NSMutableArray array];
        NSArray *_array = [[NSUserDefaults standardUserDefaults] objectForKey:@"SubmitApplyList"];
        if ([_array isKindOfClass:[NSArray class]] && _array.count > 0) {
            [_tempArray addObjectsFromArray:_array];
        }
        [_tempArray addObject:_dic];
        
        [[NSUserDefaults standardUserDefaults] setObject:_tempArray forKey:@"SubmitApplyList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"填写信息有误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_alertView show];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _applyType;
    
    _bgView1.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    _bgView2.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
    _bgView4.layer.borderColor = UIColorFromRGB(0xf2f2f2).CGColor;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
