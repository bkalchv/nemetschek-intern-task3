//
//  CardViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 25.01.22.
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.gameImageView setImage:[UIImage imageNamed:self.imageFileName]];
    [self.gameNameLabel setText: self.titleText];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
