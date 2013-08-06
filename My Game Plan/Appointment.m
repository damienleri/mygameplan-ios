
#import "Appointment.h"
#import "Config.h"
@implementation Appointment

+(NSString *)entityName {
	return @"AppointmentEntity";
}

+(NSString *)modelName {
	return @"Model";
}

-(void) deleteRemindersFromServer
{
    NSArray *intervals = [[Config sharedInstance] objectForKey:@"appointment_reminder_intervals"];
    NSLog(@"Deleting appointments");
    for (NSDictionary *interval in intervals) {
        NSString *field = [interval objectForKey:@"field"];
        SEL s = NSSelectorFromString(field);
        NSString *val = [self performSelector: s];
        
        if (val) {
	  //            NSLog(@"deleting field %@", field);
            [self deleteReminderForField:field withValue:val serverOnly:YES];
        }
    }

}

-(void) deleteReminderForField:(NSString *) field withValue: (NSString *)val serverOnly:(BOOL) serverOnly
{
[PFCloud callFunctionInBackground:@"delete_apn"
                   withParameters:@{ @"url": val}
                            block:^(id result, NSError *error) {
                                if (result) {
                                    if (!serverOnly) {
				      
				      NSString *camelField = [field stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[field substringToIndex:1] uppercaseString]];
				      SEL update_s = NSSelectorFromString([NSString stringWithFormat:@"set%@:",camelField]);
				      [self performSelector:update_s withObject:nil];
				      [Appointment commit];
                                    }
                                    
                                } else {
                                    NSLog(@"Error: %@", [error localizedDescription]);
                                }
                            }];
}

-(void) updateReminders 
// Since the time may have changed, need to reschedule reminders.
{
    NSArray *intervals = [[Config sharedInstance] objectForKey:@"appointment_reminder_intervals"];

    for (NSMutableDictionary *interval in intervals) {
        NSString *field = [interval objectForKey:@"field"];
        SEL s = NSSelectorFromString(field);
        NSString *val = [self performSelector: s];

        if (val) { // This reminder is scheduled, so reschedule by deleting the reminder and recreating it
            NSLog(@"updating reminder %s", field);
            [self deleteReminderForField:field withValue:val serverOnly:YES];
            [self scheduleReminderForInterval:interval];
        }
        
    }
}

-(NSDate *)dateMinusHours: (NSNumber *)hours
{
    NSInteger seconds =  [hours intValue] * 60 * 60;
    return [self.date dateByAddingTimeInterval: - seconds];
    
}
-(NSString *)utcMinusHours:(NSNumber *)hours
{
    NSDate *localDate = [self dateMinusHours:hours];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

-(void) scheduleReminderForInterval:(NSDictionary*) interval
{

    NSString *field = [interval objectForKey:@"field"];
    NSNumber *hours = [interval objectForKey:@"hours"];
    NSString *token = [[Config sharedInstance] pushDeviceToken];

    NSString *message_text = [NSString stringWithFormat:@"This is a reminder for appointment \"%@\" in %@", self.name, [interval objectForKey:@"label"]];
//                  if ([field isEqualToString:@"reminder_1d"]) {
//                      hours = [NSNumber numberWithFloat: (1/40)];
//                  }
#ifdef DEBUG
        if (!token) {
            NSLog(@"supplying default token");
        	token = @"5BBFB06AF8A75A07029EAE5F3E2E467AB50ECD922019EF95970FCDBF7236A0A1";  // for testing in xCode
        }
#endif
//            //	      return;
//        }
        //        NSLog(message_text);

    
    if ([[self dateMinusHours:hours] compare: [NSDate date]] == NSOrderedAscending) {
        NSLog(@"Reminder would be in the past, so skipping.");
        return;
    }
    
      NSString *message_time = [self utcMinusHours:hours];
    
      NSLog(@"Scheduling for %@ hours <%@>", hours, message_time);

         
      [PFCloud callFunctionInBackground:@"schedule_apn"
			 withParameters:@{ @"device": token,  @"time": message_time,  @"message": message_text}
      block:^(id result, NSError *error) {
	  if (result) {
	       
	    NSError *e = nil;
	    NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
	    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
	    NSArray *notifications = (NSArray *)[dict objectForKey:@"scheduled_notifications" ];
	    NSString *scheduleUrl = [notifications objectAtIndex:0];
	    NSString *camelField = [field stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[field substringToIndex:1] uppercaseString]];
	    SEL update_s = NSSelectorFromString([NSString stringWithFormat:@"set%@:", camelField]);
	    [self performSelector:update_s withObject:scheduleUrl];
	       
	    if (!dict) {
	      NSLog(@"Error parsing JSON: %@", e);
	    } else {
	      [Appointment commit];
	    }
               
	  } else {
	    //                                        NSLog([error localizedDescription]);
	  }
	}];
}


@end
