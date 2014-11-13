//
//  DetailViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, UIAlertViewDelegate>
{
    IBOutlet iCarousel *itemImgCaro;
    IBOutlet UILabel *itemNameLabel;
    IBOutlet UILabel *itemPriceLabel;
    IBOutlet UILabel *itemQuantityLabel;
    IBOutlet UILabel *itemDesciption;
    IBOutlet UIButton *storeButton;
    NSArray *photosArray;
    NSArray *fontArray;
    NSArray *colorArray;
    PFObject *storeObj;
    PFUser *current;
    int fontSize;
}

@property (nonatomic, strong)PFObject *itemObj;

-(IBAction)onClick:(id)sender;

@end
