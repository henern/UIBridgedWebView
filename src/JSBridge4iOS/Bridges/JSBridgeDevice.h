//
//  JSBridgeDevice.h
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//  
//

#import <Foundation/Foundation.h>
#import <UIBridgedWebView/Bridge4iOS.h>


@interface JSBridgeDevice : Bridge4iOS

/*
 *  @js:        window.iOSDevice.exec('{"action":"batteryState","return_type":"string"}');
 *  @param:     return_type (string) ==> "string" or "number"
 *  @return:    the battery state (string or number, according to @param)
 */
- (id)_batteryState:(NSDictionary*)params;

@end
