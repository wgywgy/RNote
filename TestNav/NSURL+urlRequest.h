//
//  NSURL+urlRequest.h
//  TestNav
//
//  Created by D on 13-8-13.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (urlRequest)

+ (NSURL *)url:(NSString *)subpathformat, ...;
@end
