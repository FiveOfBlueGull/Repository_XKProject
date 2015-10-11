//
//  KGIntroQACell.h
//  agrBankWallet
//
//  Created by Neely on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height



typedef enum{
    
    CellTypeQuest = 0,
    CellTypeAnswer = 1
    
}CellType;

@interface KGIntroQACell : UITableViewCell

@property (nonatomic,strong) UILabel *aTitleLabel;

@property (nonatomic,assign) CellType aType;

@property (nonatomic,assign) CGFloat aHeight;

@property (nonatomic,assign) BOOL aIsSelect;

@property (nonatomic,strong) NSIndexPath *indexPath;


@end
