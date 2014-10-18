//
//  CatTableViewCell_iPhone.m
//  Threadid
//
//  Created by Justin Tilley on 10/16/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "CatTableViewCell_iPhone.h"

@implementation CatTableViewCell_iPhone
@synthesize catText;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell
{
    catLabel.text = catText;
    NSString *catImgString = [NSString stringWithFormat:@"%@.jpg", catText];
    catImage.image = [UIImage imageNamed:catImgString];
}

@end
