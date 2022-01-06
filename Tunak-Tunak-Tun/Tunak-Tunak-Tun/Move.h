//
//  Move.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 6.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Board;
@class Player;

@interface Move : NSObject
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) Board *board;
-(instancetype)initWithPlayer:(Player*)player withBoard:(Board*)board;
-(BOOL) isValidMove;
@end

NS_ASSUME_NONNULL_END
