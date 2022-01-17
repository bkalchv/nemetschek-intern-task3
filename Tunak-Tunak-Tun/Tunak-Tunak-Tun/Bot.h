//
//  Bot.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import <Foundation/Foundation.h>
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@class Move;

@protocol BotDelegate <NSObject>
- (void)handleSelection:(NSIndexPath*)indexPath;
@end

@interface Bot : Player
-(instancetype)initWithSign:(TicTacToeCellState)sign withBoard:(Board*)board;
@property (nonatomic, strong)id <BotDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
