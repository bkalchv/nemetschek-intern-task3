//
//  WelcomeViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 14.01.22.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property NSArray<NSString*>* games;
@property CGRect scrollViewFrame;
@property (weak, nonatomic) IBOutlet UIScrollView *gameChoiceScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *gameChoicePageControll;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@end

@implementation WelcomeViewController

- (void) setupScreens {
    for (NSUInteger index = 0; index < [self.games count]; ++index) {

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGames: [[NSArray<NSString*> alloc] initWithObjects: @"TickTackToe", @"TunakTunakTun", nil]];
    [self setScrollViewFrame: CGRectMake(0, 0, 0, 0)];
    self.gameChoicePageControll.numberOfPages = [self.games count];
    
    [self setupScreens];
    
    self.gameChoiceScrollView.contentSize = CGSizeMake(200, 100);
    self.gameChoiceScrollView.delegate = self;
    [self.gameChoiceScrollView.layer setBorderWidth:5];
    [self.gameChoiceScrollView.layer setBorderColor: UIColor.blueColor.CGColor];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger currentPage = (NSUInteger) round(scrollView.contentOffset.x / 100);
    self.gameChoicePageControll.currentPage = currentPage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
