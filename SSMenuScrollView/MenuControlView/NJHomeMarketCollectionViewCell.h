//
//  NJHomeMarketCollectionViewCell.h
//  EnergyTransfer
//
//  Created by YY on 2018/11/26.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJHomeMarketCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *centerImg;
@property (weak, nonatomic) IBOutlet UILabel *centerLab;

@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@end
