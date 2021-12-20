//
//  MobileUICollectionViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>
#import "Board.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MobileUICollectionViewControllerDelegate <NSObject>
- (void) selectCell:(NSIndexPath*)selectedCellIndexPath;
@end

@interface MobileUICollectionViewController : UICollectionViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) Board* board;
@property (nonatomic, strong)id <MobileUICollectionViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
