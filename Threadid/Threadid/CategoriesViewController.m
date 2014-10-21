//
//  CategoriesViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CatTableViewCell_iPhone.h"
#import "CatTableViewCell_iPad.h"

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    catsArray = @[@"Jewelry", @"Knitted", @"Home Decor", @"Supplies", @"Sales"];
    caroItems = @[@"Betty's Bags", @"Chelsea's Charms", @"Knitted Knighty"];
    caroImgs = @[@"bettys.jpg", @"charms.jpg", @"knighty.jpg"];
    featureCaro.type = iCarouselTypeCoverFlow2;
    [featureCaro reloadData];
    [featureCaro setCurrentItemIndex:1];
    UINib *catCellNib;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        catCellNib = [UINib nibWithNibName:@"CatTableViewCell_iPhone" bundle:nil];
    }else{
        catCellNib = [UINib nibWithNibName:@"CatTableViewCell_iPad" bundle:nil];
    }
    if(catCellNib != nil){
        [catTable registerNib:catCellNib forCellReuseIdentifier:@"CustomCell"];
    }

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [catsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        CatTableViewCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        cell.catText = [catsArray objectAtIndex:indexPath.row];
        
        [cell refreshCell];
        return cell;
    }else{
        CatTableViewCell_iPad *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        cell.catText = [catsArray objectAtIndex:indexPath.row];
        [cell refreshCell];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"CatSegue" sender:self];
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [caroItems count];
}

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

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == featureCaro.currentItemIndex)
	{
		//note, this will only ever happen if useButtons == NO
		//otherwise the button intercepts the tap event
		NSLog(@"Did select current item");
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
