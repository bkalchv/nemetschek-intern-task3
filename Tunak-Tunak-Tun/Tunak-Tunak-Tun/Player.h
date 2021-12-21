//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CellState);
@class Board;

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) CellState sign;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerId withSign:(CellState)sign;
-(void)makeMoveOnBoard:(Board*)board atRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex;
-(void)makeMoveOnBoard:(Board*)board atIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
