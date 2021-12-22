//
//  MobileUICollectionViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "MobileUICollectionViewController.h"
#import "MobileUICollectionViewCell.h"
#import "OneMoreTimeViewController.h"

@interface MobileUICollectionViewController ()
@end

@implementation MobileUICollectionViewController

static NSString * const reuseIdentifier = @"MobileUICollectionViewCell";

- (void)refreshView {
    self.gameEngine = [[Engine alloc] initWithPlayersName: self.username];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.gameEngine.isGameOver || !self.gameEngine.hasFreeCells) [self refreshView];
    self.collectionView.allowsSelection = YES;
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = YES;
}

- (bool)shouldGameContinue {
    if ([self.gameEngine isGameOver]) {
        if (!self.gameEngine.hasFreeCells && !self.gameEngine.winningConditionsFulfiled) {
            NSLog(@"It's a draw. Nobody wins!");
            [self.delegate showDrawAlert: [self.gameEngine gameBoardState]];
        } else if (self.gameEngine.winningConditionsFulfiled) {
            [self.delegate showPlayerWonAlert: self.gameEngine.currentPlayer withGameBoardState:[self.gameEngine gameBoardState]];
        }
        return false;
    } else
        return true;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"I was pressed: %@", indexPath);
    
    NSUInteger inputIndex = [indexPath indexAtPosition:1];
    
    if ([self.gameEngine isCellCheckedAtIndex: inputIndex]) {
        //[self.delegate showAlreadySelectedAlertForCell:selectedGameCell]; // TODO DO NOT SHOW
        NSLog(@"Cell %tu already selected! Please select another cell!", inputIndex);
    } else {
        [self.gameEngine selectCellAtIndex:inputIndex];
        [self.collectionView reloadData];
        [self.gameEngine printBoardState];
        
        if ([self shouldGameContinue]) {
            [self.gameEngine switchCurrentPlayer];
            [self.delegate updateUsernameLabel:[self.gameEngine currentPlayer].name];
            if (self.gameEngine.gameMode == GameModeOnePlayer) {
                [self.collectionView reloadData];
                [self.gameEngine printBoardState];
                [self shouldGameContinue];
            }
        }
    }
}

#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellsAmount = self.gameEngine.gameBoard.boardMatrixArray.count;
    return cellsAmount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = (CGRectGetWidth(collectionView.frame) * 0.33); // 33% width of the CollectionView Frame
    CGFloat cellHeight = (CGRectGetHeight(collectionView.frame) * 0.33); // 33 height of the CollectionView Frame
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(NSString*)cellLabelTextByState:(CellState)state {
    switch (state) {
        case CellStateO:
            return @"O";
            break;
        case CellStateX:
            return @"X";
            break;
        case CellStateEmpty:
            return @"";
            break;

        default:
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MobileUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Cell* gameCell = [self.gameEngine cellAtIndex: [indexPath indexAtPosition:1]];
    NSString* cellLabelText = [self cellLabelTextByState:gameCell.state];
    [cell.cellLabel setText: cellLabelText];
    [cell setBackgroundColor: UIColor.grayColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
