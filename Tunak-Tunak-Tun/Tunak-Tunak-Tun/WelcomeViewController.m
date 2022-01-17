//
//  WelcomeViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 14.01.22.
//

#import "WelcomeViewController.h"
#import "GamePicturesView.h"

@interface WelcomeViewController ()
@property NSArray<NSString*>* games;
@property (weak, nonatomic) IBOutlet UIScrollView *gameChoiceScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *gameChoicePageControl;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@end

@implementation WelcomeViewController

- (void)initGameChoiceScrollView {
    CGSize contentSize = self.gameChoiceScrollView.frame.size;
    contentSize.width = self.gameChoiceScrollView.frame.size.width * [self.games count];
    
    [self.gameChoiceScrollView setContentSize:contentSize];
    [self.gameChoiceScrollView setDelegate:self];
    [self.gameChoiceScrollView setPagingEnabled:YES];
    [self.gameChoiceScrollView setBounces:NO];
    [self.gameChoiceScrollView setScrollsToTop:NO];
    [self.gameChoiceScrollView setScrollEnabled:YES];
    [self.gameChoiceScrollView setShowsHorizontalScrollIndicator:NO];
    [self.gameChoiceScrollView setShowsVerticalScrollIndicator:NO];
    
    [self.gameChoiceScrollView.layer setBorderWidth:1];
    [self.gameChoiceScrollView.layer setBorderColor: UIColor.grayColor.CGColor];
    
    CGRect scrollViewRect = [self.gameChoiceScrollView bounds];
    CGFloat scrollViewWidth = scrollViewRect.size.width;
    CGFloat scrollViewHeight = scrollViewRect.size.height;
    
    for (NSUInteger index = 0; index < [self.games count]; ++index) {
        GamePicturesView* view = [[[NSBundle mainBundle] loadNibNamed:@"GamePicturesView" owner:nil options:nil] objectAtIndex:0];
        NSString* gameAsString = [self.games objectAtIndex:index];
        view.imageView.image = [UIImage imageNamed:gameAsString];
        
        view.frame = CGRectMake(scrollViewWidth * index, 0, scrollViewWidth, scrollViewHeight);
        [self.gameChoiceScrollView addSubview:view];
    }
}

-(void)initGameChoicePageControl {
    [self.gameChoicePageControl setNumberOfPages:[self.games count]];
    [self.gameChoicePageControl setUserInteractionEnabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGames: [[NSArray<NSString*> alloc] initWithObjects: @"TickTackToe", @"TunakTunakTun", nil]];
    
    [self initGameChoicePageControl];
    [self initGameChoiceScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewWidth = self.gameChoiceScrollView.frame.size.width;
    self.gameChoicePageControl.currentPage = floor((self.gameChoiceScrollView.contentOffset.x - scrollViewWidth / [self.games count]) / scrollViewWidth) + 1;
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
