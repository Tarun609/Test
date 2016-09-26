//
//  NSDate+Utility.h
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)
+(NSInteger)ageFromBirthday:(NSDate *)birthdate;
+(NSDate*)createDateWithDateString:(NSString*)dateString;
@end
