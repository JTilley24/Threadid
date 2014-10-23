//
//  StoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *itemsCollections;
    NSArray *itemImgArray;
    NSArray *itemNameArray;
    NSArray *itemPriceArray;
    IBOutlet UIBarButtonItem *favButton;
    int fontSize;
    BOOL fav;
}

-(IBAction)onClick:(id)sender;

@end
