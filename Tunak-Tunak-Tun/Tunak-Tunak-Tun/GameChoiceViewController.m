//
//  GameChoiceViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 25.01.22.
//

#import "GameChoiceViewController.h"
#import "CardViewController.h"

@interface GameChoiceViewController ()
@property (strong, nonatomic) UIPageViewController* pageViewController;
@property (strong, nonatomic) NSArray* gameTitles;
@property (strong, nonatomic) NSArray* gameImages;
@property (strong, nonatomic) UIPageControl* pageControl;
@end

@implementation GameChoiceViewController

-(void)initPageControl {
    self.pageControl = [UIPageControl appearance];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor tintColor];
    self.pageControl.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageControl];
    
    // Do any additional setup after loading the view.
    self.gameTitles = @[@"Tic-Tac-Toe", @"Tunak-Tunak-Tun"];
    self.gameImages = @[@"TicTacToe", @"TunakTunakTun"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameChoicePageViewController"];
    self.pageViewController.dataSource = self;
    
    CardViewController* startingVC = [self viewControllerAtIndex:0];
    NSArray* viewControllers = @[startingVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// TODO: will definitely need these
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    
    NSUInteger index = ((CardViewController*) viewController).pageIndex;
        
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    NSUInteger index = ((CardViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.gameTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(CardViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.gameTitles count] == 0) || (index >= [self.gameTitles count])) {
        return nil;
    }
   
    CardViewController* cardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CardViewController"];
    cardVC.pageIndex = index;
    cardVC.imageFileName = self.gameImages[index];
    cardVC.titleText = self.gameTitles[index];
    
   
    return cardVC;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.gameTitles count];
}
 
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
