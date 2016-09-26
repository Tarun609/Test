//
//  NSString+Utilities.m
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)
+(BOOL ) stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

+(NSString* ) createStringWithString:(NSString *) aString
{
    return ((aString== nil) || ([aString isKindOfClass:[NSNull class]])) ? @"" : aString;
}
@end
