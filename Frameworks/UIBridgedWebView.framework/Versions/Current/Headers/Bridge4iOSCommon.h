//
//  Bridge4iOSCommon.h
//  UIBridgedWebView
//
//  Created by Wayne W on 9/26/12.
//
//

#ifndef Bridge4iOS_Bridge4iOSCommon_h
#define Bridge4iOS_Bridge4iOSCommon_h

/*
 *  MACROS to export some methods to JS
 */
#define BEGIN_EXPORTED_METHODS(count)                                                               \
    + (NSDictionary*)__bridge_exportedMethods                                                       \
    {                                                                                               \
        static NSMutableDictionary *_exportedMethods = nil;                                         \
        if (nil == _exportedMethods)                                                                \
        {                                                                                           \
            _exportedMethods = [[NSMutableDictionary alloc] initWithCapacity:(count)];

#define ADD_EXPORTED_METHOD(jsMethodName, aSelector)                                                \
        [_exportedMethods setObject:NSStringFromSelector(aSelector) forKey:(jsMethodName)];

#define END_EXPORTED_METHODS()                                                                      \
        }                                                                                           \
        return _exportedMethods;                                                                    \
    }                                                                                               \
    - (NSDictionary*)__bridge_exportedMethods                                                       \
    {                                                                                               \
        return [[self class] __bridge_exportedMethods];                                             \
    }

#define EXPORTED_METHOD_SELECTOR    @selector(__bridge_exportedMethods)

#endif
