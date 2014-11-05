//
//  FavoritesViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/22/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface FavoritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UICollectionView *favsCollection;
    NSMutableArray *favsArray;
    PFUser *current;
    NSArray *colorArray;
    PFObject *selectedObj;
    NSArray *storeNameArray;
    NSArray *storeImgArray;
}
@end
