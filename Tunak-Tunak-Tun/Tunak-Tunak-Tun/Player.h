//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 18.01.22.
//

#import <Foundation/Foundation.h>

@class Board;
@class Move;

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) NSInteger integerOfSign;
@property (nonatomic, strong) Board* board;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerId withIntegerOfSign:(NSInteger)integerOfSign withBoard:(Board*)board;
-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath;
-(void)yourTurnBaby;
@end

NS_ASSUME_NONNULL_END
