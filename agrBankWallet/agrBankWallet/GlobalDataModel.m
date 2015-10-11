//
//  GlobalDataModel.m
//  autoresizingMaskText
//
//  Created by system on 15/4/13.
//  Copyright (c) 2015年 system. All rights reserved.
//

#import "GlobalDataModel.h"

@implementation GlobalDataModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self getInfoFromLocal];
    }
    return self;
}

+ (id)shareInstance{
    static GlobalDataModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalDataModel alloc] init];
    });
    return instance;
}

- (BOOL)isLogin{
    if (!self.userName) {
        return NO;
    }
    if ([self.userName isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)logout{
    self.userName = @"";
    self.userAccount = @"";
    self.userPassword = @"";
    self.userPhone = @"";
    self.userType = @(-1);
    self.userNick = @"";
    self.userObjectID = @"";
    [self saveInfoToLocal];
}

- (void)didLoginWithReturnInfo:(NSDictionary *)info{
    self.userName = info[@"userName"];
    self.userAccount = info[@"userAccount"];
    self.userPassword = info[@"userPassword"];
    self.userPhone = info[@"userPhone"];
    self.userType = info[@"userType"];
    self.userNick = info[@"userNick"];
    self.userObjectID = info[@"userObjectID"];
    [self saveInfoToLocal];
}

- (void)saveInfoToLocal{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userAccount forKey:@"userAccount"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userPassword forKey:@"userPassword"];

    [[NSUserDefaults standardUserDefaults] setObject:self.userPhone forKey:@"userPhone"];

    [[NSUserDefaults standardUserDefaults] setObject:self.userType forKey:@"userType"];

    [[NSUserDefaults standardUserDefaults] setObject:self.userNick forKey:@"userNick"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userObjectID forKey:@"userObjectID"];

}

- (void)getInfoFromLocal{
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    self.userAccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAccount"];

    self.userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];

    self.userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    self.userType = [[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    self.userNick = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    self.userObjectID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userObjectID"];



}

@end
