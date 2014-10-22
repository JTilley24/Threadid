//
//  CartViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *cartTable;
    IBOutlet UILabel *subLabel;
    IBOutlet UILabel *totalLabel;
    NSArray *itemImgArray;
    NSArray *itemNameArray;
    NSArray *itemPriceArray;
    NSArray *itemStoreArray;
    float taxNum;
    float totalNum;
}

@end
