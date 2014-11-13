//
//  CategoriesViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CategoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, iCarouselDelegate, iCarouselDataSource>
{
    IBOutlet UITableView *catTable;
    NSArray *catsArray;
    IBOutlet iCarousel *featureCaro;
    NSMutableArray *storeArray;
    int fontSize;
}
@end
