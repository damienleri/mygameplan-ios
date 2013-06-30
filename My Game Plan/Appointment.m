
#import "Appointment.h"

@implementation Appointment

+(NSString *)entityName {
	return @"AppointmentEntity";
}

+(NSString *)modelName {
	return @"Model";
}

-(NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.name];
}

@end
