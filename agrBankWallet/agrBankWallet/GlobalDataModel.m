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

- (void)compareUserAccoutRemainWithCost:(NSInteger)cost
                    moreOrEqualThanCost:(void (^)())success_more
                           lessThanCost:(void (^)())success_less
                         requestFailure:(void (^)())failure{
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [query whereKey:@"objectId" equalTo:self.userObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count] > 0) {
            AVObject *user = [objects firstObject];
            NSNumber *accountUserHas = user[@"userAccount"];
            if ([accountUserHas integerValue] < cost) {
                if (success_less) {
                    success_less();
                }
            }else{
                if (success_more) {
                    success_more();
                }
            }
        }else{
            if (failure) {
                failure();
            }
        }
    }];
}

- (void)reduceUserAccountWithCost:(NSInteger)cost
                          success:(void (^)())success
                    reduceFailure:(void (^)())reduceFailure
                   requestFailure:(void (^)())requestFailure{
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [query whereKey:@"objectId" equalTo:self.userObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count] > 0) {
            AVObject *user = [objects firstObject];
            NSString *accountUserHas = user[@"userAccount"];
            NSInteger remain = [accountUserHas integerValue] - cost;
            [user setObject:[@(remain) description] forKey:@"userAccount"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (success) {
                        success();
                    }
                }else{
                    if (reduceFailure) {
                        reduceFailure();
                    }
                }
            }];
        }else{
            if (requestFailure) {
                requestFailure();
            }
        }
    }];
}

@end
