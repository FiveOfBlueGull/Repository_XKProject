//
//  ActivityListcell.h
//  agrBankWallet
//
//  Created by guowenrui on 15/9/28.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityItem.h"

@interface ActivityListcell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@end
