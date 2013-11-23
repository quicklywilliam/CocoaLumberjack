//
//  HBLogFormatter.m
//  Knock for Mac
//
//  Created by William Henderson on 11/21/13.
//  Copyright (c) 2013 Serious Software. All rights reserved.
//

#import "HBLogFormatter.h"

@implementation HBLogFormatter

- (id)init
{
    if((self = [super init]))
    {
        threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [threadUnsafeDateFormatter setDateFormat:@"MM/dd HH:mm:ss:SSS"];
    }
    return self;
}

- (void)dealloc;
{
    [threadUnsafeDateFormatter release];
    
    [super dealloc];
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR : logLevel = @"E"; break;
        case LOG_FLAG_WARN  : logLevel = @"W"; break;
        case LOG_FLAG_INFO  : logLevel = @"I"; break;
        case LOG_FLAG_DEBUG : logLevel = @"D"; break;
        default             : logLevel = @"V"; break;
    }
    
    NSString *dateAndTime = [threadUnsafeDateFormatter stringFromDate:(logMessage->timestamp)];
    
    return [NSString stringWithFormat:@"%@:%@ [%@ %@] + %d | %@", logLevel, dateAndTime, [logMessage fileName], [logMessage methodName], logMessage->lineNumber, logMessage->logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger
{
    loggerCount++;
    NSAssert(loggerCount <= 1, @"This logger isn't thread-safe");
}
- (void)willRemoveFromLogger:(id <DDLogger>)logger
{
    loggerCount--;
}

@end
