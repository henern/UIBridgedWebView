//
//  JSBridgeDevice.m
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//
//

#import "JSBridgeDevice.h"
#import <UIKit/UIDevice.h>

@implementation JSBridgeDevice

#pragma mark Bridge4iOS
- (id)init
{
    self = [super initWithName:@"iOSDevice"];
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

#pragma mark expoted methods

#define JS_METHOD_BATTERYSTATE  @"batteryState"
- (id)_batteryState:(NSDictionary *)params
{
    NSString *strAction = [params objectForKey:KEY_ACTION];         
    assert([strAction isEqualToString:JS_METHOD_BATTERYSTATE]);
    
    NSString *return_type = [params objectForKey:@"return_type"];   
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
    
    return result;
}

#pragma mark method table
BEGIN_EXPORTED_METHODS(16)
ADD_EXPORTED_METHOD(JS_METHOD_BATTERYSTATE,     @selector(_batteryState:))
END_EXPORTED_METHODS()

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