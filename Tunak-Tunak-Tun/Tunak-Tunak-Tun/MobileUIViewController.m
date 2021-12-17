//
//  MobileUIViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "MobileUIViewController.h"
#import "Engine.h"
#import "MobileUICollectionViewController.h"
#import "MobileUICollectionViewCell.h"

@interface MobileUIViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mobileUIUsernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileUIInputTextField;
@end

@implementation MobileUIViewController

- (void)refreshView {
    self.mobileUIUsernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", self.username];
    self.gameEngine = [[Engine alloc] initWithPlayersName:self.username];
    [self.gameEngine printBoardState];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mobileUIUsernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", self.username];
    self.mobileUIInputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"ShowMobileUICollectionView"]) {
        MobileUICollectionViewController* mobileUICollectionViewController = [segue destinationViewController];
        self.gameEngine = [[Engine alloc] initWithPlayersName: self.username];
        mobileUICollectionViewController.delegate = self;
        mobileUICollectionViewController.board = self.gameEngine.gameBoard;
    }
}

- (void) selectCell:(NSIndexPath*)selectedCellIndexPath {

}


@end
