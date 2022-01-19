//
//  Move.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 19.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Board;
@interface Move : NSObject

typedef NS_ENUM(NSInteger, TicTacToeCellState);
typedef NS_ENUM(NSInteger, TunakTunakTunCellState);

@property (nonatomic, strong) NSIndexPath*  indexPath;
@property (nonatomic) NSInteger             integerOfSign;

-(instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board withIntegerOfSign:(NSInteger)integerOfSign;
-(BOOL)isValidMove;
-(Move*)opposite;
-(TicTacToeCellState)ticTacToeMoveSign;
-(TunakTunakTunCellState)tunakTunakTunMoveSign;
@end

NS_ASSUME_NONNULL_END
