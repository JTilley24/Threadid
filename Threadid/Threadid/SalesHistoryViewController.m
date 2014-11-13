//
//  SalesHistoryViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/21/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "SalesHistoryViewController.h"
#import "HistoryCell.h"

@interface SalesHistoryViewController ()

@end

@implementation SalesHistoryViewController

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
    
    self.title = @"Sales History";
   
}

-(void)viewWillAppear:(BOOL)animated
{
    current = [PFUser currentUser];
    storeObj = current[@"Store"];
    [storeObj fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        historyArray = storeObj[@"History"];
        [historyTable reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of rows for Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [historyArray count];
}

//Add username, item, date and total to Table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCell *cell = [historyTable dequeueReusableCellWithIdentifier:@"HistoryCell"];
    NSDictionary *sale = [historyArray objectAtIndex:indexPath.row];
    PFObject *item = [[sale objectForKey:@"Item"] fetchIfNeeded];
    PFObject *user = [[sale objectForKey:@"User"] fetchIfNeeded];
    NSDate *date = [sale objectForKey:@"Date"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if(dateFormat != nil)
    {
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    NSString *dateText = [dateFormat stringFromDate:date];
    NSString *newDate = [[NSString alloc] initWithFormat:@"%@", dateText];
    
    cell.userNameLabel.text = user[@"username"];
    cell.itemLabel.text = item[@"Name"];
    cell.dateLabel.text = newDate;
    cell.totalLabel.text = [sale objectForKey:@"Total"];
    
    return cell;
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
