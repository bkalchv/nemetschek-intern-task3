//
//  TicTacToeCell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 17.01.22.
//

#import "Cell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TicTacToeCellState);

@interface TicTacToeCell : Cell
@property (nonatomic) TicTacToeCellState state;
- (instancetype)initWithState:(TicTacToeCellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col;
- (NSString*)description;
- (BOOL)isChecked;
@end

NS_ASSUME_NONNULL_END
