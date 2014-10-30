//
//  AddSaleViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/20/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddSaleViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    IBOutlet UIDatePicker *saleDatePicker;
    IBOutlet UIButton *dateButton;
    NSString *dateString;
    IBOutlet UISegmentedControl *saleSegment;
    IBOutlet UIPickerView *itemPicker;
    IBOutlet UIToolbar *pickerToolbar;
    IBOutlet UIButton *saleButton1;
    IBOutlet UIButton *saleButton2;
    IBOutlet UIButton *saleButton3;
    IBOutlet UIButton *itemButton;
    IBOutlet UITextField *salePriceInput;
    NSArray *itemsArray;
    NSString *selectedItem;
    int selectedIndex;
    int typeint;
}

@property (nonatomic, strong)PFObject *storeObj;
@property (nonatomic, strong)PFObject *editObj;

-(IBAction)onClick:(id)sender;
-(IBAction)onChange:(id)sender;
-(IBAction)onDateChanged:(id)sender;

@end
