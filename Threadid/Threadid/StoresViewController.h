//
//  StoresViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface StoresViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *storesArray;
    NSArray *fontArray;
    NSArray *colorArray;
    IBOutlet UICollectionView *storesCollection;
    IBOutlet UISearchBar *storeSearch;
}

-(IBAction)onClick:(id)sender;

@end
