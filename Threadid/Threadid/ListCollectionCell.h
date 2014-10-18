//
//  ListCollectionCell.h
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCollectionCell : UICollectionViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UIImageView *itemImgView;
@property (nonatomic, strong) IBOutlet UILabel *itemNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *itemPriceLabel;

@end
