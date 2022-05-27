//
//  YinsiFuwuViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/7/16.
//

#import "YinsiFuwuViewController.h"

@interface YinsiFuwuViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout *backLy;
@property (strong, nonatomic) UIScrollView *backScroll;
@property (strong, nonatomic) WKWebView    *webView;

@end

@implementation YinsiFuwuViewController
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) configuration:wkWebConfig];
    [self.view addSubview:self.webView];
    if (_type == 1) {
        //服务
        self.title = @"服务条款";
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/serviceAgreement.html"]]];
    }else if(_type == 2){
        self.title = @"隐私条款";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/privacyPolicy.html"]]];
    }else if (_type == 3){
        self.title = @"海鹭跨境用户行为公约";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/conventionConduct.html"]]];
    }else{
        self.title = @"用户使用许可协议";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/behaviorProtocol.html"]]];
    }
}
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//    if ([viewController isKindOfClass:[self class]]) {
//        [navigationController setNavigationBarHidden:YES animated:YES];
//    }else {
//        [navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}
@end
