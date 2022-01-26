//
//  CardViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 25.01.22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardViewController : ViewController <UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;

@property NSUInteger pageIndex;
@property (weak,nonatomic) NSString* titleText;
@property (weak, nonatomic) NSString* imageFileName;

@end

NS_ASSUME_NONNULL_END
