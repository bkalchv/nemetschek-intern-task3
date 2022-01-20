//
//  Bot.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import "Bot.h"
#import "Board.h"
#import "TicTacToeCell.h"
#import "TicTacToeCellState.h"
#import "Move.h"
#import <UIKit/UIKit.h>

@implementation Bot

-(instancetype)initWithIntegerOfSign:(NSInteger)integerOfSign withBoard:(Board*)board {
    self = [super initPlayerWithName:@"CPU" withId:2 withIntegerOfSign:integerOfSign withBoard:board];
    return self;
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

-(NSArray<TicTacToeCell*> *)freeCellsOfBoard {
    NSMutableArray<TicTacToeCell*>* freeCellsArray = [[NSMutableArray<TicTacToeCell*> alloc] init];
    for (TicTacToeCell* cell in self.board.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)randomFreeCell {
    NSArray<Cell*>* freeCells = [self freeCellsOfBoard];
    if ([freeCells count]  != 0) return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
    return nil;
}

-(void)yourTurnBaby {
    Cell* cellToSelect = [self randomFreeCell];
    if (cellToSelect != nil) {
        NSIndexPath* cellToSelectIndexPath = [NSIndexPath indexPathForRow:[cellToSelect colIndex] inSection:[cellToSelect rowIndex]];
        [self.delegate handleSelection: cellToSelectIndexPath];
    }
}

@end
	
		
