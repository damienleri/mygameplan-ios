
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"


@interface AppointmentEntity : RHManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;

@end
