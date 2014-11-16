//
//  StoreAtrributes.h
//  Threadid
//
//  Created by Justin Tilley on 11/13/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreAtrributes : NSObject
{
    
}

@property(nonatomic, strong) NSArray *fontArray;
@property(nonatomic, strong) NSArray *colorArray;

-(NSArray *)getFonts;
-(NSArray *)getColors;
-(int)getFontSize;

@end
