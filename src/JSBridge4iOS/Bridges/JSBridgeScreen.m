//
//  JSBridgeScreen.m
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//  
//

#import "JSBridgeScreen.h"
#import <UIKit/UIScreen.h>
#import <UIKit/UIApplication.h>

@implementation JSBridgeScreen

- (id)init
{
    self = [super initWithName:@"iOSScreen"];
    if (self)
    {
        
    }
    
    return self;
}

#pragma mark exported methods

#define JS_METHOD_BarOrientation        @"barOrientation"
- (NSString*)_statusBarOrientation:(NSDictionary*)params
{
    NSString *strAction = [params objectForKey:KEY_ACTION];
    assert([strAction isEqualToString:JS_METHOD_BarOrientation]);
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    return [self orientation2string:orientation];
}

// js: window.iOSScreen.exec('{"action":"rotateTo","to":"portrait","animated":1}');
#define JS_METHOD_Rotate2               @"rotateTo"
- (id)_rotate2:(NSDictionary*)params
{
    NSString *strAction = [params objectForKey:KEY_ACTION];
    assert([strAction isEqualToString:JS_METHOD_Rotate2]);
    
    NSString *toOrientation = [params objectForKey:@"to"];
    BOOL animated = [[params objectForKey:@"animated"] boolValue];
    
    int to = [self string2orientation:toOrientation];
    if (to != 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            // make sure to rotate the bar in main thread!
            [[UIApplication sharedApplication] setStatusBarOrientation:to animated:animated];
        });
    }
    
    return nil;
}

#pragma mark exportedMethods

BEGIN_EXPORTED_METHODS(16)
ADD_EXPORTED_METHOD(JS_METHOD_Rotate2,              @selector(_rotate2:))
ADD_EXPORTED_METHOD(JS_METHOD_BarOrientation,       @selector(_statusBarOrientation:))
END_EXPORTED_METHODS()

#pragma mark helper
- (int)string2orientation:(NSString*)str
{
    int ret = 0;
    
    if (![str isKindOfClass:[NSString class]] || [str length] == 0)
    {
        goto EXIT;
    }
    
    if ([str compare:@"Portrait" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        return UIInterfaceOrientationPortrait;
    }
    
    if ([str compare:@"UpsideDown" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        return UIInterfaceOrientationPortraitUpsideDown;
    }
    
    if ([str compare:@"LandscapeLeft" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        return UIInterfaceOrientationLandscapeLeft;
    }
    
    if ([str compare:@"LandscapeRight" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        return UIInterfaceOrientationLandscapeRight;
    }
    
EXIT:
    return ret;
}

- (NSString*)orientation2string:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationPortrait == orientation)
    {
        return @"Portrait";
    }

    if (UIInterfaceOrientationPortraitUpsideDown == orientation)
    {
        return @"UpsideDown";
    }
    
    if (UIInterfaceOrientationLandscapeLeft == orientation)
    {
        return @"LandscapeLeft";
    }
    
    if (UIInterfaceOrientationLandscapeRight == orientation)
    {
        return @"LandscapeRight";
    }
    
    return @"Unknown";
}

@end
