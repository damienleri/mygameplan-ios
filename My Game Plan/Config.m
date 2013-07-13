//
//  Config.m
//  My Game Plan
//
//  Created by Damien Leri on 7/10/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "Config.h"

@implementation Config
@synthesize data;


+ (id)sharedInstance {
    static Config *sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConfig = [[self alloc] init];
    });
    return sharedConfig;
}

- (id)init {
    if (self = [super init]) {
      [self loadConfig];
      //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

-(id) objectForKey: (NSString *)key {
  return [data objectForKey: key];
    
}

-(void)loadConfig {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *e = nil;
    data = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!data) {
        NSLog(@"Error parsing JSON: %@", e);
        
    }
}

-(void) callHotline {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", [self objectForKey:@"hotline_phone"]];
				      
    NSURL *URL = [NSURL URLWithString:phoneNumber];
    [[UIApplication sharedApplication] openURL:URL];

}

@end
