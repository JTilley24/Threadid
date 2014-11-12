//
//  AddItemViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/20/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface AddItemViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, iCarouselDelegate, iCarouselDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UIPickerView *catPicker;
    IBOutlet UITextField *itemNameInput;
    IBOutlet UITextField *itemPriceInput;
    IBOutlet UIToolbar *catPickerToolBar;
    IBOutlet UIButton *catButton;
    IBOutlet UIStepper *quantityStep;
    IBOutlet UILabel *quantityLabel;
    IBOutlet UIScrollView *itemScroll;
    IBOutlet iCarousel *picsCaro;
    IBOutlet UITextView *descriptView;
    NSMutableArray *picsArray;
    NSArray *catArray;
    NSString *catString;
    PFObject *storeObject;
    MBProgressHUD *loadingView;
    int selectedIndex;
}
@property (nonatomic, strong)PFObject *storeObj;
@property (nonatomic, strong)PFObject *editObject;
-(IBAction)onClick:(id)sender;
-(IBAction)onChanged:(id)sender;

@end
