//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "Board.h"

NS_ASSUME_NONNULL_BEGIN



@interface ConsoleViewController : UIViewController
@property (nonatomic, strong) Board* board;
@end

NS_ASSUME_NONNULL_END
