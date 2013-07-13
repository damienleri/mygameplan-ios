//
//  Config.h
//  My Game Plan
//
//  Created by Damien Leri on 7/10/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
@property(retain,nonatomic) NSMutableDictionary* data;
			    // -(void) loadConfig;
-(id) objectForKey: (NSString *)key;
+ (id) sharedInstance;
			    -(void) callHotline;
@end
