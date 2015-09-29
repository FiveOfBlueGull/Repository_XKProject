//
//  KGActivityDetailVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/9/28.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGActivityDetailVC.h"

@interface KGActivityDetailVC ()

@end

@implementation KGActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"活动详情";
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_contentStr = @"      啊实打实大师和环境和，撒打算打算，实打实大师大师。大大声的撒，自行车自行车自行车下载最新，是的范德萨范德萨。";
    if (indexPath.row % 2 == 1) {
        UITextView *textView = [[UITextView alloc] initWithFrame: CGRectZero];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]};
        textView.attributedText = [[NSAttributedString alloc] initWithString:_contentStr attributes:attributes];
        CGSize textSize = [textView sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
        return textSize.height;
    } else {
        return 100;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if (indexPath.row % 2 == 1) {
        NSString *_contentStr = @"      啊实打实大师和环境和，撒打算打算，实打实大师大师。大大声的撒，自行车自行车自行车下载最新，是的范德萨范德萨。";
        UITextView *textView = [[UITextView alloc] initWithFrame: CGRectZero];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]};
        textView.attributedText = [[NSAttributedString alloc] initWithString:_contentStr attributes:attributes];
        //高度计算
        CGSize textSize = [textView sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)];

        textView.backgroundColor = [UIColor clearColor];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, textSize.height);
        [cell.contentView addSubview:textView];
    } else {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 100)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:@"defaultMallImage"];
        [cell.contentView addSubview:imageView];
    }
    return cell;
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
