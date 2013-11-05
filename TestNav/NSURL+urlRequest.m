//
//  NSURL+urlRequest.m
//  TestNav
//
//  Created by D on 13-8-13.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "NSURL+urlRequest.h"

@implementation NSURL (urlRequest)

+ (NSURL*)url:(NSString*)subpathformat, ...
{
    va_list args;
    va_start (args, subpathformat);
    NSString *subpath = [[NSString alloc] initWithFormat:subpathformat
                                               arguments:args];
    NSLog(@"sub:%@",subpath);
    va_end (args);
    
//    NSString *urlstring =
//            [NSString stringWithFormat:@"%@://%@/%@", secureConnection?@"https":@"http", APIDomain, subpath];
//    NSString *urlstring =
//            [NSString stringWithFormat:@"http://%@/%@",APIDomain, subpath];
//    
//    if ([subpath rangeOfString:@"?"].location==NSNotFound) {
//        urlstring=[NSString stringWithFormat:@"%@?source=%@",urlstring,consumerKey];
//    }else{
//        urlstring=[NSString stringWithFormat:@"%@&amp;source=%@",urlstring,consumerKey];
//    }
//    
//    urlstring=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:subpath];
}

@end