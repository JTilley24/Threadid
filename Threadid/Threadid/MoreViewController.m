//
//  MoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"More";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:21],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender;
{
    UIButton *button = sender;
    if(button.tag == 0){
        [self performSegueWithIdentifier:@"CartSegue" sender:self];
    }else if(button.tag == 1){
        [self performSegueWithIdentifier:@"FavsSegue" sender:self];
    }else if(button.tag == 2){
        [self performSegueWithIdentifier:@"OpenStoreSegue" sender:self];
    }else if (button.tag == 3){
        [self performSegueWithIdentifier:@"MyStoreSegue" sender:self];
    }else if(button.tag == 4){
        [self performSegueWithIdentifier:@"MoreSalesSegue" sender:self];
    }else if(button.tag == 5){
        [self performSegueWithIdentifier:@"MoreStoreSegue" sender:self];
    }else if(button.tag == 6){
        [self performSegueWithIdentifier:@"SignOutSegue" sender:self];
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
