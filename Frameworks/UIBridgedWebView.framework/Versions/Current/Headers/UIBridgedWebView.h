//
//  UIBridgedWebView.h
//  UIBridgedWebView
//
//  Created by Wayne W on 9/24/12.
//
//

#import <UIKit/UIKit.h>

@interface UIBridgedWebView : UIWebView

- (id)getWindowJSObj:(NSString*)name;
- (BOOL)injectObjToWindow:(id)obj;
- (id)removeJSObj:(NSString*)name;

// execute a JS method in the UIWebView
// NOTE: params MUST be nil, an instance of NSDictionary, or a NSArray
- (NSString*)evaluateJS:(NSString *)method withParams:(id)params async:(BOOL)bAsync;

@end
