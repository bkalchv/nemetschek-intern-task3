//
//  GameChoicePageViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 25.01.22.
//

#import "GameChoicePageViewController.h"
#import "CardViewController.h"
#import "GameConfigurationManager.h"

@interface GameChoicePageViewController ()
@property (strong, nonatomic) NSArray<NSString *>* gameTitles;
@property (strong, nonatomic) NSArray<NSString *>* gameImages;
@end

@implementation GameChoicePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.gameTitles = @[@"Tic-Tac-Toe", @"Tunak-Tunak-Tun"];
    self.gameImages = @[@"TicTacToe", @"tunak_green"];
    
    self.dataSource = self;
    
    CardViewController* startingVC = [self viewControllerAtIndex:0];
    NSArray* viewControllers = @[startingVC];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    
    NSUInteger index = ((CardViewController*) viewController).pageIndex;
        
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    [GameConfigurationManager.sharedGameConfigurationManager changeToGame:index];
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
    
    [GameConfigurationManager.sharedGameConfigurationManager changeToGame:index];
    
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


@end
