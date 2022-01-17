//
//  Cell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Cell.h"

@interface Cell()
@end

@implementation Cell
- (instancetype)initAtRow:(NSUInteger)row atColumn:(NSUInteger)col {
    self = [super init];
    if (self) {
        self.rowIndex = row;
        self.colIndex = col;
    }
    return self;
}

@end
