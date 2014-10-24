//
//  StoresViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *storeNameArray;
    NSArray *storeImgArray;
    IBOutlet UICollectionView *storesCollection;
    IBOutlet UISearchBar *storeSearch;
}

-(IBAction)onClick:(id)sender;

@end
