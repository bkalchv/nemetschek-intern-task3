//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"
#import "Move.h"
#import <UIKit/UIKit.h>

@interface Player ()
@end

@implementation Player

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

// keeping it for now because of ConsoleVC
// gotta go!
-(void)makeMove {
    NSUInteger lastSelectedCellRowIndex = [self.intendedCellIndexPath section];
    NSUInteger lastSelectedCellColIndex = [self.intendedCellIndexPath row];
    [self.board changeCellStateAtRowIndex:lastSelectedCellRowIndex  columnIndex:lastSelectedCellColIndex withSign:self.sign];
}

-(Move*)makeIntendedMove {
    Move* intendedMove = [[Move alloc] initWithPlayer:self withBoard:self.board];
    return intendedMove;
}

-(void)setIntendedCellIndexPath:(NSIndexPath *)intendedCellIndexPath {
    _intendedCellIndexPath = intendedCellIndexPath;
}

-(void)yourTurnBaby
{
    // wait for input;
}

@end
