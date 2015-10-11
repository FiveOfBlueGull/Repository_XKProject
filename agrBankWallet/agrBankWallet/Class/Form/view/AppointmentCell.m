//
//  AppointmentCell.m
//  agrBankWallet
//
//  Created by guowenrui on 15/9/29.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "AppointmentCell.h"

@implementation AppointmentCell

- (void)awakeFromNib {
    // Initialization code
    _nameBtn.layer.borderColor = UIColorFromRGB(0xea8010).CGColor;
}
- (IBAction)btnAction:(id)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
