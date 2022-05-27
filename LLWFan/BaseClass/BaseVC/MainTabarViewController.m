//
//  MainTabarViewController.m
//  Yiyuanxunbo
//
//  Created by zuidap on 15/11/12.
//  Copyright © 2015年 zuidap. All rights reserved.
//

#import "MainTabarViewController.h"
#import <IQKeyboardManager.h>
#import "THBaseNavigationViewController.h"
#import "HomeBaseViewController.h"
#import "MerchantViewController.h"
#import "LobbyViewController.h"
#import "MyViewController.h"
#import "ShoppingCarViewController.h"
#import "OrderBaseViewController.h"
#import "AddAddressViewController.h"
@interface MainTabarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    [self createCtrs];
    //设置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
//    manager.toolbarTintColor = [UIColor redColor];
    self.tabBar.tintColor = UIColor.redColor;
    [[UITabBar appearance] setBarTintColor:UIColor.blackColor];
    [UITabBar appearance].translucent = NO;
    self.selectedIndex = 0;
    
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = UIColor.whiteColor;
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = UITabBarAppearance.new;
        
        UITabBarItemStateAppearance *normal = appearance.stackedLayoutAppearance.normal;
        if (normal) {
            normal.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor]};
        }
        
        UITabBarItemStateAppearance *selected = appearance.stackedLayoutAppearance.selected;
        if (selected) {
            selected.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor]};
        }
        self.tabBar.standardAppearance = appearance;
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)createCtrs{

    //初始化界面
    
    HomeBaseViewController *discountVC = [[HomeBaseViewController alloc]init];
    [self addChildVc:discountVC title:@"首页" image:@"discounts_noClicked" selectedImage:@"discounts_clicked" withTag:0];

    MerchantViewController *liveVC = [[MerchantViewController alloc]init];
    [self addChildVc:liveVC title:@"商家" image:@"live_noClicked" selectedImage:@"live_clicked" withTag:1];
    
    LobbyViewController * communityVC = [[LobbyViewController alloc]init];
    [self addChildVc:communityVC title:@"赚钱大厅" image:@"community_noClicked" selectedImage:@"community_clicked" withTag:2];
    
    ShoppingCarViewController *shoppingCar = [[ShoppingCarViewController alloc] init];
    [self addChildVc:shoppingCar title:@"购物车" image:@"shopping_noClicked" selectedImage:@"shopping_clicked" withTag:3];
    
    MyViewController * mySelfVC = [[MyViewController alloc]init];
    [self addChildVc:mySelfVC title:@"我的" image:@"my_noClicked" selectedImage:@"my_clicked" withTag:4];
//    OrderBaseViewController * mySelfVC = [[OrderBaseViewController alloc]init];
//    [self addChildVc:mySelfVC title:@"我的" image:@"my_noClicked" selectedImage:@"my_clicked" withTag:4];
//    AddAddressViewController * mySelfVC = [[AddAddressViewController alloc]init];
//    [self addChildVc:mySelfVC title:@"我的" image:@"my_noClicked" selectedImage:@"my_clicked" withTag:4];
}
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage withTag:(int)tag{
    
    childVc.tabBarItem.tag = tag;

    
    // 为子控制器包装导航控制器
    THBaseNavigationViewController *navigationVc = [[THBaseNavigationViewController alloc] initWithRootViewController:childVc];
    [navigationVc.tabBarItem setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:10]}     forState:UIControlStateNormal];
    [navigationVc.tabBarItem setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:10]}    forState:UIControlStateSelected];
    navigationVc.tabBarItem.title = title;
    navigationVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //防止image被渲染
    UIImage *selectimage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationVc.tabBarItem.selectedImage = selectimage;
    // 添加子控制器
    [self addChildViewController:navigationVc];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
