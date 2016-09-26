//
//  MBMembersUtility.h
//  Members
//
//  Created by Tarun on 23/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^responceblock) (NSArray *responceArray,NSError *error);

@interface MBMembersUtility : NSObject
+ (instancetype)sharedUtility;
-(void)getAllMembersListWithResponceBlock:(responceblock)responceblock;
-(void)getAllMembersListWithLimit:(int)limitCount
                    ResponceBlock:(responceblock)responceblock;
-(void)getAllMembersListWithLimit:(int)limitCount
                          andSkip:(int)skipCount
                    ResponceBlock:(responceblock)responceblock;
-(void)getAllMembersListWithSortByUserNameInASCorderResponceBlock:(responceblock)responceblock;
-(void)getAllMembersListWithSortByUserNameInASCorderWithLimit:(int)limitCount
                                                      andSkip:(int)skipCount
                                                ResponceBlock:(responceblock)responceblock;


@end
