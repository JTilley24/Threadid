//
//  DetailViewController.h
//  Threadid
//
//  Created by Justin Tilley on 10/17/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface DetailViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
{
    IBOutlet iCarousel *itemImgCaro;
}
@end
