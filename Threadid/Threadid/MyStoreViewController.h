//
//  MyStoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MyStoreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UICollectionView *itemsCollection;
    PFObject *storeObject;
    NSMutableArray *itemsArray;
    int selectedItem;
}

-(IBAction)onClick:(id)sender;
-(IBAction)onBarButtonClick:(id)sender;

@end
