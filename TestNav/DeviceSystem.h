//
//  DeviceSystem.h
//  TestNav
//
//  Created by D on 13-8-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#ifndef TestNav_DeviceSystem_h
#define TestNav_DeviceSystem_h

NSUInteger DeviceSystemMajorVersion();

NSUInteger DeviceSystemMajorVersion() {
    
    static NSUInteger _deviceSystemMajorVersion = -1;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
        
    });
    
    return _deviceSystemMajorVersion;
    
}

#define is_DeviceSysem_iOS7 (DeviceSystemMajorVersion() < 7)

#endif
