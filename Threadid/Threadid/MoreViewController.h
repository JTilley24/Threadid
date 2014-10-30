//
//  MoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MoreViewController : UIViewController
{
    PFUser *current;
    PFObject *storeObj;
    IBOutlet UIButton *myStoreButton;
    IBOutlet UIButton *historyButton;
    IBOutlet UIButton *viewStoreButton;
    IBOutlet UIButton *openStoreButton;
    IBOutlet UILabel *userNameLabel;
    IBOutlet UILabel *storeNameLabel;
}

-(IBAction)onClick:(id)sender;
@end
