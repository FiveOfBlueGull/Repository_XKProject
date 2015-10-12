//
//  FormModel.h
//  agrBankWallet
//
//  Created by Neely on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormModel : NSObject

@property (nonatomic,strong) NSString *aName;
@property (nonatomic,strong) NSString *aPhoneNum;
@property (nonatomic,strong) NSString *aIdCard;
@property (nonatomic,strong) NSString *aAddress;
@property (nonatomic,strong) NSString *aFormType; //0 取款  1 存款 2咨询


@property (nonatomic,strong) NSString *aMoney; //存款金额 , 或者取款金额
@property (nonatomic,strong) NSString *aDeterm; //存期
@property (nonatomic,strong) NSString *aWay; //支取方式


@property (nonatomic,strong) NSString *aDate; //取款日期
@property (nonatomic,strong) NSString *aZone; //取款网点


@property (nonatomic,strong) NSString *aItem; //咨询项目 



- (void)setValuesWithDictinoary:(NSDictionary *)dic;


@end
