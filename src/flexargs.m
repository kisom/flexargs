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

@interface FlexArgs ()

-(void)addBooleanArg:(NSString *)key booleanArg:(BOOL)boolArg;
-(void)addIntegerArg:(NSString *)key integerArg:(NSInteger *)intArg;
-(void)addFloatArg:(NSString *)key floatArt:(NSDecimal *)floatArg;
-(void)addStringArg:(NSString *)key (NSString *) stringArg:(NSString *)stringArg;

@end

@implementation FlexArgs

@end