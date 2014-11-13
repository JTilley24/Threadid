//
//  DetailViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "DetailViewController.h"
#import "StoreViewController.h"

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
    //Get Data from Parse
    itemObj = [itemObj fetchIfNeeded];
    photosArray = itemObj[@"Photos"];
    storeObj = [itemObj[@"Store"] fetchIfNeeded];
    [itemImgCaro setType:iCarouselTypeCoverFlow];
    [itemImgCaro reloadData];
    [itemImgCaro scrollToItemAtIndex:1 animated:YES];
    [self setItemData];
    current = [PFUser currentUser];
    
    //Set Navigation Bar attributes
    UIColor *fontColor = [colorArray objectAtIndex:[storeObj[@"FontColor"] intValue]];
    UIColor *bgColor = [colorArray objectAtIndex:[storeObj[@"BGColor"] intValue]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:storeObj[@"Font"] size:fontSize + 4],
      NSFontAttributeName,fontColor,NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:fontColor];
    UIBarButtonItem *cartButton = [self.navigationItem rightBarButtonItem];
    [cartButton setTintColor:fontColor];
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

//Set Item's Data to View
-(void)setItemData
{
    itemNameLabel.text = itemObj[@"Name"];
    
    itemPriceLabel.text = [NSString stringWithFormat:@"$%@", itemObj[@"Price"]];
    itemQuantityLabel.text = itemObj[@"Quantity"];
    itemDesciption.text = itemObj[@"Description"];
    [storeButton setTitle:storeObj[@"Name"] forState:UIControlStateNormal];
    storeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//OnClick for Add to Cart Alert and navigation to Store or Cart
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        UIAlertView *addCartAlert = [[UIAlertView alloc] initWithTitle:@"Add to Cart" message:@"Item has been add to cart." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [addCartAlert show];
        NSMutableArray *cartArray = [current[@"Cart"] mutableCopy];
        BOOL duplicateItem = false;
        if ([cartArray count] != 0) {
            for (int i = 0; i < [cartArray count]; i++) {
                NSMutableDictionary *object = [[cartArray objectAtIndex:i] mutableCopy];
                PFObject *item = [[object objectForKey:@"Item"] fetchIfNeeded];
                if([item[@"Name"] isEqualToString:itemObj[@"Name"]]){
                    duplicateItem = true;
                    int quantity = [[object objectForKey:@"Quantity"] intValue];
                    quantity++;
                    [object setObject:[NSString stringWithFormat:@"%d", quantity] forKey:@"Quantity"];
                    if(item[@"Sale"] != nil){
                        PFObject *saleObject = [item[@"Sale"] fetchIfNeeded];
                        [object setObject:saleObject[@"Price"] forKey:@"Price"];
                    }else{
                        [object setObject:item[@"Price"] forKey:@"Price"];
                    }
                    [cartArray setObject:object atIndexedSubscript:i];
                    current[@"Cart"] = cartArray;
                    [current saveInBackground];
                }
            }
            if(duplicateItem == false){
                NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
                [object setObject:itemObj forKey:@"Item"];
                int quantity = 1;
                if(itemObj[@"Sale"] != nil){
                    PFObject *saleObject = [itemObj[@"Sale"] fetchIfNeeded];
                    [object setObject:saleObject[@"Price"] forKey:@"Price"];
                    if([saleObject[@"Type"] isEqualToString:@"2"]){
                        quantity++;
                    }
                }else{
                    [object setObject:itemObj[@"Price"] forKey:@"Price"];
                }
                [object setObject:[NSString stringWithFormat:@"%d", quantity] forKey:@"Quantity"];
                [cartArray addObject:object];
                current[@"Cart"] = cartArray;
                [current saveInBackground];
            }
        }else{
            cartArray = [[NSMutableArray alloc] init];
            NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
            [object setObject:itemObj forKey:@"Item"];
            int quantity = 1;
            if(itemObj[@"Sale"] != nil){
                PFObject *saleObject = [itemObj[@"Sale"] fetchIfNeeded];
                [object setObject:saleObject[@"Price"] forKey:@"Price"];
                if([saleObject[@"Type"] isEqualToString:@"2"]){
                    quantity++;
                }
            }else{
                [object setObject:itemObj[@"Price"] forKey:@"Price"];
            }
            [object setObject:[NSString stringWithFormat:@"%d", quantity] forKey:@"Quantity"];
            [cartArray addObject:object];
            current[@"Cart"] = cartArray;
            [current saveInBackground];
        }
    }else if(button.tag == 1){
        StoreViewController *storeView = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreView"];
        [storeView setStoreObj:storeObj];
        [self.navigationController pushViewController:storeView animated:YES];
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
