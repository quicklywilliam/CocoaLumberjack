//
//  HBLogFormatter.h
//  Knock for Mac
//
//  Created by William Henderson on 11/21/13.
//  Copyright (c) 2013 Serious Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface HBLogFormatter : NSObject <DDLogFormatter> {
    int loggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
