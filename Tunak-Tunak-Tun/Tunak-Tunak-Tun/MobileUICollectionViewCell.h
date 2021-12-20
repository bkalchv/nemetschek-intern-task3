//
//  MobileUICollectionViewCell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 20.12.21.
//

#import <UIKit/UIKit.h>
#import "Cell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobileUICollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
-(void)updateCellLabelByState:(CellState)state;
@end

NS_ASSUME_NONNULL_END
