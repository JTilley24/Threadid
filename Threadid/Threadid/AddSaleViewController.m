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
    
    itemsArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    
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
    return [itemsArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [itemsArray objectAtIndex:row];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(itemPicker.hidden == NO){
        selectedItem = [itemsArray objectAtIndex:row];
        [itemButton setTitle:selectedItem forState:UIControlStateNormal];
    }else if (saleDatePicker.hidden == NO){
     
    }
    
}

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
    }
}

-(IBAction)onChange:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        saleButton1.selected = YES;
        saleButton2.selected = NO;
        saleButton3.selected = NO;
    }else if (button.tag == 1){
        saleButton2.selected = YES;
        saleButton1.selected = NO;
        saleButton3.selected = NO;
    }else if(button.tag == 2){
        saleButton3.selected = YES;
        saleButton1.selected = NO;
        saleButton2.selected = NO;
    }
}

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
