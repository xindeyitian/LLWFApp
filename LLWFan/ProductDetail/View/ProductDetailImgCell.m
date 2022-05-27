//
//  ProductDetailImgCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/16.
//

#import "ProductDetailImgCell.h"

@interface ProductDetailImgCell()<WKNavigationDelegate>

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) WKWebView      *web;

@end

@implementation ProductDetailImgCell
- (void)setCellWithModel:(ProductDetailModel *)model{
    
    [self.web loadHTMLString:model.descImgs baseURL:nil];
}
#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGFloat newHeight = self.web.scrollView.contentSize.height;
        self.web.height = newHeight;
        [self.rootLy layoutSubviews];
        KPostNotification(@"reloadWebViewheight", NSStringFormat(@"%f",newHeight));
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 12, 0);
    [self.contentView addSubview:self.rootLy];
    
    //内容布局
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.backgroundColor = UIColor.clearColor;
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    [self.rootLy addSubview:contentLy];
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        NSString *script = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    
    [wkUController addUserScript: wkUserScript];
    config.userContentController = wkUController;
  
    self.web = [[WKWebView alloc]initWithFrame:self.bounds configuration:config];
    self.web.myHorzMargin = 0;
    self.web.myHeight = MyLayoutSize.wrap;
    self.web.navigationDelegate = self;
    self.web.scrollView.bounces = NO;
    [contentLy addSubview:self.web];
    
    [self.web.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
