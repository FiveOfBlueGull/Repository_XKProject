//
//  KGIntroDetailVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//



#import "KGIntroDetailVC.h"
#import "KGIntroQuestVC.h"


#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height


@interface KGIntroDetailVC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) UIButton *aButton;

@end

@implementation KGIntroDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
 
    [self.view addSubview:self.aButton];
}

#pragma mark- getter -- 

- (UIWebView *)webView{
    
    if (!_webView ) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49)];
        _webView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _webView.scalesPageToFit = YES;
        _webView.delegate =  self;
//        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webView;
}

- (UIButton *)aButton{
    
    
    if (!_aButton) {
        _aButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        
        _aButton.frame  = CGRectMake(0, self.view.frame.size.height - 40 - 49, ScreenWidth, 40);
        _aButton.backgroundColor = [UIColor orangeColor];
        [_aButton setTitle:@"答题赢取积分" forState:UIControlStateNormal];
        [_aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(aBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aButton;
}

#pragma  mark - Action - 
- (void)aBtnAction:(UIButton *)sender{
    
    KGIntroQuestVC *questVC = [[KGIntroQuestVC alloc] init];
    questVC.introId = self.introId;
    [self.navigationController pushViewController:questVC animated:YES];
    
    NSLog(@"回答 问题");
}

#pragma mark - delegate - 

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
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
