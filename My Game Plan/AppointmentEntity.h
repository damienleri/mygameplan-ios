//
//  AppointmentEntity.h
//  My Game Plan
//
//  Created by Damien Leri on 7/5/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"

@interface AppointmentEntity : RHManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
			      @property (nonatomic, retain) NSString * reminder_1h;
			      @property (nonatomic, retain) NSString * reminder_1d;
			      @property (nonatomic, retain) NSString * reminder_2d;
			      @property (nonatomic, retain) NSString * reminder_3d;
			      @property (nonatomic, retain) NSString * reminder_4d;
			      @property (nonatomic, retain) NSString * reminder_5d;
			      @property (nonatomic, retain) NSString * reminder_6d;
			      @property (nonatomic, retain) NSString * reminder_1w;
			      @property (nonatomic, retain) NSString * reminder_2w;


@end
