//
//  StoreAtrributes.m
//  Threadid
//
//  Created by Justin Tilley on 11/13/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "StoreAtrributes.h"

@implementation StoreAtrributes
@synthesize fontArray, colorArray;


-(NSArray *)getFonts
{
    fontArray = @[@"Arial", @"Baskerville", @"Chalkboard SE", @"Courier", @"Futura", @"Gill Sans", @"Helvetica", @"Noteworthy", @"Optima", @"Snell Roundhand", @"Times New Roman", @"Verdana"];
    return fontArray;
}

-(NSArray *)getColors
{
    colorArray = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor whiteColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
    return colorArray;
}

-(int)getFontSize
{
    int fontSize;
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        fontSize = 12;
    }else{
        fontSize = 15;
    }
    
    return fontSize;
}

@end
