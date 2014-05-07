//
//  JSBridgeScreen.h
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//  
//

#import <UIBridgedWebView/Bridge4iOS.h>

@interface JSBridgeScreen : Bridge4iOS

// @js:     window.iOSScreen.exec('{"action":"barOrientation"}');
// @return: "portrait", "landscapeLeft", ... (string)
- (NSString*)_statusBarOrientation:(NSDictionary*)params;

// @js:     window.iOSScreen.exec('{"action":"rotateTo","to":"portrait","animated":1}');
// @param:  to (string) ==> target orientation
//          animated (number) ==> 0 or 1
// @return: nil
- (id)_rotate2:(NSDictionary*)params;

@end
