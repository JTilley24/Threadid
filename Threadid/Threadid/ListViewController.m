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
   
    //Set Fonts and Colors
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana Bold"];
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];

    //Change font size by iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        fontSize = 12;
    }else
    {
        fontSize = 15;
    }
    
    //Set Static Data and Images
    itemImgArray = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    itemNameArray = @[@"Pink Knitted Handbag", @"Tuquiose Woven Charm Braclet", @"Knitted Baby Booties"];
    itemPriceArray = @[@"$44.99", @"$9.99", @"$14.99"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    [query whereKey:@"Category" equalTo:catString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            itemsArray = objects;
            [itemsCollection reloadData];
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
      [UIFont fontWithName:@"Helvetica" size:21],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
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

//Number of items in Collection
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return [itemsArray count];
}

//Add image, name, and price for each item in Collection
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionCell *cell = [itemsCollection dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    PFObject *item = [[itemsArray objectAtIndex:indexPath.row] fetchIfNeeded];
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
    [detailView setItemObj:[itemsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailView animated:YES];
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [itemNameArray count];
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
        [nameLabel setFont:[UIFont systemFontOfSize:12]];
        [nameLabel setNumberOfLines:2];
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 40, view.frame.size.height - 20, 40, 20)];
        [priceLabel setFont:[UIFont systemFontOfSize:12]];
        [priceLabel setBackgroundColor:[UIColor whiteColor]];
        
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 300, 50)];
        [nameLabel setFont:[UIFont systemFontOfSize:25]];
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 55, view.frame.size.height - 40, 55, 40)];
        [priceLabel setFont:[UIFont systemFontOfSize:17]];
        [priceLabel setBackgroundColor:[UIColor whiteColor]];
    }
    
    iv.image=[UIImage imageNamed:[itemImgArray objectAtIndex:index]];
    iv.contentMode = UIViewContentModeScaleToFill;
    
    nameLabel.text = [itemNameArray objectAtIndex:index];
    priceLabel.text = [itemPriceArray objectAtIndex:index];
    
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

	}
    [self performSegueWithIdentifier:@"ListCaroSegue" sender:self];
}

//Toggle Search Bar
-(IBAction)onClick:(id)sender
{
    if(itemSearch.hidden == YES){
        itemSearch.hidden = NO;
    }else{
        itemSearch.hidden = YES;
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
