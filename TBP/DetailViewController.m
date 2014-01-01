//
//  DetailViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 6..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *DetailContent;
@property (weak, nonatomic) IBOutlet UITableViewCell *DetailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

@end

@implementation DetailViewController
@synthesize recipeName;
@synthesize recipeContent;
@synthesize recipeImage;
@synthesize recipeComments;

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
    self.DetailTitle.textLabel.text = recipeName;
    self.DetailContent.textLabel.text = recipeContent;
    [self.DetailImage setImageWithURL:[NSURL URLWithString:recipeImage]];
	// Do any additional setup after loading the view.
    [recipeComments count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
