//
//  AddItemViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/20/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface AddItemViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, iCarouselDelegate, iCarouselDataSource>
{
    IBOutlet UIPickerView *catPicker;
    IBOutlet UIToolbar *catPickerToolBar;
    IBOutlet UIButton *catButton;
    IBOutlet UIStepper *quantityStep;
    IBOutlet UILabel *quantityLabel;
    IBOutlet iCarousel *picsCaro;
    NSArray *catArray;
    NSString *catString;
}

-(IBAction)onClick:(id)sender;
-(IBAction)onChanged:(id)sender;

@end
