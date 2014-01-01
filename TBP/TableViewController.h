//
//  TableViewController.h
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 4..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CLImageEditor.h"

@interface TableViewController : UITableViewController
    <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate, CLImageEditorDelegate>


@end
