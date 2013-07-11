//
//  AppDelegate.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUIAppearance.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void) customizeBarButtons;
-(UIColor*) colorWithHexString: (NSString *)hex;
@end
