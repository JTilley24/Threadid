//
//  StoresViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "StoresViewController.h"
#import "StoresViewCell.h"
#import "StoreViewController.h"

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
    
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana Bold"];
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    //Get Stores from Parse
    storesArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Store"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            for (int i = 0; i < [objects count]; i++) {
                PFObject *store = [objects objectAtIndex:i];
                if([store[@"Items"] count] != 0){
                    [storesArray addObject:store];
                }
            }
            [storesCollection reloadData];
        }
    }];
    
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
    
    return [storesArray count];
}

//Add image and name for each store to Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoresViewCell *cell = [storesCollection dequeueReusableCellWithReuseIdentifier:@"StoresCell" forIndexPath:indexPath];
    PFObject *object = [storesArray objectAtIndex:indexPath.row];
    NSArray *itemArray = object[@"Items"];
    PFObject *itemObj = [[itemArray objectAtIndex:0] fetchIfNeeded];
    PFFile *imageFile = [itemObj[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.storeImageView.image = image;
    cell.storeNameLabel.text = object[@"Name"];
    cell.storeNameLabel.backgroundColor = [colorArray objectAtIndex:[object[@"BGColor"] intValue]];
    cell.storeNameLabel.textColor = [colorArray objectAtIndex:[object[@"FontColor"] intValue]];
    cell.storeNameLabel.font = [UIFont fontWithName:object[@"Font"] size:15.0f];
    return cell;
}

//Select store from Collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
    [storeView setStoreObj:[storesArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:storeView animated:YES];
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
