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
    //Set Navigation Bar attributes
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    //Set Static Data and Images
    catsArray = @[@"Jewelry", @"Knitted", @"Home Decor", @"Supplies", @"Sales"];
    caroItems = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    caroImgs = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    featureCaro.type = iCarouselTypeCoverFlow2;
    [featureCaro reloadData];
    [featureCaro setCurrentItemIndex:1];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Threadid";
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
    return [caroItems count];
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
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
        caroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 300, 50)];
        [caroLabel setFont:[UIFont systemFontOfSize:25]];
    }
    NSString *temp= [NSString stringWithFormat:@"%@.jpg", [caroImgs objectAtIndex:index]];
    iv.image=[UIImage imageNamed:temp];
    iv.contentMode = UIViewContentModeScaleToFill;
    
    caroLabel.text = [caroItems objectAtIndex:index];
    
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
    
	}
    [self performSegueWithIdentifier:@"CatCaroSegue" sender:self];
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
