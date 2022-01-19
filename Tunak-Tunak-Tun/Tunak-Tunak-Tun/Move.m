//
//  Move.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 19.01.22.
//

#import "Move.h"
#import "Board.h"
#import "Cell.h"
#import "GameConfigurationManager.h"

@interface Move ()
@property (nonatomic, strong) Board *board;
@end

@implementation Move
-(instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board withIntegerOfSign:(NSInteger)integerOfSign {
    if (self = [super init]) {
        self.indexPath = indexPath;
        self.board = board;
        self.integerOfSign = integerOfSign;
    }
    
    return self;
}

-(BOOL)isValidMove {
    switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe:
            return ![self.board cellAt: self.indexPath].isChecked;
            break;
        case GameTunakTunakTun:
            //TODO: is there an invalid TunakTunakTun move?
            return true; // ?
            break;
        default:
            break;
    }
}

-(Move*)opposite {
    switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe:
            return [[Move alloc]initWithIndexPath:self.indexPath withBoard:self.board withIntegerOfSign: 0]; // TODO: hacky!
            break;
        case GameTunakTunakTun:
            return [[Move alloc]initWithIndexPath:self.indexPath withBoard:self.board withIntegerOfSign: 0];
            break;
        default:
            break;
    }
}

-(TicTacToeCellState)ticTacToeMoveSign {
    return (TicTacToeCellState)self.integerOfSign;
}

-(TunakTunakTunCellState)tunakTunakTunMoveSign {
    return (TunakTunakTunCellState)self.integerOfSign;
}
@end
