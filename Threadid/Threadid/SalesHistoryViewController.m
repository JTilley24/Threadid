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
    usersArray = @[@"Knitter5", @"SuperMom12"];
    itemsArray = @[@"Pink Knitted Handbag", @"Knitted Baby Booties"];
    dateArray = @[@"Oct 12, 2014", @"Oct 15, 2014"];
    totalArray = @[@"$47.91", @"$15.96"];
    self.title = @"Sales History";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [usersArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCell *cell = [historyTable dequeueReusableCellWithIdentifier:@"HistoryCell"];
    cell.userNameLabel.text = [usersArray objectAtIndex:indexPath.row];
    cell.itemLabel.text = [itemsArray objectAtIndex:indexPath.row];
    cell.dateLabel.text = [dateArray objectAtIndex:indexPath.row];
    cell.totalLabel.text = [totalArray objectAtIndex:indexPath.row];
    
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
