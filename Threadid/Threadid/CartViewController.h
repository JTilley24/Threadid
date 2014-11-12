//
//  CartViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *cartTable;
    IBOutlet UILabel *subLabel;
    IBOutlet UILabel *totalLabel;
    NSMutableArray *cartArray;
    PFUser *current;
    float taxNum;
    float totalNum;
    int selectedIndex;
    PFObject *storeObj;
    NSMutableArray *salesArray;
}

-(IBAction)onClick:(id)sender;

@end
