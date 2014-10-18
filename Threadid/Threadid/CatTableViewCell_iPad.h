//
//  CatTableViewCell_iPad.h
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatTableViewCell_iPad : UITableViewCell
{
    IBOutlet UIImageView *catImage;
    IBOutlet UILabel *catLabel;
}

@property (nonatomic, strong)NSString *catText;

-(void)refreshCell;

@end
