//
//  MyAppointmentVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/10/10.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "MyAppointmentVC.h"
#import "MyAppointmentCell.h"

@interface MyAppointmentVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MyAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"我的预约";
    
    _dataArray = [NSMutableArray array];
    NSArray *_array = [[NSUserDefaults standardUserDefaults] objectForKey:@"SubmitApplyList"];
    if ([_array isKindOfClass:[NSArray class]] && _array.count > 0) {
        [_dataArray addObjectsFromArray:_array];
    }
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
    return 145;
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
    MyAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAppointmentCell" forIndexPath:indexPath];
    if (indexPath.row < _dataArray.count) {
        NSDictionary *_dic = _dataArray[indexPath.row];
        cell.orderNumber.text = [_dic objectForKey:@"orderNum"];
        cell.typeLabel.text = [_dic objectForKey:@"applyType"];
        cell.phoneLabel.text = [_dic objectForKey:@"phoneNum"];
        cell.postcardLabel.text = [_dic objectForKey:@"pstcard"];
        cell.timeLabel.text = [_dic objectForKey:@"outTime"];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消预约";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:@"SubmitApplyList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
