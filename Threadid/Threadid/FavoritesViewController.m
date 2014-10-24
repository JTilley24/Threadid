//
//  FavoritesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/22/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavsCell.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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
    storeNameArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    storeImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    
    //Add Long Press to Collection
    UILongPressGestureRecognizer *favPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteFavPress:)];
    favPress.minimumPressDuration = .5;
    favPress.delegate = self;
    favPress.delaysTouchesBegan = YES;
    [favsCollection addGestureRecognizer:favPress];
}

-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributes
    self.title = @"Favorites";
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

//Add store name and image to Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavsCell *cell = [favsCollection dequeueReusableCellWithReuseIdentifier:@"FavsCell" forIndexPath:indexPath];
    
    cell.storeImageView.image = [UIImage imageNamed:[storeImgArray objectAtIndex:indexPath.row]];
    cell.storeNameLabel.text = [storeNameArray objectAtIndex:indexPath.row];
    
    return cell;
}

//Navigate to Store View
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"FavStoreSegue" sender:self];
}

//Long press to Delete selected item
-(void)deleteFavPress:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state != UIGestureRecognizerStateEnded){
        return;
    }
    CGPoint point = [gesture locationInView:favsCollection];
    
    NSIndexPath *index = [favsCollection indexPathForItemAtPoint:point];
    if(index == nil){
        
    }else{
        UIAlertView *favAlert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
        [favAlert show];
    }
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
