//
//  WriteViewController.h
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 18..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
{
    UIImage* _internalImage;
    NSString* _fileName;
}
@property (weak, nonatomic) IBOutlet UIImageView *writeImage;
@property (weak, nonatomic) IBOutlet UITextView *writeText;
@property (weak, nonatomic) IBOutlet UITextField *writeTitle;
- (void)prepareData:(UIImage*)image withFileName:(NSString*)fileName;
- (IBAction)onSendCilck:(id)sender;

@end
