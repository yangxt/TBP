//
//  ViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 11. 27..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"

@interface ViewController ()

@end

@implementation ViewController
{
    DataModel* _myModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myModel = [[DataModel alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returned:(UIStoryboardSegue *)segue {
}
- (IBAction)buttonClick:(id)sender {
    NSLog(@"%@", [_myModel description]);
    NSLog(@"%@", _myModel);
}

@end
