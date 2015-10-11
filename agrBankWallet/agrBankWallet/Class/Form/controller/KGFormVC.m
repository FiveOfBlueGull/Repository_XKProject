//
//  KGFormVC.m
//  agrBankWallet
//
//  Created by Neely on 15/9/27.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGFormVC.h"
#import "AppointmentCell.h"
#import "SubmitApplyVC.h"
#import "KGSubmitVC.h"

@interface KGFormVC ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation KGFormVC

#pragma mark - Action
- (void)clickAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"PushSubmitApplyVC" sender:sender];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"预约";
    _dataArray = [NSMutableArray arrayWithObjects:@"预约存款", @"预约取款", @"预约咨询", nil];
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
    return 75;
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
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    NSString *_name = _dataArray[indexPath.row];
    [cell.nameBtn setTitle:_name forState:UIControlStateNormal];
    [cell.nameBtn setTitle:_name forState:UIControlStateHighlighted];
    cell.nameBtn.tag = 500 + indexPath.row;
    [cell.nameBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushSubmitApplyVC"]) {
        UIButton *_button = (UIButton *)sender;
       // SubmitApplyVC *_applyVC = segue.destinationViewController;
      //  _applyVC.applyType = _dataArray[_button.tag - 500];s
        KGSubmitVC *aVC = segue.destinationViewController;
        aVC.type =  (ApplyType)_button.tag - 500;

        
    }

//    KGSubmitVC *aVC = [[KGSubmitVC alloc] init];
//   aVC.type =  (ApplyType)_button.tag - 500;
//    self.navigationController
}

@end
