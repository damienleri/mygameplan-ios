//
//  StrategyEntity.h
//  My Game Plan
//
//  Created by Damien Leri on 7/5/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"

@interface StrategyEntity : RHManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;

@end
