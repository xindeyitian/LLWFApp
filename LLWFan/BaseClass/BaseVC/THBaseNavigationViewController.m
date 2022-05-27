//
//  THBaseNavigationViewController.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/5.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "THBaseNavigationViewController.h"

@interface THBaseNavigationViewController ()

@end

@implementation THBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navLeftButton = [BaseButton CreateBaseButtonTitle:nil Target:self Action:@selector(backUp) Font:nil BackgroundColor:UIColor.whiteColor Color:nil Frame:CGRectMake(0, 0, 20, 20) Alignment:0 Tag:0];
//    [self.navLeftButton setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    
    //navigation标题文字颜色
    NSDictionary *dic = @{NSForegroundColorAttributeName : color_3,
                          NSFontAttributeName : [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]};
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        [barApp configureWithOpaqueBackground];
        barApp.backgroundColor = UIColor.whiteColor;
        barApp.titleTextAttributes = dic;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }else{
        //背景色
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.tintColor = nil;
    }
    //不透明
    self.navigationController.navigationBar.translucent = YES;
    //navigation控件颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

//    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//            
//            if (@available(iOS 10.0, *)) {
//
//                if (@available(iOS 13.0, *)) {
//                    
//                    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
//                }else {
//                    
//                    self.navigationController.navigationBar.subviews[0].subviews[1].hidden = YES;
//                }
//            }else{
//                //iOS10之前使用的是_UINavigationBarBackground
//                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//                    
//                    [view.subviews firstObject].hidden = YES;
//                }
//            }
//        }];
    
}
-(void)backUp{
    
    [self popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count >= 1) {
          viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];


}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//
//    UIViewController *VC = self.navigationController.viewControllers.lastObject;
// 
//    //这里判断
//    
//    return VC;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
