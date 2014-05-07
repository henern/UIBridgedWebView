//
//  JSBridgeDevice.h
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//  
//

#import <Foundation/Foundation.h>

// import the header file
#import <UIBridgedWebView/Bridge4iOS.h>


// declare the subclass from Bridge4iOS
@interface JSBridgeDevice : Bridge4iOS

- (id)init;

/*
 * declare the methods u want to export
 *  @signature: - (id)foo:(NSDictionary*)params
 *  @param:     MUST be NSDictionary*
 *  @return:    all basic type (NSString, NSNumber, nil, NSArray, ...) is OK
 */
- (id)_batteryState:(NSDictionary*)params;

@end
