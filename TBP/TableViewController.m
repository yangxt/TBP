//
//  TableViewController.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 4..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "TableViewController.h"
#import "DataModel.h"
#import "DetailViewController.h"
#import "CustomCell.h"
#import "UIImageView+WebCache.h"
#import "WriteViewController.h"


@interface TableViewController ()
{
    DataModel* _dataModel;
    NSString* _fileName;
}

@end

@implementation TableViewController

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
    NSLog(@"load");
    _dataModel = [[DataModel alloc]init];
    _dataModel.tableContoller = self;
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                    target:self
                                    action:@selector(newImage:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:NO];
    NSLog(@"appear");
    _dataModel = [[DataModel alloc]init];
    _dataModel.tableContoller = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newImage:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.navigationController presentViewController:picker animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        _fileName = [imageRep filename];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:assetURL resultBlock:resultblock failureBlock:nil];
    
//    __block NSString *fileName = nil;
//    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library assetForURL:assetURL resultBlock:^(ALAsset *asset)  {
//        fileName = asset.defaultRepresentation.fileName;
//    } failureBlock:nil];

    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage]) {
        UIImage* aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:aImage];
        editor.delegate = self;
        [picker pushViewController:editor animated:YES];
        
//        [picker dismissViewControllerAnimated:YES completion:^{
//            UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"골랐어요" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//            alertView1.alertViewStyle = UIAlertViewStyleDefault;
//            [alertView1 show];
//        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"안골랐네" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView1.alertViewStyle = UIAlertViewStyleDefault;
        [alertView1 show];
    }];
}

#pragma mark - CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    //image 사용하기
    WriteViewController* writeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TBPWriter"];
    [writeVC prepareData:image withFileName:_fileName];
    [editor dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:writeVC
                                         animated:NO];
    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataModel numberOfData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [_dataModel objectAtIndex:indexPath.row];
//    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    cell.textLabel.text = [item objectForKey:@"text"];
//    cell.detailTextLabel.text = [item objectForKey:@"content"];
//    cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"image"]];
//    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
//    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0];
    
    CustomCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    myCell.cellTitle.text = [item objectForKey:@"title"];
    //myCell.cellImage.image = [UIImage imageNamed:[item objectForKey:@"image"]];
    NSString* imgUrl = @"http://localhost:8080/images/";
    NSString* imgFileName = [item objectForKey:@"attachment"];
    NSString* finalUrl = [imgUrl stringByAppendingString:imgFileName];
    [myCell.cellImage setImageWithURL:[NSURL URLWithString:finalUrl]];
    
    return myCell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.row == 0) { //first row
//        return 140;
//    }
//    else {
//        return 140;
//    }
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowDetail"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary* item = [_dataModel objectAtIndex:indexPath.row];
        DetailViewController *destViewController = segue.destinationViewController;
        
        NSString* imgUrl = @"http://localhost:8080/images/";
        NSString* imgFileName = [item objectForKey:@"attachment"];
        NSString* finalUrl = [imgUrl stringByAppendingString:imgFileName];
        
        destViewController.recipeName = [item objectForKey:@"title"];
        destViewController.recipeContent = [item objectForKey:@"contents"];
        destViewController.recipeImage = finalUrl;
        destViewController.recipeComments = [item objectForKey:@"comments"];
    }
}

- (IBAction)returnedList:(UIStoryboardSegue *)segue {
}



//-(IBAction)link:(id)sender
//{
//
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"there");
//}
//
//-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    NSLog(@"HIHI");
//    return YES;
//}

@end
