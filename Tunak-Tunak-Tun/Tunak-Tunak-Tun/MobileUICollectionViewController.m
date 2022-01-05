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
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer:
            self.gameEngine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            break;
        case GameModeTwoPlayers:
            self.gameEngine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name:[GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            break;
            
        default:
            break;
    }
    
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

- (void)handleWin {
    NSLog(@"%@ won!", self.gameEngine.currentPlayer.name);
    NSLog(@"Game over!");
    [self.delegate showPlayerWonAlert: self.gameEngine.currentPlayer withGameBoardState:[self.gameEngine gameBoardState]];
}

- (void)handleDraw {
    NSLog(@"It's a draw. Nobody wins!");
    [self.delegate showDrawAlert: [self.gameEngine gameBoardState]];
}

-(void)printCurrentPlayerSelection {
    NSLog(@"Player: %@ selected: %tu %tu", self.gameEngine.currentPlayer.name, [self.gameEngine.currentPlayer.lastSelectedCell indexAtPosition:0], [self.gameEngine.currentPlayer.lastSelectedCell indexAtPosition:1]);
}

-(void)checkGameOutcome {
    if ([self.gameEngine winningConditionsFulfiled]) {
        [self handleWin];
    } else if (![self.gameEngine winningConditionsFulfiled] && ![self.gameEngine hasFreeCells]) {
        [self handleDraw];
    } else {
        [self printCurrentPlayerSelection];
    }
}

-(void)handleSelection:(NSIndexPath*)indexPath {
    
    [self.gameEngine.currentPlayer setLastSelectedCell: indexPath];
    
    if ([self.gameEngine didCurrentPlayerMakeValidMove])
    {
        [self.collectionView reloadData];
        [self.gameEngine printBoardState];
        
        //Check game outcome
        [self checkGameOutcome];
        
        if (![self.gameEngine isGameOver]) [self.gameEngine switchCurrentPlayer];
    
        if (self.gameEngine.gameMode == GameModeOnePlayer) {
            [self.collectionView reloadData];
            [self.gameEngine printBoardState];
            
            //Check game outcome
            [self checkGameOutcome];
            //If game is still not over - switch current player back to player;
            if (![self.gameEngine isGameOver]) [self.gameEngine switchCurrentPlayer];
        } else {
            [self.delegate updateUsernameLabel:[self.gameEngine.currentPlayer name]];
        }
        
    } else {
        NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", [self.gameEngine.currentPlayer.lastSelectedCell section], [self.gameEngine.currentPlayer.lastSelectedCell row]);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Stays for debugging purposes
    NSLog(@"I was pressed: %@", indexPath);
    
    NSUInteger inputIndex = [indexPath row];
    // section == indexAtPosition: 0 && row = indexAtPosition: 1 for indexPath, therefore swapped
    NSIndexPath* inputIndexPath = [NSIndexPath indexPathForRow:[self.gameEngine calculateColumnIndex:inputIndex] inSection:[self.gameEngine calculateRowIndex:inputIndex]];
    
    [self handleSelection: inputIndexPath];
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
    NSIndexPath* cellIndexPath = [NSIndexPath indexPathForRow:[self.gameEngine calculateColumnIndex:indexPath.row] inSection:[self.gameEngine calculateRowIndex:indexPath.row]];
    Cell* gameCell = [self.gameEngine.gameBoard cellAt: cellIndexPath];
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
