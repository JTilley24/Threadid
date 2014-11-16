//
//  AddItemViewController.m
//  Threadid
//
//  Created by Justin Tilley on 10/20/14.
//  Copyright (c) 2014 Justin Tilley. All rights reserved.
//

#import "AddItemViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddItemViewController ()

@end

@implementation AddItemViewController
@synthesize storeObj, editObject;
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
    
    //Get User and Store Objects
    PFUser *current = [PFUser currentUser];
    storeObject = [current[@"Store"] fetchIfNeeded];
    
    //Set Selection data
    catArray = @[@"Jewelry", @"Knitted", @"Home Decor", @"Supplies"];
    
    picsArray = [[NSMutableArray alloc] init];
    [itemScroll setContentSize:CGSizeMake(320, 480)];
}

-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar attributes
    self.title = @"Add Item";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(238/255.0f) green:(120/255.0f) blue:(123/255.0f) alpha:1.0f]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica" size:21],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    //Check if Editing
    if(editObject != nil){
        editObject = [editObject fetchIfNeeded];
        [self editItem];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Number of items in Carousel
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if([picsArray count] == 0){
        return 1;
    }
    return [picsArray count];
}

//Add image to Carousel
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    view = [[UIView alloc] init];
    view.contentMode = UIViewContentModeScaleAspectFill;
    CGRect rec = view.frame;
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        rec.size.width = 100;
        rec.size.height = 100;
    }else
    {
        rec.size.width = 250;
        rec.size.height = 200;
    }
    view.frame = rec;
    UIImageView *iv;
    //Determine if iPhone or iPad
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        
    }else
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 200)];
    }
    if([picsArray count] == 0){
        iv.image = [UIImage imageNamed:@"default-pic.png"];
    }else{
        iv.image = [picsArray objectAtIndex:index];
    }
    iv.contentMode = UIViewContentModeScaleToFill;
    
    [view addSubview:iv];
    return view;

}

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
    selectedIndex = (int)index;
    UIAlertView *caroAlert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are You Sure?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    [caroAlert show];
}

//Components in Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//Number of rows in picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [catArray count];
}

//Add Category Name
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [catArray objectAtIndex:row];
    return label;
}

//Change Name of button to select category
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    catString = [catArray objectAtIndex:row];
    [catButton setTitle:catString forState:UIControlStateNormal];
}

//Display Image in Carousel
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picsArray addObject:selectedImage];
    [picsCaro reloadData];
    [picker dismissViewControllerAnimated:true completion:nil];
}

//Close Image Picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}

//Open Toolbar
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [itemScroll setContentOffset:CGPointMake(0, 200)];
    catPickerToolBar.hidden = NO;
}

//Close Keyboard
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    [itemScroll setContentOffset:CGPointZero];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

//Save Item to Parse
-(void)saveToParse
{
    if(editObject != nil){
        editObject[@"Name"] = itemNameInput.text;
        editObject[@"Price"] = itemPriceInput.text;
        editObject[@"User"] = [PFUser currentUser];
        editObject[@"Store"] = storeObject;
        editObject[@"Category"] = catString;
        editObject[@"Quantity"] = quantityLabel.text;
        editObject[@"Description"] = descriptView.text;
        NSMutableArray *photosArray = [[NSMutableArray alloc] init];
        for(int i = 0; i < [picsArray count]; i++){
            UIImage *image = [picsArray objectAtIndex:i];
            
            NSString *imageName = [NSString stringWithFormat:@"%@%d.png", itemNameInput.text, i];
            imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
            PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
            [photosArray addObject:imageFile];
        }
        editObject[@"Photos"] = photosArray;
        [self showLoading];
        [editObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [loadingView hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        PFObject *itemObj = [PFObject objectWithClassName:@"Item"];
        itemObj[@"Name"] = itemNameInput.text;
        itemObj[@"Price"] = itemPriceInput.text;
        itemObj[@"User"] = [PFUser currentUser];
        itemObj[@"Store"] = storeObject;
        itemObj[@"Category"] = catString;
        itemObj[@"Quantity"] = quantityLabel.text;
        itemObj[@"Description"] = descriptView.text;
        NSMutableArray *photosArray = [[NSMutableArray alloc] init];
        for(int i = 0; i < [picsArray count]; i++){
            UIImage *image = [picsArray objectAtIndex:i];
            
            NSString *imageName = [NSString stringWithFormat:@"%@%d.png", itemNameInput.text, i];
            imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
            PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
            [photosArray addObject:imageFile];
        }
        itemObj[@"Photos"] = photosArray;
        [self showLoading];
        [itemObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [self addToStore:itemObj];
            }
        }];
    }
}

