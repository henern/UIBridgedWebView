UIBridgedWebView
================

sending messages between Obj-C and JavaScript in UIWebView


Samples
-------
please check src/Samples/ControlPanel.


API Reference
-------------
### ObjC side
##### How to export an ObjC object to Javascript?

1. import the header file 

        #import <UIBridgedWebView/Bridge4iOS.h>

2. create a subclass from Bridge4iOS:

        @interface JSBridgeSample : Bridge4iOS
    
3. declare the methods u want to export.

        /*
         *  Declare the methods u want to export. 
         *
         *  @signature: - (id)foo:(NSDictionary*)params
         *  @param:     MUST be NSDictionary*
         *  @return:    all basic type (NSString, NSNumber, nil, NSArray, ...) is OK
         */
        - (id)_batteryState:(NSDictionary*)params;

4. move the implementation

        @implementation JSBridgeSample

5. assign a name for this object, iOSSample for this case, which will be used in the Javascript code.

        - (id)init
        {
            // @js: window.iOSSample
            self = [super initWithName:@"iOSSample"];
            if (self)
            {
                
            }
            
            return self;
        }

6. finish the method table which need to be exported

        // declare the exported methods
        BEGIN_EXPORTED_METHODS(16)
        ADD_EXPORTED_METHOD(@"batteryState",     @selector(_batteryState:))
        END_EXPORTED_METHODS()

7. implement the methods

        // on javascript side, the code looks like this: 
        // @js: window.iOSSample.exec('{"action":"batteryState","return_type":"string"}');
        - (id)_batteryState:(NSDictionary *)params
        {
            ...
            
            // return a string to JS.
            return result;
        }

8. set up the UIBridgedWebView instance

        UIBridgedWebView *wv = ...;
        JSBridgeSample *brdg = [[JSBridgeSample alloc] init];
        BOOL ret = [brdg injectTo:wv];


### Javascript side
##### How to send message to ObjC, and get the return value synchronously?

        var batteryState = window.iOSSample.exec('{"action":"batteryState","return_type":"string"}');
        var box = document.getElementById("lblBatteryStatus");
        box.innerHTML = "BATTERY STATUS: "+batteryState;


Dependency
----------
[SBJSON](https://github.com/stig/json-framework/)


