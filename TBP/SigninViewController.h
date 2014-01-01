//
//  SigninViewController.h
//  TBP
//
//  Created by SunJin, Choi on 2013. 11. 27..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigninViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *test_userid;
@property (weak, nonatomic) IBOutlet UITextField *test_password;
@property (weak, nonatomic) IBOutlet UITextField *test_confirm;

@end
