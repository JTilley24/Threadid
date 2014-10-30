//
//  StoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCollectionCell.h"
#import "DetailViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize storeObj;
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

    fav = false;
    
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana Bold"];
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
    
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
    itemsArray = storeObj[@"Items"];
    fontColor = [colorArray objectAtIndex:[storeObj[@"FontColor"] intValue]];
    bgColor = [colorArray objectAtIndex:[storeObj[@"BGColor"] intValue]];
    
    //Set Navigation Bar attributes
    self.title = storeObj[@"Name"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:storeObj[@"Font"] size:21],
      NSFontAttributeName,fontColor,NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [itemsCollections reloadData];

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

//Add image, name, and price for each item in Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCollectionCell *cell = [itemsCollections dequeueReusableCellWithReuseIdentifier:@"StoreCollectionCell" forIndexPath:indexPath];
    PFObject *item = [[itemsArray objectAtIndex:indexPath.row] fetchIfNeeded];
    PFFile *imageFile = [item[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.itemImg.image = image;
    cell.itemNameLabel.text = item[@"Name"];
    cell.itemPriceLabel.text = item[@"Price"];
    cell.itemNameLabel.font = [UIFont fontWithName:storeObj[@"Font"] size:fontSize];
    [cell.itemNameLabel setTextColor:fontColor];
    cell.itemPriceLabel.font = [UIFont fontWithName:storeObj[@"Font"] size:fontSize];
    [cell.itemPriceLabel setTextColor:fontColor];
    [cell.itemPriceLabel setBackgroundColor:bgColor];
    [cell setBackgroundColor:bgColor];
    return cell;
}

//Select for items in Collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    [detailView setItemObj:[itemsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailView animated:YES];
}

//Toggle Favorites Button
-(IBAction)onClick:(id)sender
{
    if(fav == false){
        favButton.image = [UIImage imageNamed:@"starred-icon.png"];
        fav = true;
    }else{
        favButton.image = [UIImage imageNamed:@"star-icon.png"];
        fav = false;
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
