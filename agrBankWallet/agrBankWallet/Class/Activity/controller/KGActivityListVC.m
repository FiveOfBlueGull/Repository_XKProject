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
#import "KGActivityWebVC.h"
#import "UIImageView+WebCache.h"

@interface KGActivityListVC ()

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KGActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"活动";
    _dataArray = [NSMutableArray array];
    AVQuery *users = [[AVQuery alloc] initWithClassName:@"ActivityClass"];
    [users findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [_dataArray addObjectsFromArray:objects];
            [_tableView reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"暂无活动" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
    if (_dataArray.count > indexPath.row) {
        AVObject *_object = _dataArray[indexPath.row];
        NSString *_content = [_object objectForKey:@"ActivityDescription"];
        
        cell.picture.contentMode = UIViewContentModeCenter;
        [cell.picture sd_setImageWithURL:[_object objectForKey:@"pictureUrl"] placeholderImage:[UIImage imageNamed:@"defaultMallImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                cell.picture.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
        cell.nameLabel.text = [_object objectForKey:@"ActivityName"];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        NSDictionary *attribues = @{ NSParagraphStyleAttributeName : paragraphStyle};
        cell.contentlabel.attributedText = [[NSAttributedString alloc] initWithString:_content
                                                                           attributes:attribues];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"PushActivityDetailVC" sender:indexPath];
    [self performSegueWithIdentifier:@"PushActivityWebVC" sender:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *_index = sender;
    if ([segue.identifier isEqualToString:@"PushActivityWebVC"]) {
        KGActivityWebVC *_detailVC = segue.destinationViewController;
        AVObject *_object = _dataArray[_index.row];
        _detailVC.name = [_object objectForKey:@"ActivityName"];
        _detailVC.webUrl = [_object objectForKey:@"webUrl"];
    }
}

@end
