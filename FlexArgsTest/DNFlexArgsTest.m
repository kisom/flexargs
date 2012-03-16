//
//  FlexArgsTest.m
//  FlexArgsTest
//
//  Created by Kyle Isom on 15/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DNFlexArgsTest.h"

@implementation DNFlexArgsTest

- (void)setUp
{
    [super setUp];
    NSLog(@"running test");
    
}

- (void)tearDown
{
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
    DNFlexArgs *flexArgs = [[DNFlexArgs alloc] initParserWithNSArray:testArgs];
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
    DNFlexArgs *flexInstance = [[DNFlexArgs alloc] initParserWithNSArray:testArgs];
    NSDictionary *instanceDictionary = [flexInstance retrieveArgs];
    
    NSDictionary *classDictionary = [[DNFlexArgs parserWithNSArray:testArgs] retrieveArgs];
    
    STAssertTrue([classDictionary isEqualToDictionary:instanceDictionary],
                 @"Class NSDictionary failed to match instance NSDictionary!");
}

-(void)test_argv
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

    int argc = [testArgs count];
    char **argv = calloc(argc + 1, sizeof(char *));
    
    for (int i = 0; i < argc; ++i) {
        argv[i] = calloc(65, sizeof(char));
        strncpy(argv[i], [[testArgs objectAtIndex:i] UTF8String], 64);
    }
    
    NSDictionary *argvDictionary = [[DNFlexArgs parserWithArgv:argv nargs:argc] retrieveArgs];
    
    STAssertTrue([argvDictionary isEqualToDictionary:expected],
                 @"argv-loaded dictionary does not match expected.");
    
    for (int i = 0; i < argc; ++i) {
        free(argv[i]);
        argv[i] = NULL;
    }
    free(argv);
    argv = NULL;
}

-(void)testOverflowLong
{
    NSString *longLongString = @"overflow=18446744073709551626";
    NSArray *argv = [NSArray arrayWithObject:longLongString];
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithLongLong:18446744073709551615ULL],
                              @"overflow", nil];
    NSDictionary *overflow = [[DNFlexArgs parserWithNSArray:argv] retrieveArgs];
    
    STAssertFalse([expected isEqualToDictionary:overflow],
                 @"overflow matches expected!");
}

-(void)testNullByteInString
{
    NSArray *badArgs = [NSArray arrayWithObject:@"foo=\0bar"];
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"bar", @"foo", nil];
    NSDictionary *args = [[DNFlexArgs parserWithNSArray:badArgs] retrieveArgs];
    STAssertFalse([args isEqualToDictionary:expected],
                 @"expected did not match results.");
    
}

-(void)testEqualSignInKey
{
    NSArray *args = [NSArray arrayWithObjects:@"foo=bar=baz",
                                              @"quux==spam",
                                              @"operator===", nil];
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"bar=baz", @"foo", 
                              @"==", @"operator",
                              @"=spam", @"quux",
                              nil];
    NSDictionary *results = [[DNFlexArgs parserWithNSArray:args] retrieveArgs];
    STAssertTrue([results isEqualToDictionary:expected],
                 @"results do not match expected!");
}

@end
