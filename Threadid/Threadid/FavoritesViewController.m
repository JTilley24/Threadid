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
    storeNameArray = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    storeImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    UILongPressGestureRecognizer *favPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteFavPress:)];
    favPress.minimumPressDuration = .5;
    favPress.delegate = self;
    favPress.delaysTouchesBegan = YES;
    [favsCollection addGestureRecognizer:favPress];
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
    FavsCell *cell = [favsCollection dequeueReusableCellWithReuseIdentifier:@"FavsCell" forIndexPath:indexPath];
    
    cell.storeImageView.image = [UIImage imageNamed:[storeImgArray objectAtIndex:indexPath.row]];
    cell.storeNameLabel.text = [storeNameArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"FavStoreSegue" sender:self];
}

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
