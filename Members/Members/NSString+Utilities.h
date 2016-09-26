//
//  NSString+Utilities.h
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)
#pragma mark - Empty String Check
+(BOOL ) stringIsEmpty:(NSString *) aString;

#pragma mark - Create empty string if given String is null
+(NSString* ) createStringWithString:(NSString *) aString;
@end
