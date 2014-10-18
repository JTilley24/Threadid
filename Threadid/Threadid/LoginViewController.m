//
//  LoginViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*) sender;
    if(button.tag == 0){
        [self performSegueWithIdentifier:@"login-segue" sender:self];
    }else if (button.tag == 1){
        if(loginButton.hidden == false){
            loginButton.hidden = true;
            emailText.hidden = false;
            cancelButton.hidden = false;
        }else{
            [self performSegueWithIdentifier:@"login-segue" sender:self];
        }
    }else if (button.tag == 2){
        loginButton.hidden = false;
        emailText.hidden = true;
        cancelButton.hidden = true;
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
