//
//  MBMembersUtility.m
//  Members
//
//  Created by Tarun on 23/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "MBMembersUtility.h"
#import "Constants.h"
#import <AFNetworking/AFNetworking.h>

@implementation MBMembersUtility

#pragma  mark getMemberApi
-(void)getAllMembersListWithResponceBlock:(responceblock)responceblock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KGETMembersURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (task.state==NSURLSessionTaskStateCompleted) {
            responceblock(responseObject,nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (error!=nil) {
            responceblock(nil,error);
        }
        NSLog(@"Error: %@", error);
    }];
}
#pragma  mark getMemberlist Api with limit
-(void)getAllMembersListWithLimit:(int)limitCount
                    ResponceBlock:(responceblock)responceblock
{
    NSString *url = [NSString stringWithFormat:@"%@%d",KGETMembersURLWithLimit,limitCount];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (task.state==NSURLSessionTaskStateCompleted) {
            responceblock(responseObject,nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (error!=nil) {
            responceblock(nil,error);
        }
        NSLog(@"Error: %@", error);
    }];
}
#pragma  mark getMemberlist Api with limit and skip

-(void)getAllMembersListWithLimit:(int)limitCount
                          andSkip:(int)skipCount
                    ResponceBlock:(responceblock)responceblock
{
    NSString *url = [NSString stringWithFormat:@"%@?limit=%d&skip=%d",KGETMembersURL,limitCount,skipCount];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (task.state==NSURLSessionTaskStateCompleted) {
            responceblock(responseObject,nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (error!=nil) {
            responceblock(nil,error);
        }
        NSLog(@"Error: %@", error);
    }];
}
#pragma  mark getMemberlist Api with sort according to userName
-(void)getAllMembersListWithSortByUserNameInASCorderResponceBlock:(responceblock)responceblock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KGETMembersURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (task.state==NSURLSessionTaskStateCompleted) {
            responceblock(responseObject,nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (error!=nil) {
            responceblock(nil,error);
        }
        NSLog(@"Error: %@", error);
    }];
}
#pragma  mark getMemberlist Api with limit and skip count and sorting

-(void)getAllMembersListWithSortByUserNameInASCorderWithLimit:(int)limitCount
                                                      andSkip:(int)skipCount
                                                ResponceBlock:(responceblock)responceblock
{
    NSString *url = [NSString stringWithFormat:@"%@?sort=userName%s&limit=%d&skip=%d",KGETMembersURL,"%20ASC",limitCount,skipCount];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (task.state==NSURLSessionTaskStateCompleted) {
            responceblock(responseObject,nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (error!=nil) {
            responceblock(nil,error);
        }
        NSLog(@"Error: %@", error);
    }];
}

+ (instancetype)sharedUtility
{
    static MBMembersUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MBMembersUtility alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
@end
