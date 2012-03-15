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
    self = [super init];
    if (self) {
        self.argc = nargs;
        self.argv = inargv;
        args = [NSMutableDictionary dictionaryWithCapacity:(self.argc + 1)];
    }

    return self;
}

-(NSDictionary *)retrieveArgs
{
    return [NSDictionary dictionaryWithDictionary:[self args]];
}

@end