//
//  ListViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "ListViewController.h"
#import "ListCollectionCell.h"
#import "DetailViewController.h"
#import "StoreAtrributes.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize catString;
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
   searchMode = NO;
    //Set Fonts and Colors
    StoreAtrributes *attributes = [StoreAtrributes alloc];
    fontArray = [attributes getFonts];
    colorArray = [attributes getColors];
    fontSize = [attributes getFontSize];
    
    self.navigationItem.backBarButtonItem.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    
    //Get Items in Category
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    [query whereKey:@"Category" equalTo:catString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            itemsArray = objects;
            [itemsCollection reloadData];
            [itemCaro reloadData];
        }
    }];
    
    itemCaro.type = iCarouselTypeCoverFlow2;
    [itemCaro reloadData];
    [itemCaro scrollToItemAtIndex:1 animated:YES];
    
    //Set Navigation Bar attributes
    self.title = catString;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:fontSize + 4],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setTitle:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Search keyword of Items
-(void)searchItems
{
    NSString *searchString = itemSearch.text;
    searchedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [itemsArray count]; i++) {
        PFObject *tempItem = [[itemsArray objectAtIndex:i] fetchIfNeeded];
        NSString *nameString = tempItem[@"Name"];
        NSString *descriptString = tempItem[@"Description"];
        NSArray *searchArray = [searchString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        searchArray = [searchArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        for (int k = 0; k < [searchArray count]; k++) {
            NSString *tempString = [searchArray objectAtIndex:k];
            NSUInteger nameLoc = [nameString rangeOfString:tempString options:NSCaseInsensitiveSearch].location;
            NSUInteger descriptLoc = [descriptString rangeOfString:tempString options:NSCaseInsensitiveSearch].location;
            if(nameLoc != NSNotFound || descriptLoc != NSNotFound){
                [searchedArray addObject:tempItem];
                break;
            }
        }
    }
    [itemsCollection reloadData];
    [itemCaro reloadData];
}

//Number of items in Collection
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionArray = itemsArray;
    if([searchedArray count] != 0){
        collectionArray = searchedArray;
    }
    return [collectionArray count];

}

//Add image, name, and price for each item in Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionCell *cell = [itemsCollection dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    NSArray *collectionArray = itemsArray;
    if([searchedArray count] != 0){
        collectionArray = searchedArray;
    }
    PFObject *item = [[collectionArray objectAtIndex:indexPath.row] fetchIfNeeded];
    PFObject *storeObj = [item[@"Store"] fetchIfNeeded];
    UIColor *fontColor = [colorArray objectAtIndex:[storeObj[@"FontColor"] intValue]];
    UIColor *bgColor = [colorArray objectAtIndex:[storeObj[@"BGColor"] intValue]];

    PFFile *imageFile = [item[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.itemImgView.image = image;
    cell.itemNameLabel.text = item[@"Name"];
    cell.itemPriceLabel.text = item[@"Price"];
    cell.itemNameLabel.font = [UIFont fontWithName:storeObj[@"Font"] size:fontSize];
    [cell.itemNameLabel setTextColor:fontColor];
    [cell.itemNameLabel setBackgroundColor:bgColor];
    cell.itemPriceLabel.font = [UIFont fontWithName:storeObj[@"Font"] size:fontSize];
    [cell.itemPriceLabel setTextColor:fontColor];
    [cell.itemPriceLabel setBackgroundColor:bgColor];
    
    return cell;
}

//Select for items in Collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    NSArray *collectionArray = itemsArray;
    if([searchedArray count] != 0){
        collectionArray = searchedArray;
    }
    [detailView setItemObj:[collectionArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailView animated:YES];
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSArray *collectionArray = itemsArray;
    if(searchMode){
        collectionArray = searchedArray;
    }
    return [collectionArray count];
}

//Add image, name, and price to each item in Carousel
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    view = [[UIView alloc] init];
    view.contentMode = UIViewContentModeScaleAspectFill;
    CGRect rec = view.frame;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        rec.size.width = 150;
        rec.size.height = 100;
    }else
    {
        rec.size.width = 300;
        rec.size.height = 250;
    }
    view.frame = rec;
    UIImageView *iv;
    UILabel *nameLabel;
    UILabel *priceLabel;
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 150, 30)];
        [nameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [nameLabel setNumberOfLines:2];
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 40, view.frame.size.height - 20, 40, 20)];
        [priceLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [priceLabel setBackgroundColor:[UIColor whiteColor]];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
        
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 300, 50)];
        [nameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 55, view.frame.size.height - 40, 55, 40)];
        [priceLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [priceLabel setBackgroundColor:[UIColor whiteColor]];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
    }
    NSArray *collectionArray = itemsArray;
    if(searchMode){
        collectionArray = searchedArray;
    }

    PFObject *item = [[collectionArray objectAtIndex:index] fetchIfNeeded];
    PFFile *imageFile = [item[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    iv.image=image;
    iv.contentMode = UIViewContentModeScaleToFill;
    
    nameLabel.text = item[@"Name"];
    priceLabel.text = item[@"Price"];
    
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:iv];
    [view addSubview:nameLabel];
    [view addSubview:priceLabel];
    return view;

}
//Select for item in Carousel
- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == itemCaro.currentItemIndex)
	{
        DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
        NSArray *collectionArray = itemsArray;
        if([searchedArray count] != 0){
            collectionArray = searchedArray;
        }
        [detailView setItemObj:[collectionArray objectAtIndex:index]];
        [self.navigationController pushViewController:detailView animated:YES];
	}
}

//Trigger search function
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchMode = YES;
    [self searchItems];
    [searchBar resignFirstResponder];
}

//Reload all data when searchbar is cleared
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0)
    {
        searchMode = NO;
        searchedArray = nil;
        [itemsCollection reloadData];
        [itemCaro reloadData];
    }
}

//Toggle Search Bar
-(IBAction)onClick:(id)sender
{
    if(itemSearch.hidden == YES){
        itemSearch.hidden = NO;
        searchMode = YES;
    }else{
        itemSearch.hidden = YES;
        searchMode = NO;
        searchedArray = nil;
        [itemsCollection reloadData];
        [itemCaro reloadData];
        [itemSearch resignFirstResponder];
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
