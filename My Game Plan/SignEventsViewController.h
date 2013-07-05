//
//  SignEventsViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 7/5/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sign.h"

@interface SignEventsViewController : UITableViewController
@property(nonatomic,strong) Sign *sign;
@property(nonatomic,strong) NSArray *events;
@end
