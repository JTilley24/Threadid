//
//  MoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "MoreViewController.h"
#import "StoreViewController.h"

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
    //Change font size by iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        fontSize = 12;
    }else
    {
        fontSize = 15;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    //Get User's Store Data
    current = [PFUser currentUser];
    PFQuery *storeQuery = [PFQuery queryWithClassName:@"Store"];
    [storeQuery whereKey:@"User" equalTo:current];
    [storeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            storeObj = [objects objectAtIndex:0];
        }
        [self loadUserData];
    }];
    
    //Set Navigation Bar attributes
    self.title = @"More";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:fontSize + 4],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Display User and Store Data
-(void)loadUserData
{
    userNameLabel.text = current[@"username"];
    if(storeObj != nil){
        storeNameLabel.text = storeObj[@"Name"];
        [myStoreButton setEnabled:YES];
        [viewStoreButton setEnabled:YES];
        [historyButton setEnabled:YES];
        [openStoreButton setEnabled:NO];
    }else{
        storeNameLabel.text = @"No Store";
        [myStoreButton setEnabled:NO];
        [viewStoreButton setEnabled:NO];
        [historyButton setEnabled:NO];
        [openStoreButton setEnabled:YES];
    }
}

//OnClick to navigate to corresponding view
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
        StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
        [storeView setStoreObj:storeObj];
        [self.navigationController pushViewController:storeView animated:YES];
    }else if(button.tag == 6){
        [PFUser logOut];
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
