//
//  JSBridgeSample.m
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//
//

#import "JSBridgeSample.h"
#import <UIKit/UIDevice.h>

#define JS_METHOD_BATTERYSTATE  @"batteryState"

// implement the subclass
@implementation JSBridgeSample

#pragma mark Bridge4iOS
- (id)init
{
    // assign a name for this object, which will be used in the Javascript code.
    // @js: window.iOSSample
    self = [super initWithName:@"iOSSample"];
    if (self)
    {
        
    }
    
    return self;
}

- (void)didFinalize
{
    [super didFinalize];
    
    // do nothing
}

#pragma mark exported methods

// declare the exported methods
BEGIN_EXPORTED_METHODS(16)
ADD_EXPORTED_METHOD(JS_METHOD_BATTERYSTATE,     @selector(_batteryState:))
END_EXPORTED_METHODS()

// implement the methods
// @js: window.iOSSample.exec('{"action":"batteryState","return_type":"string"}');
// @return: string
- (id)_batteryState:(NSDictionary *)params
{
    NSString *strAction = [params objectForKey:KEY_ACTION];         // check if the action matches the method name
    assert([strAction isEqualToString:JS_METHOD_BATTERYSTATE]);
    
    NSString *return_type = [params objectForKey:@"return_type"];   // read the parameters
    id result = nil;
    
    UIDeviceBatteryState state = [UIDevice currentDevice].batteryState;
    if ([return_type compare:@"string" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        result = [self batteryState2string:state];
    }
    else
    {
        result = [NSNumber numberWithInt:state];
    }
    
    // return a value to JS.
    return result;
}

#pragma mark helper
- (NSString*)batteryState2string:(UIDeviceBatteryState)state
{
    if (state == UIDeviceBatteryStateUnplugged)
    {
        return @"Unplugged";
    }
    else if (state == UIDeviceBatteryStateCharging)
    {
        return @"Charging";
    }
    else if (state == UIDeviceBatteryStateFull)
    {
        return @"100%";
    }
    
    return @"unknown";
}

@end