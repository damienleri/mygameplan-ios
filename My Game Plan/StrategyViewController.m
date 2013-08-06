#import "StrategyViewController.h"
#import "Config.h"
@interface StrategyViewController ()

@end

@implementation StrategyViewController
@synthesize strategy, nameLabel, noteLabel,appCell, _tableView;

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
    [nameLabel sizeToFit];
    noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, 200, 40);

    [noteLabel sizeToFit];
    CGSize size = [strategy.note sizeWithFont:noteLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
    noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, size.width, size.height);

    
//    NSLog(@"app id is %@ and title is %@", strategy.app_id, strategy.app_title);
    
    if (strategy.app_title) {
        appCell.textLabel.text = strategy.app_title;
        appCell.detailTextLabel.text = strategy.app_subtitle;
        [appCell.textLabel sizeToFit];
        [appCell.detailTextLabel sizeToFit];
    } else {
        /// In case the app was removed, this will trigger the numberOfSections update (below)
        [_tableView reloadData];
    }
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"app title %@", strategy.app_title);
    if (strategy.app_title && ![strategy.app_title isEqualToString:@""]) {
        return 2;
    }
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
      if (strategy.app_url) {

        NSURL *URL = [NSURL URLWithString: strategy.app_url];
        [[UIApplication sharedApplication] openURL:URL];

      } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8", strategy.app_id]]];
      }
 


    }
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
