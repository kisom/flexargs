//
//  testrun.m
//  Test runner for Flexible Arg Parsing
//
//  Created by Kyle Isom on 2012-03-14.
//  Copyright 2012 Kyle Isom. No rights reserved.
//  License: ISC / Public Domain license
//
//  Driver to run tests in FlexArgsTests.

#import <Foundation/Foundation.h>
#import "FlexArgs.h"

int main(int argc, char *argv[])
{
    NSLog(@"number of args: %d\n", argc);

    // skip the binary name
    argc--;
    argv++;
    NSLog(@"actual number of args: %d\n\n", argc);

    NSLog(@"argument list:\n");
    for (int i = 0; i < argc; ++i)
        NSLog(@"arg %d: %s\n", i, argv[i]);

    @autoreleasepool {
        NSArray *testArgs = [NSArray arrayWithObjects:
                                @"foo=bar",
                                @"baz=1",
                                @"quux=-2.5",
                                @"spam=footastic",
                                @"eggs=false", nil];
        FlexArgs *flexArgsCL = [[FlexArgs alloc] initParser:argv nargs:argc];
        FlexArgs *flexArgsTA = [[FlexArgs alloc] initParserWithStringArray:testArgs];
        NSDictionary *argsCL = [flexArgsCL retrieveArgs];
        NSDictionary *argsTA = [flexArgsTA retrieveArgs];

        [argsCL writeToFile:@"resultsCL.txt" atomically:YES];
        [argsTA writeToFile:@"resultsTA.txt" atomically:YES];
    
    }
    return 0;
}

