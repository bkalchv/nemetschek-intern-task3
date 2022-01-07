//
//  Bot.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import "Bot.h"
#import "Board.h"
#import "Cell.h"
#import "Move.h"
#import <UIKit/UIKit.h>

@implementation Bot

-(instancetype)initWithSign:(CellState)sign withBoard:(Board*)board {
    self = [super initPlayerWithName:@"CPU" withId:2 withSign:sign withBoard:board];
    return self;
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

-(NSArray<Cell*> *)freeCellsOfBoard {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in self.board.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)randomFreeCell {
    NSArray<Cell*>* freeCells = [self freeCellsOfBoard];
    return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
}

-(void)yourTurnBaby {
    Cell* cellToSelect = [self randomFreeCell];
    NSIndexPath* indexPathOfSelectedCell = [NSIndexPath indexPathForRow: cellToSelect.rowIndex * self.board.numberOfColumns + cellToSelect.colIndex inSection:0];
    NSIndexPath* intendedCellIndexPath = [NSIndexPath indexPathForRow:[cellToSelect colIndex] inSection:[cellToSelect rowIndex]];
    [self setIntendedCellIndexPath: indexPathOfSelectedCell];
    [self.delegate handleSelection: intendedCellIndexPath];
}

@end
	
		
