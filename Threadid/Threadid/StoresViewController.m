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
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    storeNameArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty", @"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    storeImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg", @"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Stores";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return [storeNameArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoresViewCell *cell = [storesCollection dequeueReusableCellWithReuseIdentifier:@"StoresCell" forIndexPath:indexPath];
    
    cell.storeImageView.image = [UIImage imageNamed:[storeImgArray objectAtIndex:indexPath.row]];
    cell.storeNameLabel.text = [storeNameArray objectAtIndex:indexPath.row];
    
    return cell;
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
