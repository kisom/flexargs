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

BOOL test_init_with_NSArray(void);              // verify initWithNSArray
BOOL test_instance_matches_class(void);         // verify initWithNSArray matches parserWithNSArray

int main(int argc, char *argv[])
{
    // skip the binary name
    argc--;
    argv++;
    NSLog(@"testing FlexArgs...\n");

    @autoreleasepool {
        NSLog(@"testing initialisation with NSArray...\n");
        assert(test_init_with_NSArray());

        NSLog(@"testing instance initialisation matches class...\n");
        assert(test_instance_matches_class());
    }
    return 0;
}

BOOL test_init_with_NSArray()
{
    NSArray *testArgs = [NSArray arrayWithObjects:
                            @"foo=bar",
                            @"baz=1",
                            @"quux=-2.5",
                            @"spam=footastic",
                            @"eggs=false", nil];
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"bar", @"foo",
                                [NSNumber numberWithLongLong:1], @"baz",
                                [NSNumber numberWithDouble:-2.5], @"quux",
                                @"footastic", @"spam",
                                [NSNumber numberWithBool:false], @"eggs", nil];
    FlexArgs *flexArgs = [[FlexArgs alloc] initParserWithNSArray:testArgs];
    NSDictionary *parsed = [flexArgs retrieveArgs];

    return [parsed isEqualToDictionary:expected];
}

BOOL test_instance_matches_class()
{
    NSArray *testArgs = [NSArray arrayWithObjects:
                            @"foo=bar",
                            @"baz=1",
                            @"quux=-2.5",
                            @"spam=footastic",
                            @"eggs=false", nil];    
    FlexArgs *flexInstance = [[FlexArgs alloc] initParserWithNSArray:testArgs];
    NSDictionary *instanceDictionary = [flexInstance retrieveArgs];

    NSDictionary *classDictionary = [[FlexArgs parserWithNSArray:testArgs] retrieveArgs];

    return [classDictionary isEqualToDictionary:instanceDictionary];
}