//
//  flexargs.m
//  Flexible Arg Parsing
//
//  Created by Kyle Isom on 2012-03-14.
//  Copyright 2012 Kyle Isom. No rights reserved.
//  License: ISC / Public Domain license
//
//  Flexibly parse arguments - designed as a tool to aid in construction of
//  CLI test code.

#import <Cocoa/Cocoa.h>
#import "flexargs.h"

@interface FlexArgs() 

@property (nonatomic, strong) NSMutableDictionary *args;
@property char **argv;
@property int argc;

-(void)addBooleanArg:(NSString *)key booleanArg:(BOOL)boolArg;
-(void)addIntegerArg:(NSString *)key integerArg:(NSInteger *)intArg;
-(void)addFloatArg:(NSString *)key floatArt:(NSDecimal *)floatArg;
-(void)addStringArg:(NSString *)key stringArg:(NSString *)stringArg;

@end

@implementation FlexArgs
@synthesize args, argc, argv;

-(void)addBooleanArg:(NSString *)key booleanArg:(BOOL)boolArg
{
    [[self args] setValue:boolArg forKey:key];
    return;
}

-(void)addIntegerArg:(NSString *)key integerArg:(NSInteger *)intArg
{
    return;
}

-(void)addFloatArg:(NSString *)key floatArt:(NSDecimal *)floatArg
{
    return;
}

-(void)addStringArg:(NSString *)key stringArg:(NSString *)stringArg
{
    return;
}

-(id)initParser:(char **)inargv nargs:(int)nargs
{
    int i = nargs;

    NSLog(@"-(id)initParser\n");

    self = [super init];
    if (!self)
        return self;

    self.argc = nargs;
    self.argv = inargv;
    args = [NSMutableDictionary dictionaryWithCapacity:(self.argc + 1)];

    NSLog(@"i -> %d\n", i);
    while (i > 0) {
        NSString *arg = [NSString stringWithUTF8String:self.argv[argc - i]];
        NSLog(@"read arg: %@\n", arg);
        NSArray *argval = [arg componentsSeparatedByString:@"="];
        NSString *key = [argval objectAtIndex:0];
        NSString *val = [argval objectAtIndex:1];

        if ((val == @"true") || (val == @"false"))
            [self addBooleanArg:key booleanArg:[val boolValue]];

        --i;
    }

    return self;
}

-(NSDictionary *)retrieveArgs
{
    return [NSDictionary dictionaryWithDictionary:[self args]];
}

@end