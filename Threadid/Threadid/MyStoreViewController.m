//
//  MyStoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "MyStoreViewController.h"
#import "MyStoreCell.h"
@interface MyStoreViewController ()

@end

@implementation MyStoreViewController

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
    PFUser *current = [PFUser currentUser];
    PFQuery *storeQuery = [PFQuery queryWithClassName:@"Store"];
    [storeQuery whereKey:@"User" equalTo:current];
    [storeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            storeObject = [objects objectAtIndex:0];
            [self getStoreItems];
        }
    }];
    itemsArray = [[NSMutableArray alloc] init];
    itemImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    itemNameArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    itemPriceArray = @[@"$44.99", @"$9.99", @"$14.99"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return [itemsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyStoreCell *cell = [itemsCollection dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    PFObject *object = [itemsArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [object[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.itemImg.image = image;
    cell.nameLabel.text = object[@"Name"];
    cell.priceLabel.text = object[@"Price"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *itemAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"View Item", @"Edit Item", @"Delete Item", nil];
    [itemAlert show];
}

-(void)getStoreItems
{
    PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery whereKey:@"Store" equalTo:storeObject];
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            itemsArray = (NSMutableArray*) objects;
            [itemsCollection reloadData];
        }
    }];
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        [self performSegueWithIdentifier:@"StoreSalesSegue" sender:self];
    }else if(button.tag == 1){
        [self performSegueWithIdentifier:@"AddSaleSegue" sender:self];
    }else if (button.tag == 2){
        [self performSegueWithIdentifier:@"AddItemSegue" sender:self];
    }
}

-(IBAction)onBarButtonClick:(id)sender
{
    [self performSegueWithIdentifier:@"EditStoreSegue" sender:self];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If View Button is Selected
    if([title isEqualToString:@"View Item"])
    {
        [self performSegueWithIdentifier:@"MyItemSegue" sender:self];
    }
    //If Edit Button is Selected
    else if ([title isEqualToString:@"Edit Item"])
    {
        [self performSegueWithIdentifier:@"AddItemSegue" sender:self];
    }
    
    else if ([title isEqualToString:@"Delete Item"])
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
