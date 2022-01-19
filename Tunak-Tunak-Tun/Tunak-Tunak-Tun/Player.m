//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 18.01.22.
//

#import "Player.h"
#import "Move.h"
#import "TicTacToeComponents/TicTacToeCellState.h"
#import "TunakTunakTunCellState.h"
#import "GameConfigurationManager.h"

@implementation Player

-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withIntegerOfSign:(NSInteger)integerOfSign withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.integerOfSign = integerOfSign;
        self.board = board;
    }
    return self;
}

-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath {
    Move* move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:self.integerOfSign];
    return move;
}

-(void)yourTurnBaby
{
    // wait for input;
}
@end
