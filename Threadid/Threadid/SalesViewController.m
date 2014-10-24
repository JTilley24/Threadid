//
//  SalesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "SalesViewController.h"
#import "SalesCell.h"

@interface SalesViewController ()

@end

@implementation SalesViewController

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
    storeArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    imgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    itemNameArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    itemPriceArray = @[@"$24.99", @"$9.99", @"$7.99"];
    saleTypeArray = @[@"On Sale", @"Buy One, Get One", @"Clearence"];
    dateArray = @[@"Oct 26, 2014", @"Oct 28, 2014", @"Nov 3, 2014"];
    self.title = @"Sales and Discounts";
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

//Add sale item Data and Image to Table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SalesCell *cell = [salesTable dequeueReusableCellWithIdentifier:@"SalesCell"];
    cell.saleItemImg.image = [UIImage imageNamed:[imgArray objectAtIndex:indexPath.row]];
    cell.itemNameLabel.text = [itemNameArray objectAtIndex:indexPath.row];
    cell.itemPriceLabel.text = [itemPriceArray objectAtIndex:indexPath.row];
    cell.storeLabel.text = [storeArray objectAtIndex:indexPath.row];
    cell.saleTypeLabel.text = [saleTypeArray objectAtIndex:indexPath.row];
    cell.saleDateLabel.text = [dateArray objectAtIndex:indexPath.row];
    
    return cell;
}

//Navigate to Item Details
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"SaleItemSegue" sender:self];
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
