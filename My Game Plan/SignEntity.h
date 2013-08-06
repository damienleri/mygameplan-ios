//
//  SignEntity.h
//  My Game Plan
//
//  Created by Damien Leri on 7/5/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"
@class SignEventEntity;

@interface SignEntity : RHManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * trigger;
@property (nonatomic, retain) NSSet *events;
@end

@interface SignEntity (CoreDataGeneratedAccessors)

- (void)addEventsObject:(SignEventEntity *)value;
- (void)removeEventsObject:(SignEventEntity *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
