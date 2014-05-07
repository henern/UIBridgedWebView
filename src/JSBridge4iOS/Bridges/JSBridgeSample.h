//
//  JSBridgeSample.h
//  JSBridge4iOS
//
//  Created by Wayne W on 14-5-7.
//
//  This is a sample bridge, which exports a Javascript object named iOSSample.
//  iOSSample supportes one method named batteryState.
//  please check the inline comments for more details.
//

#import <Foundation/Foundation.h>

// import the header file
#import <UIBridgedWebView/Bridge4iOS.h>


// need a subclass from Bridge4iOS
@interface JSBridgeSample : Bridge4iOS

- (id)init;

/*
 *  Declare the methods u want to export. 
 *
 *  @signature: - (id)foo:(NSDictionary*)params
 *  @param:     MUST be NSDictionary*
 *  @return:    all basic type (NSString, NSNumber, nil, NSArray, ...) is OK
 *
 *  So on javascript side, the code looks like this: 
 *  window.iOSSample.exec('{"action":"batteryState","return_type":"string"}');
 */
- (id)_batteryState:(NSDictionary*)params;

@end
