//
//  SalesHistoryViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *historyTable;
    NSArray *usersArray;
    NSArray *itemsArray;
    NSArray *dateArray;
    NSArray *totalArray;
}

@end
