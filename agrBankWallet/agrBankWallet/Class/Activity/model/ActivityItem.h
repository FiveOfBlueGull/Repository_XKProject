//
//  ActivityItem.h
//  agrBankWallet
//
//  Created by guowenrui on 15/9/28.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItem : NSObject

@property (strong, nonatomic) NSString *picUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *activityID;

@end
