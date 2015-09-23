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


//- (void)setHasFinishedIntroduction:(BOOL)hasFinishedIntroduction{
//    if (_hasFinishedIntroduction != hasFinishedIntroduction) {
//        _hasFinishedIntroduction = hasFinishedIntroduction;
//        [[NSUserDefaults standardUserDefaults] setBool:_hasFinishedIntroduction forKey:@"hasFinishedIntroduction"];
//    }
//}


@end
