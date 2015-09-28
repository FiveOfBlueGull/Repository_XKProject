//
//  KGActivityListVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/9/28.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGActivityListVC.h"
#import "ActivityListcell.h"
#import "KGActivityDetailVC.h"
#import "KGCommonBaseNVC.h"

@interface KGActivityListVC ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation KGActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"活动";
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
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
    ActivityListcell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityListcell" forIndexPath:indexPath];
    
    NSString *_content = @"活动简介免费获取活动简介免费获取活动简介免费获取活动简介";
    
    cell.picture.contentMode = UIViewContentModeCenter;
    cell.picture.image = [UIImage imageNamed:@"defaultMallImage"];
    cell.nameLabel.text = @"活动名称";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    NSDictionary *attribues = @{ NSParagraphStyleAttributeName : paragraphStyle};
    cell.contentlabel.attributedText = [[NSAttributedString alloc] initWithString:_content
                                                          attributes:attribues];
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
