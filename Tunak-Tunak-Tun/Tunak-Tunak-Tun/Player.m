//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"
#import <UIKit/UIKit.h>

@interface Player ()
@end

@implementation Player
// init with board
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withSign:(CellState)sign withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.sign = sign;
        self.board = board;
    }
    return self;
}

//remove board param
-(void)makeMove {
    NSUInteger lastSelectedCellRowIndex = [self.lastSelectedCell section];
    NSUInteger lastSelectedCellColIndex = [self.lastSelectedCell row];
    [self.board changeCellStateAtRowIndex:lastSelectedCellRowIndex  columnIndex:lastSelectedCellColIndex withSign:self.sign];
}

-(void)setLastSelectedCell:(NSIndexPath *)lastSelectedCell {
    _lastSelectedCell = lastSelectedCell;
}

-(void)yourTurnBaby
{
    //[self makeMove];
}

@end
