//
//  StoreCollectionCell.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCollectionCell : UICollectionViewCell
{
    
}

@property (nonatomic, strong) IBOutlet UIImageView *itemImg;
@property (nonatomic, strong) IBOutlet UILabel *itemNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *itemPriceLabel;

@end
