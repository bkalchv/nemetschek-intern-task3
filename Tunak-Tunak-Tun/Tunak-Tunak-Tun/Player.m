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
#import "Board.h"
#import "Cell.h"
#import "GameConfigurationManager.h"

@interface Player()
@property (nonatomic, strong) NSDictionary* tunakStateDictionary;
@end

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
    Move* move;
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe:
            move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:self.integerOfSign];
            break;
        case GameTunakTunakTun: {
            Cell* cellOfMove = [self.board cellAt:indexPath];
            
            switch ([cellOfMove stateInteger]) {
                case TunakCellStateEmpty:
                    move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:TunakCellStateGreen];
                    break;
                    
                case TunakCellStateGreen:
                    move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:TunakCellStateYellow];
                    break;
                    
                case TunakCellStateYellow:
                    move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:TunakCellStateRed];
                    break;
            }
            
            break;
        }
        default:
            break;
    }
    
    return move;
}

-(void)yourTurnBaby
{
    // wait for input;
}
@end
