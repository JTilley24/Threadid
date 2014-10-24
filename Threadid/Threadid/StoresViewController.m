//
//  StoresViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "StoresViewController.h"
#import "StoresViewCell.h"

@interface StoresViewController ()

@end

@implementation StoresViewController

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
    //Set Navigation Bar attributes
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //Set Static Data and Images
    storeNameArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty", @"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    storeImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg", @"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
}

-(void)viewWillAppear:(BOOL)animated
{
     //Set Navigation Bar attributes
    self.title = @"Stores";
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
    
    return [storeNameArray count];
}

//Add image and name for each store to Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoresViewCell *cell = [storesCollection dequeueReusableCellWithReuseIdentifier:@"StoresCell" forIndexPath:indexPath];
    
    cell.storeImageView.image = [UIImage imageNamed:[storeImgArray objectAtIndex:indexPath.row]];
    cell.storeNameLabel.text = [storeNameArray objectAtIndex:indexPath.row];
    
    return cell;
}

//Select store from Collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"StoreSegue" sender:self];
}

//Toggle Search bar
-(IBAction)onClick:(id)sender
{
    if(storeSearch.hidden == YES){
        storeSearch.hidden = NO;
    }else{
        storeSearch.hidden = YES;
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
