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
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana Bold"];
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


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

-(IBAction)onBarButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
