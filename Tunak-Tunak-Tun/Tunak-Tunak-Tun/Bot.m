//
//  Bot.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import "Bot.h"
#import "Board.h"
#import "Cell.h"
#import "TicTacToeCellState.h"
#import "TunakTunakTunCellState.h"
#import "Move.h"
#import "GameConfigurationManager.h"
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

// TODO: gone
-(NSInteger)randomValidIntegerOfTunakCellState {
    NSInteger randomIntegerOfTunakCellState = [self randomIndex:TunakCellStateCount];
    while (randomIntegerOfTunakCellState == TunakCellStateEmpty) {
        randomIntegerOfTunakCellState = [self randomIndex:TunakCellStateCount];
    }
    return randomIntegerOfTunakCellState;
}

-(NSArray<Cell*> *)freeCellsOfBoard {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in self.board.boardMatrixArray) {
        
        switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
            case GameTicTacToe: {
                if (!cell.isChecked) [freeCellsArray addObject:cell];
                break;
            }
                
            case GameTunakTunakTun: {
                if (cell.stateInteger != TunakCellStateRed) [freeCellsArray addObject:cell];
                break;
            }

            default:
                break;
        }
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
    
    if ([GameConfigurationManager.sharedGameConfigurationManager game] == GameTunakTunakTun) [self setIntegerOfSign:cellToSelect.stateInteger];
    
    if (cellToSelect != nil) {
        NSIndexPath* cellToSelectIndexPath = [NSIndexPath indexPathForRow:[cellToSelect colIndex] inSection:[cellToSelect rowIndex]];
        [self.delegate handleSelection: cellToSelectIndexPath];
    }
}

@end
	
		
