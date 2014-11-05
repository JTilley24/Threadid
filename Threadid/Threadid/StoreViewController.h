//
//  StoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface StoreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *itemsCollections;
    PFUser *current;
    NSArray *fontArray;
    NSArray *colorArray;
    NSArray *itemsArray;
    UIColor *fontColor;
    UIColor *bgColor;
    IBOutlet UIBarButtonItem *favButton;
    int fontSize;
    BOOL fav;
    NSMutableArray *favsArray;
}
@property (nonatomic, strong) PFObject *storeObj;

-(IBAction)onClick:(id)sender;

@end
