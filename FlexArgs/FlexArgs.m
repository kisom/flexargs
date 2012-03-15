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

#import "FlexArgs.h"

@interface DNFlexArgs() 

@property (nonatomic, strong) NSMutableDictionary *args;
@property (nonatomic, strong) NSMutableArray *argv;
@property int argc;

-(void)addBooleanArg:(NSString *)key booleanArg:(NSString *)value;
-(void)addIntegerArg:(NSString *)key integerArg:(NSString *)value;
-(void)addFloatArg:(NSString *)key floatArg:(NSString *)value;
-(void)addStringArg:(NSString *)key stringArg:(NSString *)value;
-(void)parse;
-(NSString *)getType:(NSString *)value;

@end

@implementation DNFlexArgs
@synthesize args, argc, argv;

-(void)addBooleanArg:(NSString *)key booleanArg:(NSString *)value
{
    NSNumber *bvalue = [NSNumber numberWithBool:[value boolValue]];
    [args setValue:bvalue forKey:key];
}

-(void)addIntegerArg:(NSString *)key integerArg:(NSString *)value
{
    NSNumber *intValue = [NSNumber numberWithLongLong:[value longLongValue]];
    [args setValue:intValue forKey:key];
}

-(void)addFloatArg:(NSString *)key floatArg:(NSString *)value
{
    NSNumber *floatValue = [NSNumber numberWithDouble:[value doubleValue]];
    [args setValue:floatValue forKey:key];
}

-(void)addStringArg:(NSString *)key stringArg:(NSString *)value
{
    [args setValue:value forKey:key];
}

-(NSString *)getType:(NSString *)value
{
    // if you don't check both scanInt and isAtEnd, scanInt will return true
    // for floating-point values as well. Scan for integers first - otherwise,
    // the float will pick them up.
    NSScanner *intScanner = [NSScanner localizedScannerWithString:value];
    NSScanner *hexIntScanner = [NSScanner localizedScannerWithString:value];

    if (value == nil)
        return @"nil";
    else if ((NSOrderedSame == [value localizedCaseInsensitiveCompare:@"true"]) ||
             (NSOrderedSame == [value localizedCaseInsensitiveCompare:@"false"]))
        return @"boolean";
    else if (([intScanner scanInt:NULL]) && ([intScanner isAtEnd]))
        return @"integer";
    else if (([hexIntScanner scanHexLongLong:NULL]) && ([hexIntScanner isAtEnd]))
        return @"integer";
    else if ([[NSScanner localizedScannerWithString:value] scanDouble:NULL])
        return @"float";
    else 
        return @"string";
}

-(void)parse
{
    int i = self.argc;

    while (i > 0) {
        NSArray *argval = [[argv objectAtIndex:(self.argc - i)] componentsSeparatedByString:@"="];
        NSString *key = [argval objectAtIndex:0];
        NSString *val = nil;

        if ([argval count] == 1)
            val = @"true";
        else
            val = [argval objectAtIndex:1];

        NSString *type = [self getType:val];

        if (NSOrderedSame == [@"boolean" localizedCaseInsensitiveCompare:type])
            [self addBooleanArg:key booleanArg:val];
        else if (NSOrderedSame == [@"integer" localizedCaseInsensitiveCompare:type])
            [self addIntegerArg:key integerArg:val];
        else if (NSOrderedSame == [@"float" localizedCaseInsensitiveCompare:type])
            [self addFloatArg:key floatArg:val];
        else if (NSOrderedSame == [@"string" localizedCaseInsensitiveCompare:type])
            [self addStringArg:key stringArg:val];

        --i;
    }
}

-(id)initParser:(char **)inargv nargs:(int)nargs
{
    int i = 0;

    self = [super init];
    if (!self)
        return self;

    self.argc = nargs;
    self.argv = [NSMutableArray arrayWithCapacity:(self.argc + 1)];
    while (i < nargs){
        [self.argv addObject:[NSString stringWithUTF8String:inargv[i]]];
        i++;
    }

    self.args = [NSMutableDictionary dictionaryWithCapacity:(self.argc + 1)];
    [self parse];

    return self;
}

-(id)initParserWithNSArray:(NSArray *)inargv
{
    self = [super init];
    if (!self)
        return self;

    self.argc = [inargv count];
    self.argv = [NSArray arrayWithArray:inargv];
    self.args = [NSMutableDictionary dictionaryWithCapacity:(self.argc + 1)];
    [self parse];
    return self;

}

-(NSDictionary *)retrieveArgs
{
    return [NSDictionary dictionaryWithDictionary:[self args]];
}

+(id)parserWithArgv:(char **)inargv nargs:(int)nargs
{
    DNFlexArgs *flexArgs = [[DNFlexArgs alloc] initParser:inargv nargs:nargs];
    return flexArgs;
}

+(id)parserWithNSArray:(NSArray *)inargv
{
    DNFlexArgs *flexArgs = [[DNFlexArgs alloc] initParserWithNSArray:inargv];
    return flexArgs;
}
@end