//
//  MyAppointmentCell.h
//  agrBankWallet
//
//  Created by guowenrui on 15/10/10.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcardLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
