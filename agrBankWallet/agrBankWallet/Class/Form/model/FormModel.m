//
//  FormModel.m
//  agrBankWallet
//
//  Created by Neely on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "FormModel.h"

@implementation FormModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.aName = @"";
        self.aPhoneNum = @"";
        self.aIdCard = @"";
        self.aAddress = @"";
    }
    return self;
}


@end