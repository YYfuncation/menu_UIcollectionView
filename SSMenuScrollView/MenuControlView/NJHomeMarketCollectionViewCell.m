//
//  NJHomeMarketCollectionViewCell.m
//  EnergyTransfer
//
//  Created by YY on 2018/11/26.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "NJHomeMarketCollectionViewCell.h"

@implementation NJHomeMarketCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 8;
    self.backgroundColor = [UIColor colorWithRed:251.0f/255.0f green:199.0f/255.0f blue:12.0f/255.0f alpha:1];
}

@end
