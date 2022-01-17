//
//  MobileUICollectionViewCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 20.12.21.
//

#import "MobileUICollectionViewCell.h"
#import "TicTacToeCellState.h"

@implementation MobileUICollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateCellLabel:(NSString*)labelText {
    [self.cellLabel setText:labelText];
}

-(void)updateCellLabelByState:(TicTacToeCellState)state {
    switch (state) {
        case TicTacToeCellStateO:
            [self updateCellLabel:@"O"];
            break;
        case TicTacToeCellStateX:
            [self updateCellLabel:@"X"];
            break;

        default:
            break;
    }
}

@end
