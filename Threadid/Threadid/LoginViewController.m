//
//  LoginViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/15/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "LoginViewController.h"
#import "CategoriesViewController.h"
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

//OnClick for Login, Signup, and Cancel Buttons
-(IBAction)onClick:(id)sender
{
    
    UIButton *button = (UIButton*) sender;
    if(button.tag == 0){
        //Validate and Login User
        BOOL validate = true;
        NSString *userName = userText.text;
        NSString *password = passText.text;
        if((userName == nil) || [userName isEqualToString:@""]){
            validate = false;
        }
        if((password == nil) || [password isEqualToString:@""]){
            validate = false;
        }
        if(validate){
            [PFUser logInWithUsernameInBackground:userName password:password block:
             ^(PFUser *user, NSError *error) {
                 if(user){
                     [self performSegueWithIdentifier:@"login-segue" sender:self];
                 }else{
                     UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username and/or Password are incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [loginAlert show];
                 }
             }];
        }else{
            NSLog(@"Login not inputted");
            UIAlertView *inputAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter Username and Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [inputAlert show];
        }
    }else if (button.tag == 1){
        //Toggle to Signup or Create New Account
        if(loginButton.hidden == false){
            loginButton.hidden = true;
            emailText.hidden = false;
            cancelButton.hidden = false;
        }else{
            BOOL validate = true;
            PFUser *user = [PFUser user];
            NSString *username = userText.text;
            NSString *password = passText.text;
            NSString *email = emailText.text;
            if([username isEqualToString:@""]){
                validate = false;
            }
            if([password isEqualToString:@""]){
                validate = false;
            }
            if([email isEqualToString:@""]){
                validate = false;
            }
            if(validate == true){
                if([self validatePasssword]){
                    user.username = username;
                    user.password = password;
                    user.email = email;
                    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if(!error){
                            [self performSegueWithIdentifier:@"login-segue" sender:self];
                        }else{
                            NSString *errorText = @"";
                            if(error.code == kPFErrorAccountAlreadyLinked){
                                errorText = @"Account Already Linked.";
                            }else if (error.code == kPFErrorInvalidEmailAddress){
                                errorText = @"Email is Invalid.";
                            }else if(error.code == kPFErrorUsernameTaken){
                                errorText = @"Username Already Taken.";
                            }
                            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorText delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [errorAlert show];
                        }
                    }];
                }else{
                    UIAlertView *passAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password must contain letters and number and 6 to 20 characters long." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [passAlert show];
                }
            }
            
        }
    }else if (button.tag == 2){
        loginButton.hidden = false;
        emailText.hidden = true;
        cancelButton.hidden = true;
    }
}

//Validate Password
-(BOOL)validatePasssword{
    NSString *pattern = @"((?=.*\\d)(?=.*[a-z]).{6,20})";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if([predicate evaluateWithObject:passText.text]){
        return YES;
    }
    return NO;
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
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
