# flexargs
## an Objective-C library for flexible argument parsing in CLI programs

Authors: [Kyle Isom](http://www.kyleisom.net/about) and 
[Samuel Goodwin](http://samuelgoodwin.tumblr.com)

License: [ISC / public domain dual-licensed](http://www.brokenlcd.net/license.txt)

This is a library to flexibly parse arguments via the command line. It provides two methods,
parserWithArgv:nargs and parserWithNSArray, to take in command line options key=value pairs
and return an NSDictionary with those values. 

## Example:

```objc

#import <Foundation/Foundation.h>
#import "FlexArgs.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        argc--;     // skip the first arg, which contains the binary name
        argv++;

        NSDictionary *argumentDict = [[FlexArgs parserWithArgv:argv nargs:argc] retrieveArgs];
        NSLog(@"argumentDict = %@", argumentDict);
    }

    return 0;
}
```

which might yield a session like:

```bash
<voytek: ~/Code/flexargs> λ src/example foo=bar baz=234283492034 quux=-8123.1231
24 spam='hello world' eggs=false
2012-03-15 16:06:29.815 example[40173:707] argumentDict = {
    baz = 234283492034;
    eggs = 0;
    foo = bar;
    quux = "-8123.123124";
    spam = "hello world";
}
<voytek: ~/Code/flexargs> λ 
```