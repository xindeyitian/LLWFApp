//
//  THBaseViewController.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/3.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "THBaseViewController.h"

@interface THBaseViewController ()
{
    UIImageView *navBarHairlineImageView;//去掉导航栏黑线的image
}
@end

@implementation THBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //自定义Navgationbar
//    [self customTitlebar];
    self.page = 1;
   
    if (self.navigationController.viewControllers.count > 1) {
        //自定义的返回按钮
        [self.navigationItem setLeftBarButtonItem:self.leftButtonItem];
    }

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    //初始化VIew
    
    [self initView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationWillTerminateNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
            return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
/**
 进入前台
 */
- (void)applicationWillEnterForeground{

    
}


/**
 进入后台
 */
- (void)applicationDidEnterBackground{

    
}
/** 程序被杀死 */
-(void)applicationWillTerminate{
    //  - 监听到 app 被杀死时候的回调....
    
    
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{

//    [self customTransition];

    [super  presentViewController:viewControllerToPresent animated:flag completion:completion];

}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{

//      [self customTransition];
    
    [super dismissViewControllerAnimated:flag completion:completion];

}


-(void)initView{

    
}
#pragma mark 返回按钮
- (void)returnAction
{
    
    if (self.navigationController.viewControllers.count == 1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 懒加载
- (UIBarButtonItem *)leftButtonItem
{
    if (_leftButtonItem == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0,0 ,25, 25);
        btn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 20, 0);
        [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem  =  [[UIBarButtonItem alloc] initWithCustomView:btn];
          //UIBarButtonItem *buttonItem  =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
        _leftButtonItem = buttonItem;
    }
    return _leftButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SetIOS13
    navBarHairlineImageView.hidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    //传递给VIew当前的VC
    [THAPPService shareAppService].currentViewController = self;
    
    //添加网络状态通知子类级所有人
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AFNetworkingReachabilityDidChang:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}


//AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
//AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络
//AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
//AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
//所有的子类实现这个函数 来判断网络的状态
- (void)AFNetworkingReachabilityDidChang:(NSNotification *)note
{
    
    NSDictionary *usderInfo = note.userInfo;
    
    AFNetworkReachabilityStatus status = [[usderInfo valueForKey:AFNetworkingReachabilityNotificationStatusItem] integerValue];
    
    PLog(@"AFNetworkReachabilityStatus:%ld",(long)status);
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)dealloc{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
