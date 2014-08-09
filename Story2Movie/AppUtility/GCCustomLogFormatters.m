//
//  CustomLogFormatters.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCustomLogFormatters.h"

@implementation CustomLogFormatters

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    //Alter the message to your liking
    NSString *msg = [logMessage->logMsg stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR  : logLevel = @"E"; break;
        case LOG_FLAG_WARN   : logLevel = @"W"; break;
        case LOG_FLAG_INFO   : logLevel = @"I"; break;
        case LOG_LEVEL_DEBUG : logLevel = @"D"; break;
        default              : logLevel = @"V"; break;
    }
    
    //Also display the file the logging occurred in to ease later debugging
    NSString *file = [[[NSString stringWithUTF8String:logMessage->file] lastPathComponent] stringByDeletingPathExtension];
    
    //Format the message for the server-side log file parser
    return [NSString stringWithFormat:@"%@ %x %@ %@ || [%@@%s@%i]", logMessage->timestamp, logMessage->machThreadID, logLevel, msg, file, logMessage->function, logMessage->lineNumber];
}

@end
