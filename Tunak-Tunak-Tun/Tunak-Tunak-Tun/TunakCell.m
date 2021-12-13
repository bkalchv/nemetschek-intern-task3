//
//  TunakCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "TunakCell.h"

@implementation TunakCell
- (instancetype) initWithState:(TunakCellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col {
    self = [super init];
    if (self) {
        if (state == TunakCellStateUnchecked) {
            self.isChecked = NO;
            self.state = TunakCellStateUnchecked;
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
        case TunakCellStateGreen:
            result = @"g";
            break;
        case TunakCellStateRed:
            result = @"r";
            break;
        case TunakCellStateYellow:
            result = @"y";
            break;
        case TunakCellStateUnchecked:
            result = @"-";
            break;
    }
    
    return result;
}
@end
