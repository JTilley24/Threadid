//
//  SalesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "SalesViewController.h"
#import "SalesCell.h"
#import "DetailViewController.h"

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
   
    salesArray = [[NSMutableArray alloc] init];
    
    //Get Current Sale Items
    PFQuery *query = [PFQuery queryWithClassName:@"Sale"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            for (int i = 0; i < [objects count]; i++) {
                PFObject *tempObj = [objects objectAtIndex:i];
                NSString *dateString = tempObj[@"Date"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                if(dateFormat != nil)
                {
                    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
                }
                NSDate *itemDate = [dateFormat dateFromString:dateString];
                NSDate *current = [[NSDate alloc] init];
                if([itemDate laterDate:current] == itemDate){
                    [salesArray addObject:tempObj];
                    
                }
            }
            [salesTable reloadData];
        }
    }];
    
    //Set Static Data and Images
    saleTypeArray = @[@"On Sale", @"Buy One, Get One", @"Clearence"];
    self.title = @"Sales and Discounts";
    
    self.navigationItem.backBarButtonItem.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributed
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:21],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of rows in Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [salesArray count];
}

//Add sale item Data and Image to Table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SalesCell *cell = [salesTable dequeueReusableCellWithIdentifier:@"SalesCell"];
    PFObject *saleObj = [[salesArray objectAtIndex:indexPath.row] fetchIfNeeded];
    PFObject *itemObj = [saleObj[@"Item"] fetchIfNeeded];
    PFObject *storeObj = [itemObj[@"Store"] fetchIfNeeded];
    cell.itemNameLabel.text = itemObj[@"Name"];
    cell.itemPriceLabel.text = saleObj[@"Price"];
    cell.storeLabel.text = storeObj[@"Name"];
    int typeInt = [saleObj[@"Type"] intValue] - 1;
    cell.saleTypeLabel.text = [saleTypeArray objectAtIndex:typeInt];
    cell.saleDateLabel.text = saleObj[@"Date"];
    PFFile *imageFile = [itemObj[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.saleItemImg.image = image;

    return cell;
}

//Navigate to Item Details
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *selectedSale = [[salesArray objectAtIndex:indexPath.row] fetchIfNeeded];
    PFObject *itemObject = [selectedSale[@"Item"] fetchIfNeeded];
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    [detailView setItemObj:itemObject];
    [self.navigationController pushViewController:detailView animated:YES];
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
