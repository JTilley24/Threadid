//
//  AppDelegate.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "CategoriesViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"K3uYwV1KDXtetQ6aIW7An1sLaw8CzqW0NcSvds3J"
                  clientKey:@"7QpIY1rtIMip90UTHeHmhbrg5U7ZKCxtDKCn5FdU"];
    //Check if current user logged in
    NSString *deviceString;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        deviceString = @"Main_iPhone";
    }else{
        deviceString = @"Main_iPad";
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:deviceString bundle:nil];
    tabView = [storyboard instantiateViewControllerWithIdentifier:@"TabCont"];
    tabView.delegate = self;
    
    PFUser *current = [PFUser currentUser];
    if(current != nil){
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:tabView animated:NO completion:nil];
    }

    // Override point for customization after application launch.
    return YES;
}

//Send TabBar selection to Root View
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
