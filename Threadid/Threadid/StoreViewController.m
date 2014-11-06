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
@synthesize storeObj, searchedString;
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
    searchMode = NO;
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana"];
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
    
    current = [PFUser currentUser];
    
    favsArray = current[@"Favorites"];
    if([favsArray count] != 0){
        for (int i = 0; i < [favsArray count]; i++) {
            PFObject *favObject = [[favsArray objectAtIndex:i] fetchIfNeeded];
            if([favObject[@"Name"] isEqualToString:storeObj[@"Name"]]){
                fav = true;
                favButton.image = [UIImage imageNamed:@"starred-icon.png"];
            }
        }
    }else{
        favsArray = [[NSMutableArray alloc] init];
    }
    //Set Navigation Bar attributes
    self.title = storeObj[@"Name"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:storeObj[@"Font"] size:21],
      NSFontAttributeName,fontColor,NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    
    //Add Search Button to NavigationBar
    searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(onClick:)];
    self.navigationItem.rightBarButtonItems = @[searchButton, favButton];
    
    //Check if search carried over from StoresView
    if(searchedString != nil){
        itemSearch.hidden = NO;
        searchMode = YES;
        itemSearch.text = searchedString;
        [self searchItems];
        
    }else{
        [itemsCollections reloadData];
        searchMode = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Search keywords of Items
-(void)searchItems
{
    NSString *searchString = itemSearch.text;
    searchedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [itemsArray count]; i++) {
        PFObject *tempItem = [[itemsArray objectAtIndex:i] fetchIfNeeded];
        NSString *nameString = tempItem[@"Name"];
        NSString *descriptString = tempItem[@"Description"];
        NSString *catString = tempItem[@"Category"];
        NSUInteger nameLoc = [nameString rangeOfString:searchString options:NSCaseInsensitiveSearch].location;
        NSUInteger descriptLoc = [descriptString rangeOfString:searchString options:NSCaseInsensitiveSearch].location;
        NSUInteger catLoc = [catString rangeOfString:searchString options:NSCaseInsensitiveSearch].location;
        if(nameString )
            if(nameLoc != NSNotFound || descriptLoc != NSNotFound || catLoc != NSNotFound){
                [searchedArray addObject:tempItem];
            }
    }
    [itemsCollections reloadData];
}

//Number of items in Collection
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionArray = itemsArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    return [collectionArray count];
}

//Add image, name, and price for each item in Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCollectionCell *cell = [itemsCollections dequeueReusableCellWithReuseIdentifier:@"StoreCollectionCell" forIndexPath:indexPath];
    NSArray *collectionArray = itemsArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    PFObject *item = [[collectionArray objectAtIndex:indexPath.row] fetchIfNeeded];
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
    NSArray *collectionArray = itemsArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    [detailView setItemObj:[collectionArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailView animated:YES];
}

//Trigger search function
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchMode = YES;
    [self searchItems];
    [itemSearch resignFirstResponder];
}

//Reload all data when searchbar is cleared
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0){
        searchMode = NO;
        [itemsCollections reloadData];
    }
}

//Toggle Favorites Button
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 1){
        if(fav == false){
            favButton.image = [UIImage imageNamed:@"starred-icon.png"];
            fav = true;
            [favsArray addObject:storeObj];
            current[@"Favorites"] = favsArray;
            [current saveInBackground];
        }else{
            favButton.image = [UIImage imageNamed:@"star-icon.png"];
            fav = false;
            favsArray = current[@"Favorites"];
            if([favsArray count] != 0){
                for (int i = 0; i < [favsArray count]; i++) {
                    PFObject *favObject = [[favsArray objectAtIndex:i] fetchIfNeeded];
                    if([favObject[@"Name"] isEqualToString:storeObj[@"Name"]]){
                        [favsArray removeObjectAtIndex:i];
                        current[@"Favorites"] = favsArray;
                        [current saveInBackground];
                    }
                }
            }
        }
    }else if(button.tag == 0){
        if(itemSearch.hidden == YES){
            itemSearch.hidden = NO;
            searchMode = YES;
        }else{
            itemSearch.hidden = YES;
            searchMode = NO;
            searchedString = nil;
            [itemsCollections reloadData];
            [itemSearch resignFirstResponder];
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
