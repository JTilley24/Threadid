//
//  FavoritesViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/22/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UICollectionView *favsCollection;
    NSArray *storeNameArray;
    NSArray *storeImgArray;
}
@end
