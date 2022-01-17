//
//  Move.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 6.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Board;
typedef NS_ENUM(NSInteger, TicTacToeCellState);

@interface Move : NSObject
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic)         TicTacToeCellState    sign;
-(instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board withSign:(TicTacToeCellState)sign;
-(BOOL)isValidMove;
-(Move*)opposite;
@end

NS_ASSUME_NONNULL_END
