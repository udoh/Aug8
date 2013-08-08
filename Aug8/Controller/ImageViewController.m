//
//  ImageViewController.m
//  Aug1
//
//  Created by Udo Hoppenworth on 8/1/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "ImageViewController.h"
#import "Recipe.h"

@interface ImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.imageView.image = [UIImage imageWithData:self.recipe.recipeImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
}


- (IBAction)takePicture:(UIBarButtonItem *)sender
{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *newImage = info[UIImagePickerControllerOriginalImage];
    
    self.recipe.recipeImage = [NSData dataWithData:UIImageJPEGRepresentation(newImage, 1.0)];
    self.imageView.image = [UIImage imageWithData:self.recipe.recipeImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
