//
//  StoreViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCollectionCell.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

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
    itemImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    itemNameArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    itemPriceArray = @[@"$44.99", @"$9.99", @"$14.99"];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        fontSize = 20;
    }else
    {
        fontSize = 15;
    }
    self.title = @"Betty's Bags";
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Noteworthy" size:21],
      NSFontAttributeName,[UIColor greenColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    fav = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return [itemNameArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCollectionCell *cell = [itemsCollections dequeueReusableCellWithReuseIdentifier:@"StoreCollectionCell" forIndexPath:indexPath];
    
    cell.itemImg.image = [UIImage imageNamed:[itemImgArray objectAtIndex:indexPath.row]];
    cell.itemNameLabel.text = [itemNameArray objectAtIndex:indexPath.row];
    cell.itemNameLabel.font = [UIFont fontWithName:@"Noteworthy" size:fontSize];
    [cell.itemNameLabel setTextColor:[UIColor greenColor]];
    cell.itemPriceLabel.text = [itemPriceArray objectAtIndex:indexPath.row];
    cell.itemPriceLabel.font = [UIFont fontWithName:@"Noteworthy" size:fontSize];
    [cell.itemPriceLabel setTextColor:[UIColor greenColor]];
    [cell.itemPriceLabel setBackgroundColor:[UIColor orangeColor]];
    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"StoreSelectSegue" sender:self];
}

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
