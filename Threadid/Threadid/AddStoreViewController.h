//
//  AddStoreViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface AddStoreViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *storeNameInput;
    IBOutlet UISwitch *artisanSwitch;
    IBOutlet UIPickerView *storePicker;
    NSArray *fontArray;
    NSArray *colorArray;
    int fontSize;
    MBProgressHUD *loadingView;
}

@property (nonatomic, strong)NSString *selectedFont;
@property (nonatomic, strong)NSString *selectedFontColor;
@property (nonatomic, strong)NSString *selectedBGColor;
@property (nonatomic, strong)NSString *selectedString;
@property (nonatomic, strong)PFObject *storeObject;

-(IBAction)onClick:(id)sender;
-(IBAction)onBarButtonClick:(id)sender;
-(IBAction)onChanged:(id)sender;

@end
