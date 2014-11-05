//
//  FavoritesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/22/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavsCell.h"
#import "StoreViewController.h"

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
    
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
    
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
    
    current = [PFUser currentUser];
    
    favsArray = current[@"Favorites"];
    [favsCollection reloadData];
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
    
    return [favsArray count];
}

//Add store name and image to Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavsCell *cell = [favsCollection dequeueReusableCellWithReuseIdentifier:@"FavsCell" forIndexPath:indexPath];
    
    PFObject *object = [[favsArray objectAtIndex:indexPath.row] fetchIfNeeded];
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

//Navigate to Store View
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
    [storeView setStoreObj:[favsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:storeView animated:YES];
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
        selectedObj = [favsArray objectAtIndex:index.row];
        UIAlertView *favAlert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
        [favAlert show];
    }
}

//Button click for Alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If Yes Button is Selected
    if ([title isEqualToString:@"Yes"])
    {
        favsArray = current[@"Favorites"];
        if([favsArray count] != 0){
            for (int i = 0; i < [favsArray count]; i++) {
                PFObject *favObject = [[favsArray objectAtIndex:i] fetchIfNeeded];
                if([favObject[@"Name"] isEqualToString:selectedObj[@"Name"]]){
                    [favsArray removeObjectAtIndex:i];
                    current[@"Favorites"] = favsArray;
                    [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if(succeeded){
                            [favsCollection reloadData];
                        }
                    }];
                    
                }
            }
        }
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
