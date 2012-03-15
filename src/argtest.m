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
    @autoreleasepool {
        FlexArgs *flexargs = [[FlexArgs alloc] initParser:argv nargs:argc];
        NSDictionary *args = [flexargs retrieveArgs];
    }
    return 0;
}
