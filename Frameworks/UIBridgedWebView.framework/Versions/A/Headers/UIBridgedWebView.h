//
//  UIBridgedWebView.h
//  UIBridgedWebView
//
//  Created by Wayne W on 9/24/12.
//
//

#import <UIKit/UIKit.h>

// UIBridgedWebView
//      A wrapper around UIWebView, which also listen to the FrameLoadDelegate of Webkit
//
//      delegate or sub-class should implement this callback, to do the injection.
//      - (void)bridgeWebViewDidClearWindowObj:(UIBridgedWebView*)webView
//      - (void)bridgeWebView:(UIBridgedWebView*)view didRecvTitle:(id)title
//      - (void)bridgeWebViewDidFinishLoad:(UIBridgedWebView *)webView
@interface UIBridgedWebView : UIWebView

- (id)getWindowJSObj:(NSString*)name;
- (BOOL)injectObjToWindow:(id)obj;
- (id)removeJSObj:(NSString*)name;

// execute a JS method in the UIWebView
// NOTE: params MUST be nil, an instance of NSDictionary, or a NSArray
- (NSString*)evaluateJS:(NSString *)method withParams:(id)params async:(BOOL)bAsync;

@end
