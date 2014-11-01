//
//  MyStoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "MyStoreViewController.h"
#import "MyStoreCell.h"
#import "AddStoreViewController.h"
#import "DetailViewController.h"
#import "AddItemViewController.h"
#import "AddSaleViewController.h"

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
    storeObject = [current[@"Store"] fetchIfNeeded];
    self.title = storeObject[@"Name"];
    if(storeObject[@"Items"] != nil){
        [self getStoreItems];
    }
    
    itemsArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(storeObject != nil){
        [self getStoreItems];
    }
    
    //Set Navigation Bar attributes
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

//Number of items in Collection
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return [itemsArray count];
}

//Add Item's Data in Collection
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

//Open Menu for View, Edit, and Delete
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *itemAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"View Item", @"Edit Item", @"Delete Item", nil];
    [itemAlert show];
    selectedItem = (int)indexPath.row;
}

//Get Items for Stores
-(void)getStoreItems
{
    PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery whereKey:@"Store" equalTo:storeObject];
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            itemsArray = (NSMutableArray*) objects;
            if(storeObject[@"Items"] != itemsArray){
                storeObject[@"Items"] = itemsArray;
                [storeObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                }];
            }
            [itemsCollection reloadData];
        }
    }];
}

//Delete Item
-(void)deleteItem
{
    PFObject *item = [itemsArray objectAtIndex:selectedItem];
    [itemsArray removeObjectAtIndex:selectedItem];
    [item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            storeObject[@"Items"] = itemsArray;
            [storeObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [itemsCollection reloadData];
                }
            }];
        }
    }];
}

//Open Sales History, Sales, and Add Item
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        [self performSegueWithIdentifier:@"StoreSalesSegue" sender:self];
    }else if(button.tag == 1){
        AddSaleViewController *addSale = [self.storyboard instantiateViewControllerWithIdentifier:@"AddSale"];
        [addSale setStoreObj:storeObject];
        [self.navigationController pushViewController:addSale animated:YES];

    }else if (button.tag == 2){
        [self performSegueWithIdentifier:@"AddItemSegue" sender:self];
    }
}

//Edit Store
-(IBAction)onBarButtonClick:(id)sender
{
    AddStoreViewController *addStore = [self.storyboard instantiateViewControllerWithIdentifier:@"AddStore"];
    [addStore setStoreObject:storeObject];
    [self.navigationController pushViewController:addStore animated:YES];
}

//Options of View, Edit, and Delete
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If View Button is Selected
    if([title isEqualToString:@"View Item"])
    {
            DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
            [detailView setItemObj:[itemsArray objectAtIndex:selectedItem]];
            [self.navigationController pushViewController:detailView animated:YES];
        
    }
    //If Edit Button is Selected
    else if ([title isEqualToString:@"Edit Item"])
    {
        AddItemViewController *editItemView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddItem"];
        [editItemView setEditObject:[itemsArray objectAtIndex:selectedItem]];
        [self.navigationController pushViewController:editItemView animated:YES];
    }
    
    else if ([title isEqualToString:@"Delete Item"])
    {
        [self deleteItem];
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
