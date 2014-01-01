//
//  LoginViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 11. 27..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "LoginViewController.h"
#import "DataModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UITextField *userid;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController
{
    DataModel* _loginData;
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
    //[self.view endEditing:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    _loginData = [[DataModel alloc] init];
    
    _test_userid.delegate = self;
    _test_password.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard:(UITapGestureRecognizer*)reg
{
    //CGPoint touchPoint=[reg locationInView:_backgroundImg];
    [self.view endEditing:YES];

    //[_text resignFirstResponder];

}
- (IBAction)connectButton:(id)sender {
//    [_loginData saveID:@"asto" withPassword:@"1234"];
//    
//    if([self.userid.text isEqualToString:[_loginData getID]] && [self.password.text isEqualToString:[_loginData getPassword]]) {
//        NSLog(@"YES");
//    } else {
//        NSLog(@"NO");
//    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
//    [_loginData saveID:@"asto" withPassword:@"1234"];
//    
//    if([self.userid.text isEqualToString:[_loginData getID]] && [self.password.text isEqualToString:[_loginData getPassword]]) {
//        return YES;
//    } else {
//        return NO;
//    }
    BOOL perform = NO;
    if([identifier isEqualToString:@"loginToHome"]) {
        _loginData = [[DataModel alloc]init];
        perform = [_loginData authenticateID:self.userid.text withPassword:self.password.text];
    }
    
    return perform;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 1) {
        [_test_password becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
        if([self shouldPerformSegueWithIdentifier:@"loginToHome" sender:self]) {
            [self performSegueWithIdentifier:@"loginToHome" sender:self];
        }
    }
    return NO;
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:@"MyAnimation" context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    if (textField == _test_userid) {
//        CGRect newframe = self.view.frame;
//        newframe.origin.y = -40;
//        self.view.frame = newframe;
//        self.view.backgroundColor = [UIColor grayColor];
//    }
//    [UIView commitAnimations];
//    return YES;
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:@"MyAnimation" context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    if (textField == _test_password) {
//        CGRect newframe = self.view.frame;
//        newframe.origin.y = 0;
//        self.view.frame = newframe;
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
//    [UIView commitAnimations];
//    return YES;
//}
@end
