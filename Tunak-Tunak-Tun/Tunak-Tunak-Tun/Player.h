//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CellState);
@class Board;
@class Move;
NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;

@property (nonatomic, strong) NSString* name;
@property (nonatomic) CellState sign;
@property (nonatomic, strong) Board* board;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerId withSign:(CellState)sign withBoard:(Board*)board;
-(Move*)makeMoveWithIndexPath:(NSIndexPath*)indexPath;
-(void)yourTurnBaby;

@end

NS_ASSUME_NONNULL_END
