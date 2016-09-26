//
//  NSDate+Utility.m
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)
+(NSInteger)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthdate
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}
+(NSDate*)createDateWithDateString:(NSString*)dateString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [df dateFromString: dateString];
    return myDate;
}
@end
