//
//  ListViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface ListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, iCarouselDataSource, iCarouselDelegate>
{
    NSArray *itemImgArray;
    NSArray *itemNameArray;
    NSArray *itemPriceArray;
    IBOutlet UICollectionView *itemsCollection;
    IBOutlet iCarousel *itemCaro;
    IBOutlet UISearchBar *itemSearch;
}

-(IBAction)onClick:(id)sender;

@end
