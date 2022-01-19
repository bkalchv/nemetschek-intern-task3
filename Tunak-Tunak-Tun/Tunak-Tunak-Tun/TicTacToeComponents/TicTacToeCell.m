//
//  TicTacToeCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 17.01.22.
//

#import "TicTacToeCell.h"
#import "TicTacToeCellState.h"

@implementation TicTacToeCell

- (instancetype)initWithState:(TicTacToeCellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col {
    self = [super initAtRow:row atColumn:col];
    if (self) {
        self.state = state;
    }
    return self;
}

- (NSString*)description {
    NSString* result;
    
    switch (self.state){
        case TicTacToeCellStateX:
            result = @"X";
            break;
        case TicTacToeCellStateO:
            result = @"O";
            break;
        case TicTacToeCellStateEmpty:
            result = @"-";
            break;
    }
    
    return result;
}

- (BOOL)isChecked {
    return self.state != TicTacToeCellStateEmpty;
}

- (void)setState:(NSInteger)integerOfState {
    TicTacToeCellState state = (TicTacToeCellState) integerOfState;
    _state = state;
}

- (NSInteger)stateInteger {
    return self.state;
}

@end
