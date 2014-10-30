//
//  DetailViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize itemObj;
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
}
-(void)viewWillAppear:(BOOL)animated
{
    itemObj = [itemObj fetchIfNeeded];
    photosArray = itemObj[@"Photos"];
    storeObj = [itemObj[@"Store"] fetchIfNeeded];
    [itemImgCaro setType:iCarouselTypeCoverFlow];
    [itemImgCaro reloadData];
    [itemImgCaro scrollToItemAtIndex:1 animated:YES];
    [self setItemData];
    UIColor *fontColor = [colorArray objectAtIndex:[storeObj[@"FontColor"] intValue]];
    UIColor *bgColor = [colorArray objectAtIndex:[storeObj[@"BGColor"] intValue]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:storeObj[@"Font"] size:21],
      NSFontAttributeName,fontColor,NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
}

-(void)viewDidAppear:(BOOL)animated
{
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [photosArray count];
}

//Add Image to item in Carousel
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
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
        
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
            }
    
    PFFile *imageFile = [itemObj[@"Photos"] objectAtIndex:index];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    iv.image=image;
    iv.contentMode = UIViewContentModeScaleToFill;
    
    [view addSubview:iv];
    return view;
}

-(void)setItemData
{
    itemNameLabel.text = itemObj[@"Name"];
    itemPriceLabel.text = [NSString stringWithFormat:@"$%@", itemObj[@"Price"]];
    itemQuantityLabel.text = itemObj[@"Quantity"];
    itemDesciption.text = itemObj[@"Description"];
    storeButton.titleLabel.text = storeObj[@"Name"];
    storeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//OnClick for Add to Cart Alert and navigation to Store or Cart
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        UIAlertView *addCartAlert = [[UIAlertView alloc] initWithTitle:@"Add to Cart" message:@"Item has been add to cart." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [addCartAlert show];
    }else if(button.tag == 1){
        [self performSegueWithIdentifier:@"ItemStoreSegue" sender:self];
    }else if(button.tag == 2){
        [self performSegueWithIdentifier:@"ItemCartSegue" sender:self];
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
