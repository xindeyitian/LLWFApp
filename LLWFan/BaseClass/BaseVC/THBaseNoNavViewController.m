//
//  THBaseNoNavViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/3/22.
//

#import "THBaseNoNavViewController.h"

@interface THBaseNoNavViewController ()<UINavigationControllerDelegate>

@end

@implementation THBaseNoNavViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    self.nav = [[BaseNavBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    [self.view addSubview:self.nav];
    
    self.topHeight = self.nav.height;
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
