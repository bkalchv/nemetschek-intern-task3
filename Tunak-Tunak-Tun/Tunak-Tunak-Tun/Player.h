//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TicTacToeCellState);
@class Board;
@class Move;
NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;

@property (nonatomic, strong) NSString* name;
@property (nonatomic) TicTacToeCellState sign;
@property (nonatomic, strong) Board* board;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerId withSign:(TicTacToeCellState)sign withBoard:(Board*)board;
-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath;
-(void)yourTurnBaby;

@end

NS_ASSUME_NONNULL_END
