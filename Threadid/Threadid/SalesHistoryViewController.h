//
//  SalesHistoryViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SalesHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *historyTable;
    NSArray *historyArray;
    PFUser *current;
    PFObject *storeObj;
}

@end
