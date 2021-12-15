//
//  Cell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Cell.h"

@implementation Cell
- (instancetype)initWithState:(CellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col {
    self = [super init];
    if (self) {
        if (state == CellStateEmpty) {
            self.isChecked = NO;
            self.state = CellStateEmpty;
        } else {
            self.isChecked = YES;
            self.state = state;
        }
        self.rowIndex = row;
        self.colIndex = col;
    }
    return self;
}

- (NSString*)description {
    NSString* result;
    
    switch (self.state){
        case CellStateX:
            result = @"X";
            break;
        case CellStateO:
            result = @"O";
            break;
        case CellStateEmpty:
            result = @"-";
            break;
    }
    
    return result;
}
@end