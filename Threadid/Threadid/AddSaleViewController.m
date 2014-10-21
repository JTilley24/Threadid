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
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
 
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
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
