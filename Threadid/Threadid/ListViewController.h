//
//  ListViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <Parse/Parse.h>

@interface ListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, iCarouselDataSource, iCarouselDelegate, UISearchBarDelegate>
{
    NSArray *itemsArray;
    NSArray *fontArray;
    NSArray *colorArray;
    int fontSize;
    IBOutlet UICollectionView *itemsCollection;
    IBOutlet iCarousel *itemCaro;
    IBOutlet UISearchBar *itemSearch;
    BOOL searchMode;
    NSMutableArray *searchedArray;
}
@property (nonatomic, strong)NSString *catString;

-(IBAction)onClick:(id)sender;

@end
