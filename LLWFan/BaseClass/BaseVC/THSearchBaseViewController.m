//
//  THSearchBaseViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "THSearchBaseViewController.h"
#import "SearchNavBar.h"

@interface THSearchBaseViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) SearchNavBar *nav;

@end

@implementation THSearchBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    self.nav = [[SearchNavBar alloc] initWithFrame:CGRectZero];
    weakSelf(self)
    self.nav.searchResuleBlcok = ^(NSArray * _Nonnull resultArr, NSString * _Nonnull searchText) {
        if (weakSelf.searchResuleBlcok) {
            
            weakSelf.searchResuleBlcok(resultArr,searchText);
        }
    };
    [self.view insertSubview:self.nav atIndex:0];
}
- (void)viewDidLayoutSubviews{
    
    self.nav.frame = CGRectMake(0, 0, ScreenWidth, KNavBarHeight);
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
@end
