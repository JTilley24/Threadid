//
//  SalesViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *salesTable;
    NSArray *imgArray;
    NSArray *itemNameArray;
    NSArray *storeArray;
    NSArray *itemPriceArray;
    NSArray *saleTypeArray;
    NSArray *dateArray;
}

@end
