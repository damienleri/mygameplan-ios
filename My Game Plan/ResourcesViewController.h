//
//  ResourcesViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 7/6/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourcesViewController : UITableViewController
@property(nonatomic,strong) NSMutableArray *sectionLabels;
@property(nonatomic,strong) NSMutableDictionary *resources;
-(void) resourceInSection:(NSString *)section title:(NSString*)title subtitle:(NSString*)subtitle url:(NSString*)url;

@end
