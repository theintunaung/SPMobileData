//
//  NetworkManager.m
//  Movies
//
//  Created by TheinTunAung on 10/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "NetworkManager.h"
//#import "URLConnection.h"
static NSString * const baseAPI = @"https://data.gov.sg";
static NSString * const discoverPath = @"/api/action/datastore_search";
static NSString * const resourceId = @"a807b7ab-6cad-4aa6-87d0-e283a7353a0f";
static NSString * const limitCount = @"100";

@interface NetworkManager ()<NSURLSessionDelegate>

@end

@implementation NetworkManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self){
      
    }
    return self;
}

+ (void) getDatastoreonCompletion:(void (^)(BOOL success, id JSON))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?resource_id=%@&limit=%@", baseAPI, discoverPath,resourceId,limitCount]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          // do something with the data
                                          if (!error && data){
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                              NSLog(@"the response :\n%@", json);
                                              BOOL success = NO;
                                              NSArray *results = [json objectForKey:@"result"];
                                              if ([results count]>0) success = YES;
                                              if (completion) completion(success, json);
                                          }else {
                                              NSLog(@"%@", error);
                                              if (completion) completion(NO, nil);
                                          }
                                      }];
    [dataTask resume];
}

@end


