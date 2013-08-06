
#import "AppointmentEntity.h"
#import "Parse/Parse.h"
@interface Appointment : AppointmentEntity

// -(NSString *)fullName;
-(void) deleteReminderForField:(NSString *) field withValue: (NSString *)val serverOnly:(BOOL)serverOnly;
-(void) deleteRemindersFromServer;
											      -(void) updateReminders;
											      -(void) scheduleReminderForInterval:(NSDictionary*) interval;
@end
