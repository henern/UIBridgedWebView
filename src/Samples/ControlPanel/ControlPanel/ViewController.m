//
//  ViewController.m
//  ControlPanel
//
//  Created by Wayne W on 14-5-7.
//  
//

#import "ViewController.h"
#import <JSBridge4iOS/JSBridge4iOS.h>
#import <math.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_appBarOrientationChanged:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark private
- (void)_setupWebView:(UIBridgedWebView*)wv
{
    JSBridgeDevice *brdgDevice = [[JSBridgeDevice alloc] init];
    BOOL ret = [brdgDevice injectTo:wv];
    
    assert(ret);
    
    JSBridgeScreen *brdgScreen = [[JSBridgeScreen alloc] init];
    ret = [brdgScreen injectTo:wv];
    assert(ret);
}

- (void)_appBarOrientationChanged:(NSNotification*)notif
{
    NSDictionary *userInfo = notif.userInfo;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    UIInterfaceOrientation newTo = [[userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    if (newTo == UIInterfaceOrientationLandscapeLeft)
    {
        rect.size.width = [UIScreen mainScreen].bounds.size.height;
        rect.size.height = [UIScreen mainScreen].bounds.size.width;
        transform = CGAffineTransformMakeRotation(-M_PI / 2);
    }
    else if (newTo == UIInterfaceOrientationLandscapeRight)
    {
        rect.size.width = [UIScreen mainScreen].bounds.size.height;
        rect.size.height = [UIScreen mainScreen].bounds.size.width;
        transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    else if (newTo == UIInterfaceOrientationPortraitUpsideDown)
    {
        transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    self.view.bounds = rect;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.view.transform = transform;
    }];
}

@end
