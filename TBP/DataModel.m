//
//  DataModel.m
//  TBP
//
//  Created by SunJin, Choi on 2013. 12. 4..
//  Copyright (c) 2013년 NHNNEXT. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
{
    NSArray* _itemArray;
    NSArray* _itemArray2;
    NSDictionary* _itemDictionary;
    NSMutableDictionary* _loginData;
    NSMutableData* _responseData;
}

- (id)init
{
    self = [super init];
    if (self) {
        //_itemArray = @[@"apple", @"MS", @"linux"];
//        _itemArray2 = [@[
//                        @{@"text":@"Drop of Water", @"content":@"Drop of Water on blue thing", @"image":@"http://www.ilikewallpaper.net/iphone-5-wallpapers/download/4938/Blue-Drops-iphone-5-wallpaper-ilikewallpaper_com.jpg"},
//                        @{@"text":@"Dew", @"content":@"Dew on pink flower", @"image":@"http://webtoolfeed.files.wordpress.com/2012/10/tumblr_mc04thy3br1rhztfto1_1280.jpg"},
//                        @{@"text":@"Valley", @"content":@"Valley in winter mountain", @"image":@"http://www.animhut.com/wp-content/uploads//2012/09/Download-iPhone5-Retina-HD-Wallpapers-12.jpg"},
//                        @{@"text":@"Drop of Water", @"content":@"Drop of Water on blue thing", @"image":@"http://www.ilikewallpaper.net/iphone-5-wallpapers/download/4938/Blue-Drops-iphone-5-wallpaper-ilikewallpaper_com.jpg"},
//                        @{@"text":@"Dew", @"content":@"Dew on pink flower", @"image":@"http://webtoolfeed.files.wordpress.com/2012/10/tumblr_mc04thy3br1rhztfto1_1280.jpg"},
//                        @{@"text":@"Valley", @"content":@"Valley in winter mountain", @"image":@"http://www.animhut.com/wp-content/uploads//2012/09/Download-iPhone5-Retina-HD-Wallpapers-12.jpg"}
//                        ] mutableCopy];
//        _itemDictionary = @{@"name":@"sunjin", @"age":@4, @"female":@YES, @"array":_itemArray2};
//        
        //NSMutableArray* _newArray = [@[@"apple"] mutableCopy]; //
        _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        _responseData = [[NSMutableData alloc] initWithCapacity:100];
        //NSString *aURLString = @"http://1.234.2.8/board.php";
        NSString *aURLString = @"http://localhost:8080/board/list.json";
        NSURL *aURL = [NSURL URLWithString:aURLString];
        NSURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:aRequest delegate:self startImmediately:YES];
        NSLog(@"DATAMODEL INIT");
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary* resultDic = [NSJSONSerialization
                            JSONObjectWithData:_responseData
                            options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"result json = %@", resultDic);
    _itemArray = [resultDic objectForKey:@"boardlist"];
    
    [_tableContoller.tableView reloadData];
    NSLog(@"item array = %@", _itemArray);
    NSLog(@"RELOAD");
}

-(NSString*)getID
{
    return _loginData[@"userid"];
}

-(NSString*)getPassword
{
    return _loginData[@"password"];
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index
{
    return _itemArray[index];
}

-(NSInteger)numberOfData
{
    return [_itemArray count];
}

-(void)addItem:(NSDictionary*)item
{
    
}

- (NSString*) description
{
    return _loginData.description;
}

-(BOOL)saveID:(NSString*)userid withName:(NSString*)name withPassword:(NSString*)password
{
    //    [_loginData setObject:userid forKey:@"userid"];
    //    [_loginData setObject:password forKey:@"password"];
    
    NSString *aURLString = @"http://localhost:8080/login/new.json";
    NSString *aFormData = [NSString stringWithFormat:@"name=%@&userid=%@&password=%@", name, userid,password];
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:[aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    
    NSDictionary *dataDictionary = [NSJSONSerialization
                                    JSONObjectWithData:aResultData
                                    options:NSJSONReadingMutableContainers
                                    error:nil];
    
//    NSLog(@"login Data = %@", aResultData);
//    NSLog(@"login response = %d", aResponse.statusCode);
//    NSLog(@"login result = %@", dataDictionary);
    NSLog(@"SIGNIN COMPLETE");
    
    if ([dataDictionary[@"code"] isEqualToNumber:@200]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)authenticateID:(NSString*)userID withPassword:(NSString*)password
{
//    NSString *aURLString = @"http://1.234.2.8/login.php";
//    NSString *aFormData = [NSString stringWithFormat:@"id=%@&passwd=%@", userID, password];
    NSString *aURLString = @"http://localhost:8080/login/get.json";
    NSString *aFormData = [NSString stringWithFormat:@"userid=%@&password=%@", userID, password];
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:[aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    
    NSDictionary *dataDictionary = [NSJSONSerialization
                          JSONObjectWithData:aResultData
                          options:NSJSONReadingMutableContainers
                          error:nil];
    
//    NSLog(@"login Data = %@", aResultData);
//    NSLog(@"login response = %d", aResponse.statusCode);
//    NSLog(@"login result = %@", dataDictionary);
    NSLog(@"LOGIN COMPLETE");
    
    if ([dataDictionary[@"code"] isEqualToNumber:@200]) {
        return YES;
    } else {
        return NO;
    }

}

-(BOOL) newPost:(NSString*)title withText:(NSString*)text withImage:(NSData*)image withFileName:(NSString*)filename
{
    NSDateFormatter *now = [[NSDateFormatter alloc] init];
    [now setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString* date = [now stringFromDate:[NSDate date]];
    
    NSString *aURLString = @"http://localhost:8080/board";
    //NSString *aFormData = [NSString stringWithFormat:@"title=%@&contents=%@", title, text];
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [aRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"title"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"contents"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img_file\"; filename=\"%@.jpg\"\r\n",date] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData: [aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData: [NSData dataWithData:image]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [aRequest setHTTPBody:body];
    
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    //NSLog(@"Newpost Data = %@", aResultData);
    return NO;
}
@end