//Show Loading
-(void)showLoading
{
    loadingView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loadingView.mode = MBProgressHUDModeIndeterminate;
    loadingView.labelText = @"Saving";
    [loadingView show: YES];
}

//Validate Inputs
-(BOOL)validateForm
{
    BOOL validate = YES;
    if([itemNameInput.text isEqualToString:@""]){
        validate = NO;
    }
    if([itemPriceInput.text isEqualToString:@""]){
       validate = NO;
    }
    if(catString == nil){
        validate = NO;
    }
    
    if([quantityLabel.text isEqualToString:@"0"]){
        validate = NO;
    }
    if([picsArray count] == 0){
        validate = NO;
    }
    return validate;
}

//Add Item to Store
-(void)addToStore: (PFObject *)object
{
    NSMutableArray *tempArray = [storeObj[@"Items"] mutableCopy];
    [tempArray addObject:object];
    [storeObj saveInBackground];
    [loadingView hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

//Set Item's Data for Editing
-(void)editItem
{
    itemNameInput.text = editObject[@"Name"];
    itemPriceInput.text = editObject[@"Price"];
    [quantityStep setValue:[editObject[@"Quantity"] doubleValue]];
    quantityLabel.text = editObject[@"Quantity"];
    catString = editObject[@"Category"];
    [catButton setTitle:catString forState:UIControlStateNormal];
    descriptView.text = editObject[@"Description"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSArray *editPhotos = editObject[@"Photos"];
    for (int i = 0; i < [editPhotos count]; i++) {
        PFFile *imageFile = [editPhotos objectAtIndex:i];
        NSData *imageData = [imageFile getData];
        UIImage *image = [UIImage imageWithData:imageData];
        [tempArray addObject:image];
    }
    picsArray = tempArray;
    [picsCaro reloadData];
}

//OnClick for camera, category, and save button
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        UIAlertView *imageAlert = [[UIAlertView alloc] initWithTitle:@"Which do you choose?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Use Gallery", @"Use Camera", nil];
        [imageAlert show];
    }else if (button.tag == 1){
        catPicker.hidden = NO;
        catPickerToolBar.hidden = NO;
    }else if(button.tag == 2){
        catPicker.hidden = YES;
        catPickerToolBar.hidden = YES;
        [descriptView endEditing:YES];
    }else if(button.tag == 3){
        if([self validateForm]){
            [self saveToParse];
        }else{
            UIAlertView *validateAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter all information and try again." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [validateAlert show];
        }
    }
}

//OnChange for stepper
-(IBAction)onChanged:(id)sender
{
    quantityLabel.text = [NSString stringWithFormat:@"%.f", quantityStep.value];
}

//Selections for AlertViews
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Use Gallery"]){
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:
                  UIImagePickerControllerSourceTypeSavedPhotosAlbum] == YES){
            pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            pickerController.delegate = self;
            
            pickerController.allowsEditing = false;
            
            pickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];;
            
            [self presentViewController:pickerController animated:true completion:nil];
        }
    }else if([title isEqualToString:@"Use Camera"]){
        UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera] == YES){
            imagePicker.delegate = self;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            imagePicker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
            imagePicker.showsCameraControls = YES;
            imagePicker.navigationBarHidden = NO;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }else if ([title isEqualToString:@"Yes"]){
        [picsArray removeObjectAtIndex:selectedIndex];
        [picsCaro reloadData];
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
