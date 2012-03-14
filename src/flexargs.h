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

@interface FlexArgs : NSObject
{
    NSMutableDictionary *args;

    // C-style args to be loaded in
    char **argv;
    int argc;
}

-(BOOL)initParser:(char **)argv nargs:(int)argc;
-(NSDictionary *)retrieveArgs;

@end

