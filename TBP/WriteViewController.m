//
//  WriteViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 18..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "WriteViewController.h"
#import "DataModel.h"

@interface WriteViewController ()

@end

@implementation WriteViewController
{
    DataModel* _NewPostData;
}

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    _writeImage.image = _internalImage;
    _writeText.delegate = self;
    _writeTitle.delegate = self;
    
    _NewPostData = [[DataModel alloc] init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard:(UITapGestureRecognizer*)reg
{
    [self.view endEditing:YES];
}


- (void)prepareData:(UIImage*)image withFileName:(NSString*)fileName
{
    _internalImage = image;
    _fileName = fileName;
}

- (IBAction)onSendCilck:(id)sender {
    //TODO: write to server using NSURLConnection
    
    NSData *imageData = UIImageJPEGRepresentation(_internalImage, 0.9);
    
    [_NewPostData newPost:_writeTitle.text withText:_writeText.text withImage:imageData withFileName:_fileName];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //[_writeText becomeFirstResponder];
    if([_writeText.text isEqualToString:@"New Post"]) {
        _writeText.text = @"";
    }
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (textView == _writeText) {
        CGRect newframe = self.view.frame;
        newframe.origin.y = -150;
        self.view.frame = newframe;
        self.view.backgroundColor = [UIColor grayColor];
    }
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (textView == _writeText) {
        CGRect newframe = self.view.frame;
        newframe.origin.y = 0;
        self.view.frame = newframe;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (textField == _writeTitle) {
        CGRect newframe = self.view.frame;
        newframe.origin.y = -150;
        self.view.frame = newframe;
        self.view.backgroundColor = [UIColor grayColor];
    }
    [UIView commitAnimations];
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:@"MyAnimation" context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    if (textField == _writeTitle) {
//        CGRect newframe = self.view.frame;
//        newframe.origin.y = 0;
//        self.view.frame = newframe;
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
//    [UIView commitAnimations];
//    return YES;
//}

@end
