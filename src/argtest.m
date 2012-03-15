//
//  argtest.m
//  Test code for Flexible Arg Parsing
//
//  Created by Kyle Isom on 2012-03-14.
//  Copyright 2012 Kyle Isom. No rights reserved.
//  License: ISC / Public Domain license
//
//  These are the tests for the FlexArg code.

#import <Foundation/Foundation.h>
#import "flexargs.h"

int main(int argc, char *argv[])
{
    NSLog(@"number of args: %d\n", argc);

    // skip the binary name
    argc--;
    argv++;
    NSLog(@"actual number of args: %d\n\n", argc);

    NSLog(@"argument list:\n");
    for (int i = 0; i < argc; ++i)
        NSLog(@"arg %d: %s\n", argc, argv[i]);

    @autoreleasepool {
        FlexArgs *flexargs = [[FlexArgs alloc] initParser:argv nargs:argc];
        NSDictionary *args = [flexargs retrieveArgs];
        [args writeToFile:@"result.txt" atomically:true];
    }
    return 0;
}
