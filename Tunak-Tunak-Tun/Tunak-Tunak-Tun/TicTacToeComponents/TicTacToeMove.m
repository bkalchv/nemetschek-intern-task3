////
////  Move.m
////  Tunak-Tunak-Tun
////
////  Created by Bogdan Kalchev on 6.01.22.
////
//
//#import "TicTacToeMove.h"
//#import "Board.h"
//#import "TicTacToeCell.h"
//#import "TicTacToeCellState.h"
//#import "TicTacToePlayer.h"
//
//@interface TicTacToeMove ()
//@property (nonatomic, strong) Board *board;
//@end
//
//@implementation TicTacToeMove
//- (instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board withSign:(TicTacToeCellState)sign {
//    self = [super init];
//    if (self) {
//        self.indexPath = indexPath;
//        self.board = board;
//        self.sign = sign;
//    }
//    return self;
//}
//
//-(BOOL)isValidMove {
//    return ![self.board cellAt: self.indexPath].isChecked;
//}
//
//-(TicTacToeMove*)opposite {
//    TicTacToeMove* oppositeMove = [[TicTacToeMove alloc]initWithIndexPath:self.indexPath withBoard:self.board withSign:TicTacToeCellStateEmpty];
//    return oppositeMove;
//}
//
//@end
