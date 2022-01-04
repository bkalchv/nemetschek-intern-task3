//
//  Bot.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import <Foundation/Foundation.h>
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bot : Player
-(instancetype)initWithSign:(CellState)sign;
@end

NS_ASSUME_NONNULL_END
