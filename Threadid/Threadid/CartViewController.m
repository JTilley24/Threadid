//
//  CartViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "CartViewController.h"
#import "CartCell.h"

@interface CartViewController ()

@end

@implementation CartViewController

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
    
    //Set Static Data and Images
    itemImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    itemNameArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    itemPriceArray = @[@"$44.99", @"$9.99", @"$14.99"];
    itemStoreArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    totalNum = 74.52;
    taxNum = 4.55;
    totalLabel.text = [NSString stringWithFormat:@"$%.02f", totalNum];
    subLabel.text = [NSString stringWithFormat:@"$%.02f", taxNum];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributes
    self.title = @"My Cart";
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

//Number of rows in Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemNameArray count];
}

//Add items data to Table's cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartCell *cell = [cartTable dequeueReusableCellWithIdentifier:@"CartCell"];
    cell.itemImg.image = [UIImage imageNamed:[itemImgArray objectAtIndex:indexPath.row]];
    cell.itemNameLabel.text = [itemNameArray objectAtIndex:indexPath.row];
    cell.itemPriceLabel.text = [itemPriceArray objectAtIndex:indexPath.row];
    cell.itemQuantityLabel.text = @"1";
    cell.storeLabel.text = [itemStoreArray objectAtIndex:indexPath.row];
    return cell;
}

//Delete Alert for selected item
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *cartAlert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES", @"NO", nil];
    [cartAlert show];
}

//Checkout Alert for cart
-(IBAction)onClick:(id)sender
{
    UIAlertView *checkoutAlert = [[UIAlertView alloc] initWithTitle:@"Checkout" message:@"Checkout feature will be handled with third-party payment system. \n i.e PayPal" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [checkoutAlert show];
}

//Button click for Alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If No Button is Selected
    if([title isEqualToString:@"No"])
    {
       
    }
    //If Yes Button is Selected
    else if ([title isEqualToString:@"Yes"])
    {
        
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
