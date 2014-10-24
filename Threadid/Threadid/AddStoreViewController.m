//
//  AddStoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "AddStoreViewController.h"

@interface AddStoreViewController ()

@end

@implementation AddStoreViewController
@synthesize selectedFont, selectedFontColor, selectedBGColor, selectedString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana Bold"];
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
    
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        fontSize = 20;
    }else{
        fontSize = 25;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of components in Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//Number of items in Picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([selectedString isEqualToString:@"font"]){
        return [fontArray count];
    }else if ([selectedString isEqualToString:@"fontcolor"]){
        return [colorArray count];
    }else if ([selectedString isEqualToString:@"bgcolor"]){
        return [colorArray count];
    }
    return 0;
}

//Add name, font color, or background color to item in Picker
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    if([selectedString isEqualToString:@"font"]){
        NSString *fontString = [fontArray objectAtIndex:row];
        label.font = [UIFont fontWithName:fontString size:fontSize];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = fontString;
        if(selectedBGColor != nil){
            label.backgroundColor = selectedBGColor;
        }
        if(selectedFontColor != nil){
            label.textColor = selectedFontColor;
        }
    }else if ([selectedString isEqualToString:@"fontcolor"]){
        if(selectedFont != nil){
            NSString *fontString = selectedFont;
            label.font = [UIFont fontWithName:fontString size:fontSize];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = fontString;
        }else{
            label.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"Color";
        }
        label.textColor = [colorArray objectAtIndex:row];
        if(selectedBGColor != nil){
            label.backgroundColor = selectedBGColor;
        }
    }else if ([selectedString isEqualToString:@"bgcolor"]){
        if(selectedFont != nil){
            NSString *fontString = selectedFont;
            label.font = [UIFont fontWithName:fontString size:fontSize];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = fontString;
        }else{
            label.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"Color";
        }
        label.backgroundColor = [colorArray objectAtIndex:row];
        if(selectedFontColor != nil){
            label.textColor = selectedFontColor;
        }

    }
    return label;
}

//Set user selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([selectedString isEqualToString:@"font"]){
        selectedFont = [fontArray objectAtIndex:row];
    }else if([selectedString isEqualToString:@"fontcolor"]){
        selectedFontColor = [colorArray objectAtIndex:row];
    }else if ([selectedString isEqualToString:@"bgcolor"]){
        selectedBGColor = [colorArray objectAtIndex:row];
    }
}

//Switch for Artisan
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If No Button is Selected
    if([title isEqualToString:@"No"])
    {
        [artisanSwitch setOn:NO animated:YES];
    }
    //If Yes Button is Selected
    else if ([title isEqualToString:@"Yes"])
    {
        [artisanSwitch setOn:YES animated:YES];
    }
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

//OnClick for font, font color, and background color buttons
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    
    if(button.tag == 0)
    {
        selectedString = @"font";
        [storePicker reloadAllComponents];
    }else if (button.tag == 1)
    {
        selectedString = @"fontcolor";
        [storePicker reloadAllComponents];
    }else if (button.tag == 2)
    {
        selectedString = @"bgcolor";
        [storePicker reloadAllComponents];
    }
}

//Go back
-(IBAction)onBarButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Display Confirmation Alert
-(IBAction)onChanged:(id)sender
{
    if([artisanSwitch isOn]){
         UIAlertView *artisanAlert = [[UIAlertView alloc] initWithTitle:@"Artisan" message:@"This membership will result in a $1.99 monthly recurring charge. \n Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        [artisanAlert show];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
