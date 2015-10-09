//
//  KGActivityWebVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/10/8.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGActivityWebVC.h"

@interface KGActivityWebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KGActivityWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = _name;
    
    NSURL *_url = [NSURL URLWithString:_webUrl];
    NSURLRequest *_request = [NSURLRequest requestWithURL:_url];
    [_webView loadRequest:_request];
    _webView.scalesPageToFit = YES;
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
