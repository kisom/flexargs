//
//  FlexArgsTest.m
//  FlexArgsTest
//
//  Created by Kyle Isom on 15/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexArgsTest.h"

@implementation FlexArgsTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_init_with_NSArray
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
    
    STAssertTrue([parsed isEqualToDictionary:expected], 
                 @"initParserWithNSArray failed to return the expected NSDictionary!");
}

-(void)test_instance_matches_class
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
    
    STAssertTrue([classDictionary isEqualToDictionary:instanceDictionary],
                 @"Class NSDictionary failed to match instance NSDictionary!");
}

@end
