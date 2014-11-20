//
//  CartViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "CartViewController.h"
#import "CartCell.h"

@interface CartViewController ()

@end

@implementation CartViewController

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
   
    //Add Long Press to Table
    UILongPressGestureRecognizer *cartPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCartItem:)];
    cartPress.minimumPressDuration = .5;
    cartPress.delegate = self;
    cartPress.delaysTouchesBegan = YES;
    [cartTable addGestureRecognizer:cartPress];
}

-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributes
    self.title = @"My Cart";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:21],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    current = [PFUser currentUser];
    cartArray = current[@"Cart"];
    
    [cartTable reloadData];
    [self getPriceData];
}

//Calculate Price Data
-(void)getPriceData
{
    totalNum = 0;
    for (int i = 0; i < [cartArray count]; i++) {
        NSDictionary *object = [cartArray objectAtIndex:i];
        float price = [[object objectForKey:@"Price"] floatValue];
        float quantity = [[object objectForKey:@"Quantity"] floatValue];
        float endPrice = price * quantity;
        totalNum = totalNum + endPrice;
    }
    taxNum = totalNum * 0.065f;
    [subLabel setText:[NSString stringWithFormat:@"%.02f", taxNum]];
    [totalLabel setText:[NSString stringWithFormat:@"%.02f", totalNum + taxNum]];
}

//Save Checkout Data to Store's Sales History
-(void)saveCheckoutData
{
    salesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [cartArray count]; i++) {
        NSDictionary *object = [cartArray objectAtIndex:i];
        PFObject *item = [[object objectForKey:@"Item"] fetchIfNeeded];
        PFObject *store = [item[@"Store"] fetchIfNeeded];
        BOOL newStore = true;
        for (int j = 0; j < [salesArray count]; j++) {
            PFObject *tempStore = [salesArray objectAtIndex:j];
            if([tempStore[@"Name"] isEqualToString:store[@"Name"]])
            {
                storeObj = tempStore;
                newStore = false;
            }
        }
        if(newStore){
            storeObj = store;
        }
        NSMutableArray *historyArray = storeObj[@"History"];
        if([historyArray count] == 0 || historyArray == nil){
            historyArray = [[NSMutableArray alloc] init];
        }
        NSMutableDictionary *sale = [[NSMutableDictionary alloc] init];
        [sale setObject:item forKey:@"Item"];
        [sale setObject:current forKey:@"User"];
        NSDate *date = [[NSDate alloc] init];
        [sale setObject:date forKey:@"Date"];
        float price = [[object objectForKey:@"Price"]floatValue];
        float quantity = [[object objectForKey:@"Quantity"] floatValue];
        float endPrice = price * quantity;
        float tax = endPrice * 0.065f;
        NSString *totalString = [NSString stringWithFormat:@"%.02f", endPrice + tax];
        [sale setObject:totalString forKey:@"Total"];
        [historyArray addObject:sale];
        storeObj[@"History"] = historyArray;
        [salesArray addObject:storeObj];
    }
    [PFObject saveAll:salesArray];
    [cartArray removeAllObjects];
    current[@"Cart"] = cartArray;
    [current saveInBackground];
    [cartTable reloadData];
    [self getPriceData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of rows in Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cartArray count];
}

//Add items data to Table's cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartCell *cell = [cartTable dequeueReusableCellWithIdentifier:@"CartCell"];
    NSDictionary *object = [cartArray objectAtIndex:indexPath.row];
    PFObject *item = [[object objectForKey:@"Item"] fetchIfNeeded];
    PFObject *store = [item[@"Store"] fetchIfNeeded];
    PFFile *imageFile = [item[@"Photos"] objectAtIndex:0];
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.itemImg.image = image;
    cell.itemNameLabel.text = item[@"Name"];
    cell.itemPriceLabel.text = [object objectForKey:@"Price"];
    cell.itemQuantityLabel.text = [object objectForKey:@"Quantity"];
    cell.storeLabel.text = store[@"Name"];
    
    return cell;
}

//Delete Alert for selected item
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int)indexPath.row;
    NSMutableDictionary *object = [[cartArray objectAtIndex:selectedIndex] mutableCopy];
    NSString *quantityString = [object objectForKey:@"Quantity"];
    UIAlertView *quantityAlert = [[UIAlertView alloc] initWithTitle:@"Quantity" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    quantityAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [quantityAlert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [quantityAlert textFieldAtIndex:0].text = quantityString;
    [quantityAlert show];
    
}

//Checkout Alert for cart
-(IBAction)onClick:(id)sender
{
    UIAlertView *checkoutAlert = [[UIAlertView alloc] initWithTitle:@"Checkout" message:@"Checkout feature will be handled with third-party payment system. \n i.e PayPal" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [checkoutAlert show];
    
    [self saveCheckoutData];
}

//Delete Cart Item Gesture
-(void)deleteCartItem:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state != UIGestureRecognizerStateEnded){
        return;
    }
    CGPoint point = [gesture locationInView:cartTable];
    
    NSIndexPath *index = [cartTable indexPathForRowAtPoint:point];
    if(index == nil){
        
    }else{
        selectedIndex = (int)index.row;
        UIAlertView *cartAlert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES", @"NO", nil];
        [cartAlert show];
    }
}

//Button click for Alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //If Yes Button is Selected
    if ([title isEqualToString:@"YES"])
    {
        [cartArray removeObjectAtIndex:selectedIndex];
        current[@"Cart"] = cartArray;
        [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [cartTable reloadData];
                [self getPriceData];
            }
        }];
    }else if([title isEqualToString:@"OK"]){
        NSMutableDictionary *object = [[cartArray objectAtIndex:selectedIndex] mutableCopy];
        NSString *quantityString = [alertView textFieldAtIndex:0].text;
        [object setValue:quantityString forKey:@"Quantity"];
        [cartArray replaceObjectAtIndex:selectedIndex withObject:object];
        current[@"Cart"] = cartArray;
        [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [cartTable reloadData];
                [self getPriceData];
            }
        }];
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
