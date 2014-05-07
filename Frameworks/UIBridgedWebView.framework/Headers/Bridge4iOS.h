//
//  Bridge4iOS.h
//  UIBridgedWebView
//
//  Created by Wayne W on 9/24/12.
//  
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>
#import "Bridge4iOSCommon.h"
#import "UIBridgedWebView.h"

/***********************************************************************************************
// NOTE: make sure the implementation of subclass is THREAD-SAFE!!
//       this is non-ARC.
***********************************************************************************************/
@interface Bridge4iOS : NSObject
{
    NSString *_name;
    UIBridgedWebView *_webView;
}

@property (nonatomic, retain) NSString *name;

- (id)initWithName:(NSString*)name;
- (BOOL)injectTo:(UIBridgedWebView*)webView;
- (BOOL)removeFromWebView;

// NOTE:
//      u MUST call this method in main-thread, if bAsync is NO
// Sample-code:
//      NSDictionary *param = [NSDictionary dictionaryWithObject:@"I AM A SAMPLE TEXT" forKey:@"message"];
//      [self evaluateJS:@"window.doAlert" withParams:param async:YES];
- (NSString*)evaluateJS:(NSString*)method withParams:(NSDictionary*)params async:(BOOL)bAsync;

// NOTE: get executed before UIBridgedWebView release this obj.
//       subclass should implement this method to release its resource.
//       !!! this method may be called MORE THAN ONCE !!!
- (void)didFinalize;

@end
