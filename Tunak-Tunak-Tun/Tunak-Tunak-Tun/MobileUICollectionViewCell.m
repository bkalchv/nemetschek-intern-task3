//
//  MobileUICollectionViewCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 20.12.21.
//

#import "MobileUICollectionViewCell.h"

@implementation MobileUICollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateCellLabel:(NSString*)labelText {
    [self.cellLabel setText:labelText];
}

-(void)updateCellLabelByState:(CellState)state {
    switch (state) {
        case CellStateO:
            [self updateCellLabel:@"O"];
            break;
        case CellStateX:
            [self updateCellLabel:@"X"];
            break;

        default:
            break;
    }
}

@end
