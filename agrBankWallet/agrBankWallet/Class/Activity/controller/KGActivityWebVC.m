//
//  KGActivityWebVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/10/8.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGActivityWebVC.h"

@interface KGActivityWebVC ()

@property (weak, nonatomic) IBOutlet UIButton *receiveAction;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KGActivityWebVC
- (IBAction)receiveAction:(id)sender {
    NSMutableArray *_array = [NSMutableArray array];
    [_array addObjectsFromArray:[_targetObject objectForKey:@"received"]];
    [_array addObject:self.globalDataModel.userObjectID];
    [_targetObject setObject:_array forKey:@"received"];
    [_targetObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            _receiveAction.userInteractionEnabled = NO;
            _receiveAction.backgroundColor = UIColorFromRGB(0xffbd8c);
            [_receiveAction setTitle:@"已领取优惠劵" forState:UIControlStateNormal];
            [_receiveAction setTitleColor:UIColorFromRGB(0xf2f2f2) forState:UIControlStateNormal];
            UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"可前往【我的优惠券】查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [_alertView show];
        }
    }];
    AVObject *_object = [AVObject objectWithClassName:@"VoucherListClass"];
    [_object setObject:self.globalDataModel.userObjectID forKey:@"userInfoID"];
    [_object setObject:_targetObject.objectId forKey:@"activityInfoID"];
    [_object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = [_targetObject objectForKey:@"ActivityName"];
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    
    NSURL *_url = [NSURL URLWithString:[_targetObject objectForKey:@"webUrl"]];
    NSURLRequest *_request = [NSURLRequest requestWithURL:_url];
    [_webView loadRequest:_request];
    NSArray *_array = [_targetObject objectForKey:@"received"];
    if ([_array isKindOfClass:[NSArray class]] && _array.count > 0) {
        if ([_array containsObject:self.globalDataModel.userObjectID]) {
            _receiveAction.userInteractionEnabled = NO;
            _receiveAction.backgroundColor = UIColorFromRGB(0xffbd8c);
            [_receiveAction setTitle:@"已领取优惠劵" forState:UIControlStateNormal];
            [_receiveAction setTitleColor:UIColorFromRGB(0xf2f2f2) forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack
{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
