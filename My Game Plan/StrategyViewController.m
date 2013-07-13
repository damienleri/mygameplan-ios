#import "StrategyViewController.h"
#import "Config.h"
@interface StrategyViewController ()

@end

@implementation StrategyViewController
@synthesize strategy, nameLabel, dateLabel,noteLabel,appCell;

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
    
    nameLabel.text = strategy.name;
    noteLabel.text = strategy.note;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:strategy.date];
    dateLabel.text = dateString;

    appCell.textLabel.text = strategy.app_title;
    appCell.detailTextLabel.text = strategy.app_subtitle;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editStrategy"]) {
        EditStrategyViewController *nextView = segue.destinationViewController;
        nextView.isEditing = YES;
        nextView.strategy = strategy;
    }
}


@end
