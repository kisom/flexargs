//
//  example.m
//  Example illustrating basic usage of FlexArgs.
//
//  Created by Kyle Isom on 2012-03-14.
//  Copyright 2012 Kyle Isom. No rights reserved.
//  License: ISC / Public Domain license
//
//  Prints back a dictionary of args passed in.

#import <Foundation/Foundation.h>
#import "FlexArgs.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        argc--;     // skip the first arg, which contains the binary name
        argv++;

        NSDictionary *argumentDict = [[FlexArgs parserWithArgv:argv nargs:argc] retrieveArgs];
        NSLog(@"argumentDict = %@", argumentDict);
        [argumentDict writeToFile:@"argumentDict.plist" atomically:YES];
    }

    return 0;
}
