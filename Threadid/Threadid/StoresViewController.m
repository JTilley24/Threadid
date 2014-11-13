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
    searchMode = NO;
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard SE", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana"];
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
            //Check if Current Search
            if(searchMode){
                [self searchStores];
            }
        }
    }];
    
     //Set Navigation Bar attributes
    self.title = @"Stores";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:fontSize + 4],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//Search for keyword with Items of Stores
-(void)searchStores
{
    NSString *searchString = storeSearch.text;
    searchedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [storesArray count]; i++) {
        PFObject *tempStore = [[storesArray objectAtIndex:i] fetchIfNeeded];
        NSArray *tempArray = tempStore[@"Items"];
        for (int j = 0; j < [tempArray count]; j++) {
            PFObject *tempItem = [[tempArray objectAtIndex:j] fetchIfNeeded];
            NSString *nameString = tempItem[@"Name"];
            NSString *descriptString = tempItem[@"Description"];
            NSString *catString = tempItem[@"Category"];
            NSArray *searchArray = [searchString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            searchArray = [searchArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
            for (int k = 0; k < [searchArray count]; k++) {
                NSString *tempString = [searchArray objectAtIndex:k];
                NSUInteger nameLoc = [nameString rangeOfString:tempString options:NSCaseInsensitiveSearch].location;
                NSUInteger descriptLoc = [descriptString rangeOfString:tempString options:NSCaseInsensitiveSearch].location;
                NSUInteger catLoc = [catString rangeOfString:tempString options:NSCaseInsensitiveSearch].location;
                if(nameLoc != NSNotFound || descriptLoc != NSNotFound || catLoc != NSNotFound){
                    [searchedArray addObject:tempStore];
                    break;
                }
            }
        }
    }
    [storesCollection reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Trigger search function
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchMode = YES;
    [self searchStores];
    [storeSearch resignFirstResponder];
}

//Reload with all data if searchbar is cleared
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0)
    {
        searchMode = NO;
        [storesCollection reloadData];
    }
}

//Number of items in Collection
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionArray = storesArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    return [collectionArray count];
}

//Add image and name for each store to Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoresViewCell *cell = [storesCollection dequeueReusableCellWithReuseIdentifier:@"StoresCell" forIndexPath:indexPath];
    NSArray *collectionArray = storesArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    PFObject *object = [collectionArray objectAtIndex:indexPath.row];
    NSArray *itemArray = object[@"Items"];
    PFObject *itemObj = [[itemArray objectAtIndex:0] fetchIfNeeded];
    PFFile *imageFile = [itemObj[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.storeImageView.image = image;
    cell.storeNameLabel.text = object[@"Name"];
    cell.storeNameLabel.backgroundColor = [colorArray objectAtIndex:[object[@"BGColor"] intValue]];
    cell.storeNameLabel.textColor = [colorArray objectAtIndex:[object[@"FontColor"] intValue]];
    cell.storeNameLabel.font = [UIFont fontWithName:object[@"Font"] size:fontSize];
    return cell;
}

//Select store from Collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
    NSArray *collectionArray = storesArray;
    if(searchMode){
        collectionArray = searchedArray;
        [storeView setSearchedString:storeSearch.text];
    }
    [storeView setStoreObj:[collectionArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:storeView animated:YES];
}

//Toggle Search bar
-(IBAction)onClick:(id)sender
{
    if(storeSearch.hidden == YES){
        storeSearch.hidden = NO;
        searchMode = YES;
    }else{
        storeSearch.hidden = YES;
        searchMode = NO;
        [storesCollection reloadData];
        [storeSearch resignFirstResponder];
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
