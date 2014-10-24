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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
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
    
    iv.image=[UIImage imageNamed:@"bettys.jpg"];
    iv.contentMode = UIViewContentModeScaleToFill;
    
    [view addSubview:iv];
    return view;
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
