//
//  MyStoreCell.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStoreCell : UICollectionViewCell
{
    
}
@property (nonatomic, strong)IBOutlet UIImageView *itemImg;
@property (nonatomic, strong)IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)IBOutlet UILabel *priceLabel;

@end

