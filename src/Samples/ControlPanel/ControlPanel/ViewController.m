//
//  ViewController.m
//  ControlPanel
//
//  Created by Wayne W on 14-5-7.
//  Copyright (c) 2014年 Wayne W. All rights reserved.
//

#import "ViewController.h"
#import <JSBridge4iOS/JSBridge4iOS.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBridgedWebView *webView = [[UIBridgedWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self _setupWebView:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webpage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private
- (void)_setupWebView:(UIBridgedWebView*)wv
{
    JSBridgeDevice *brdgDevice = [[JSBridgeDevice alloc] init];
    BOOL ret = [brdgDevice injectTo:wv];
    
    assert(ret);
}

@end
