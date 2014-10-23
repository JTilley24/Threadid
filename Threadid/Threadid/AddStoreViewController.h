//
//  AddStoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStoreViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UITextField *storeNameInput;
    IBOutlet UISwitch *artisanSwitch;
    IBOutlet UIPickerView *storePicker;
    NSArray *fontArray;
    NSArray *colorArray;
    int fontSize;
}

@property (nonatomic, strong)NSString *selectedFont;
@property (nonatomic, strong)UIColor *selectedFontColor;
@property (nonatomic, strong)UIColor *selectedBGColor;
@property (nonatomic, strong)NSString *selectedString;

-(IBAction)onClick:(id)sender;
-(IBAction)onBarButtonClick:(id)sender;
-(IBAction)onChanged:(id)sender;

@end
