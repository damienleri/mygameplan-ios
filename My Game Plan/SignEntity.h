
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"


@interface SignEntity : RHManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * note;
@end