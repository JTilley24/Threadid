//
//  AddSaleViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/20/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "AddSaleViewController.h"

@interface AddSaleViewController ()

@end

@implementation AddSaleViewController
@synthesize storeObj, editObj;

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
    saleButton2.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    saleButton2.titleLabel.textAlignment = NSTextAlignmentCenter;
    saleButton2.titleLabel.text = @"Buy One \n Get One";
    
    //Get Current Date and Set to button
    NSDate *current = [[NSDate alloc] init];
    [saleDatePicker setMinimumDate:current];
    saleDatePicker.timeZone = [NSTimeZone localTimeZone];
    NSDate *pickerDate = saleDatePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if(dateFormat != nil)
    {
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    NSString *dateText = [dateFormat stringFromDate:pickerDate];
    NSString *newDate = [[NSString alloc] initWithFormat:@"%@", dateText];
    [dateButton setTitle:newDate forState:UIControlStateNormal];
    saleDatePicker.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    itemsArray = storeObj[@"Items"];
    editObj = [storeObj[@"Sale"] fetchIfNeeded];
    if (editObj != nil) {
        [self editSale];
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
    return [itemsArray count];
}

//Add Items to Picker
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    PFObject *item = [[itemsArray objectAtIndex:row] fetchIfNeeded];
    label.text = item[@"Name"];
    return label;
}

//Set selection to button title
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(itemPicker.hidden == NO){
        PFObject *item = [[itemsArray objectAtIndex:row] fetchIfNeeded];
        selectedItem = item[@"Name"];
        selectedIndex = row;
        [itemButton setTitle:selectedItem forState:UIControlStateNormal];
    }else if (saleDatePicker.hidden == NO){
     
    }
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)saveToParse
{
    if(editObj != nil){
        if(editObj[@"Item"] != [itemsArray objectAtIndex:selectedIndex]){
            PFObject *tempItem = [editObj[@"Item"] fetchIfNeeded];
            [tempItem removeObjectForKey:@"Sale"];
            [tempItem saveInBackground];
        }
        editObj[@"Item"] = [itemsArray objectAtIndex:selectedIndex];
        editObj[@"Store"] = storeObj;
        editObj[@"Type"] = [NSString stringWithFormat:@"%d", typeint];
        editObj[@"Price"] = salePriceInput.text;
        editObj[@"Date"] = dateString;
        [editObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                storeObj[@"Sale"] = editObj;
                [storeObj saveInBackground];
                PFObject *item = [[itemsArray objectAtIndex:selectedIndex] fetchIfNeeded];
                item[@"Sale"] = editObj;
                [item saveInBackground];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        PFObject *sale = [PFObject objectWithClassName:@"Sale"];
        sale[@"Item"] = [itemsArray objectAtIndex:selectedIndex];
        sale[@"Store"] = storeObj;
        sale[@"Type"] = [NSString stringWithFormat:@"%d", typeint];
        sale[@"Price"] = salePriceInput.text;
        sale[@"Date"] = dateString;
        [sale saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                storeObj[@"Sale"] = sale;
                [storeObj saveInBackground];
                PFObject *item = [[itemsArray objectAtIndex:selectedIndex] fetchIfNeeded];
                item[@"Sale"] = sale;
                [item saveInBackground];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

-(void)editSale
{
    for(int i = 0; i < [itemsArray count]; i++){
        PFObject *tempItem = [[itemsArray objectAtIndex:i] fetchIfNeeded];
        PFObject *editItem = [editObj[@"Item"] fetchIfNeeded];
        if([tempItem[@"Name"] isEqualToString:editItem[@"Name"]]){
            selectedIndex = i;
            selectedItem = editItem[@"Name"];
            [itemButton setTitle:selectedItem forState:UIControlStateNormal];
        }
    }
    
    salePriceInput.text = editObj[@"Price"];
    int editType = [editObj[@"Type"] intValue];
    if(editType == 1){
        saleButton1.selected = YES;
        saleButton2.selected = NO;
        saleButton3.selected = NO;
        typeint = 1;
    }else if (editType == 2){
        saleButton2.selected = YES;
        saleButton1.selected = NO;
        saleButton3.selected = NO;
        typeint = 2;
    }else if(editType == 3){
        saleButton3.selected = YES;
        saleButton1.selected = NO;
        saleButton2.selected = NO;
        typeint = 3;
    }
    NSString *editDate = editObj[@"Date"];
    dateString = editDate;
    [dateButton setTitle:editDate forState:UIControlStateNormal];
}

//OnClick for item and date button and back navigation
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        if(itemPicker.hidden == NO){
            itemPicker.hidden = YES;
        }else if (saleDatePicker.hidden == NO){
            saleDatePicker.hidden = YES;
        }
        pickerToolbar.hidden = YES;
    }else if(button.tag == 1){
        if(itemPicker.hidden == YES){
            itemPicker.hidden = NO;
        }
        if (saleDatePicker.hidden == NO){
            saleDatePicker.hidden = YES;
        }
        pickerToolbar.hidden = NO;
    }else if(button.tag == 2){
        if(itemPicker.hidden == NO){
            itemPicker.hidden = YES;
        }
        if (saleDatePicker.hidden == YES){
            saleDatePicker.hidden = NO;
        }
        pickerToolbar.hidden = NO;
    }else if (button.tag == 3){
        [self saveToParse];
    }
}

//Toggle for Sale Type buttons
-(IBAction)onChange:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        saleButton1.selected = YES;
        saleButton2.selected = NO;
        saleButton3.selected = NO;
        typeint = 1;
    }else if (button.tag == 1){
        saleButton2.selected = YES;
        saleButton1.selected = NO;
        saleButton3.selected = NO;
        typeint = 2;
    }else if(button.tag == 2){
        saleButton3.selected = YES;
        saleButton1.selected = NO;
        saleButton2.selected = NO;
        typeint = 3;
    }
}

//Change button title to date
-(IBAction)onDateChanged:(id)sender
{
    NSDate *pickerDate = saleDatePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if(dateFormat != nil)
    {
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    NSString *dateText = [dateFormat stringFromDate:pickerDate];
    dateString = [[NSString alloc] initWithFormat:@"%@", dateText];
    [dateButton setTitle:dateString forState:UIControlStateNormal];
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
