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
    catArray = @[@"Jewelry", @"Knitted", @"Home Decor", @"Supplies"];
    self.title = @"Add Item";
    picsArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if([picsArray count] == 0){
        return 1;
    }
    return [picsArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    view = [[UIView alloc] init];
    view.contentMode = UIViewContentModeScaleAspectFill;
    CGRect rec = view.frame;
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
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [catArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [catArray objectAtIndex:row];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    catString = [catArray objectAtIndex:row];
    [catButton setTitle:catString forState:UIControlStateNormal];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picsArray addObject:selectedImage];
    [picsCaro reloadData];
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == 0){
        UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        imagePicker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
        imagePicker.showsCameraControls = YES;
        imagePicker.navigationBarHidden = NO;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if (button.tag == 1){
        catPicker.hidden = NO;
        catPickerToolBar.hidden = NO;
    }else if(button.tag == 2){
        catPicker.hidden = YES;
        catPickerToolBar.hidden = YES;
    }else if(button.tag == 3){
        
    }
}

-(IBAction)onChanged:(id)sender
{
    quantityLabel.text = [NSString stringWithFormat:@"%.f", quantityStep.value];
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
