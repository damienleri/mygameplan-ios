#import "AppointmentViewController.h"
#import "Config.h"
@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize appointment, nameLabel, dateLabel, noteLabel, tableView, reminderLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *intervals = [[Config sharedInstance] objectForKey:@"appointment_reminder_intervals"];

    nameLabel.text = appointment.name;
    noteLabel.text = appointment.note;
//    NSLog(@"note %@", appointment.note);
    [nameLabel sizeToFit];
    [noteLabel sizeToFit];

    CGSize size = [appointment.note sizeWithFont:noteLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
    noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, size.width, size.height);


    if (NO) { /// Couldn't get this working in time
      reminderLabel.text = @"";
      for (NSDictionary *interval in intervals) {
        SEL s = NSSelectorFromString([interval objectForKey:@"field"]);
        NSString *val = [appointment performSelector: s];

	//        NSLog(@"val for %@ is %@", label, val);
        if (val) {
	  if (! [reminderLabel.text isEqualToString:@""]) {
	    reminderLabel.text = [reminderLabel.text stringByAppendingString:@", "];
	  }
	  reminderLabel.text = [interval objectForKey:@"label"];
            
        } else {
        
        }

      }
      if ([reminderLabel.text isEqualToString:@""]) {
        reminderLabel.text = @"Off";
      }
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, yyyy 'at' HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:appointment.date];
    dateLabel.text = dateString;
    [dateLabel sizeToFit];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editAppointment"]) {
        EditAppointmentViewController *nextView = segue.destinationViewController;
        nextView.isEditing = YES;
        nextView.appointment = appointment;
    }
    if ([[segue identifier] isEqualToString:@"reminders"]) {
        AppointmentReminderViewController *nextView = segue.destinationViewController;
        nextView.appointment = appointment;
        nextView.parentVC = self;
    }
}


@end
