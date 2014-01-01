//
//  DetailViewController.h
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 6..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController
@property (weak, nonatomic) NSString *recipeName;
@property (weak, nonatomic) NSString *recipeContent;
@property (weak, nonatomic) NSString *recipeImage;
@property (weak, nonatomic) NSArray *recipeComments;

@end
