//
//  CategoriesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CatCell.h"
#import "ListViewController.h"
#import "StoreViewController.h"
#import "StoreAtrributes.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController

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
    
    //Set Fonts and Colors
    StoreAtrributes *attributes = [StoreAtrributes alloc];
    fontSize = [attributes getFontSize];
    
    //Set Categories and Carousel
    catsArray = @[@"Jewelry", @"Knitted", @"Home Decor", @"Supplies", @"Sales"];
    featureCaro.type = iCarouselTypeCoverFlow2;
    self.navigationItem.backBarButtonItem.title = @"";
}
-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributes
    self.title = @"Threadid";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:fontSize + 4],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //Get Data from Parse
    storeArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Store"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            for (int i = 0; i < [objects count]; i++) {
                PFObject *store = [[objects objectAtIndex:i] fetchIfNeeded];
                if([store[@"Items"] count] != 0){
                    [storeArray addObject:store];
                }
            }
            [featureCaro reloadData];
            if([objects count] != 0){
                [featureCaro setCurrentItemIndex:1];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of Rows in Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [catsArray count];
}

//View for Table's Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatCell *cell = [catTable dequeueReusableCellWithIdentifier:@"cat-cell" forIndexPath:indexPath];
    cell.catLabel.text = [catsArray objectAtIndex:indexPath.row];
    NSString *catImgString = [NSString stringWithFormat:@"%@.jpg", [catsArray objectAtIndex:indexPath.row]];
    
    cell.catImg.image = [UIImage imageNamed:[catImgString stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    return cell;
}

//Select row on Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Open Sales or Items List by Category
    if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"SaleCatSegue" sender:self];
    }else{
        ListViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListView"];
        [listView setCatString:[catsArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:listView animated:YES];
    }
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [storeArray count];
}

//Add Image, Name, and Price of each item to Carousel
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
    UILabel *caroLabel;
    //Determine iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
        caroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 150, 30)];
        [caroLabel setFont:[UIFont systemFontOfSize:15]];
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
        caroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 300, 50)];
        [caroLabel setFont:[UIFont systemFontOfSize:25]];
    }
    
    PFObject *store = [storeArray objectAtIndex:index];
    caroLabel.text = store[@"Name"];
    PFObject *item = [[store[@"Items"] objectAtIndex:0] fetchIfNeeded];
    PFFile *imageFile = [item[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    iv.image = image;
    iv.contentMode = UIViewContentModeScaleToFill;
    
    [caroLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:iv];
    [view addSubview:caroLabel];
    return view;
}

//Select item in Carousel
- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == featureCaro.currentItemIndex)
	{
        StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
        [storeView setStoreObj:[storeArray objectAtIndex:index]];
        [self.navigationController pushViewController:storeView animated:YES];
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
