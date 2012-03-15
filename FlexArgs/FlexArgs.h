//
//  flexargs.h
//  Flexible Arg Parsing
//
//  Created by Kyle Isom on 2012-03-14.
//  Copyright 2012 Kyle Isom. No rights reserved.
//  License: ISC / Public Domain license
//
//  Flexibly parse arguments - designed as a tool to aid in construction of
//  CLI test code.

#import <Foundation/Foundation.h>

@interface FlexArgs : NSObject
{
    NSMutableDictionary *args;

    // C-style args to be loaded in
    NSMutableArray *argv;
    int argc;
}

+(id)parserWithArgv:(char **)inargv nargs:(int)nargs;
+(id)parserWithNSArray:(NSArray *)inargv;
-(id)initParser:(char **)inargv nargs:(int)nargs;
-(id)initParserWithNSArray:(NSArray *)inargv;
-(NSDictionary *)retrieveArgs;

@end

