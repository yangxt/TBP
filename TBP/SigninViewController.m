//
//  SigninViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 11. 27..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "SigninViewController.h"
#import "DataModel.h"

@interface SigninViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *userid;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordconfirm;

@end

@implementation SigninViewController
{
    DataModel* _signinData;
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
    [self.view endEditing:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    _username.delegate =self;
    _userid.delegate =self;
    _password.delegate =self;
    _passwordconfirm.delegate =self;
    
    _signinData = [[DataModel alloc] init];
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
- (IBAction)signinRegister:(id)sender {
//    if([self.passwordconfirm.text isEqualToString:self.password.text] && [self.userid.text length]!=0) {
//        [_signinData saveID:[_userid text] withName:[_username text] withPassword:[_password text]];
//        //NSLog(@"%@", _signinData);
//    } else {
//        NSLog(@"NOT CORRECT PASSWORDS");
//    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{

    BOOL perform = NO;
    if([identifier isEqualToString:@"toLogin"]) {
        if([self.passwordconfirm.text isEqualToString:self.password.text] && [self.userid.text length]!=0) {
            perform = [_signinData saveID:[_userid text] withName:[_username text] withPassword:[_password text]];
        } else {
            NSLog(@"NOT CORRECT PASSWORDS");
        }
    }
    
    return perform;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _passwordconfirm) {
        [self.view endEditing:YES];
    } else if(textField == _username) {
        [_userid becomeFirstResponder];
    } else if(textField == _userid) {
        [_password becomeFirstResponder];
    } else if(textField == _password) {
        [_passwordconfirm becomeFirstResponder];
    }
    return YES;
}

@end
