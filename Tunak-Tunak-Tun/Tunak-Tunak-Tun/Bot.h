//
//  Bot.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class Cell;

NS_ASSUME_NONNULL_BEGIN

@interface Bot : Player
-(instancetype)initWithSign:(CellState)sign;
-(Cell*)makeMoveOnBoard:(Board*)board;
@end

NS_ASSUME_NONNULL_END
