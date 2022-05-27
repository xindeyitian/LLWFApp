//
//  BaseNavBar.m
//  SeaEgret
//
//  Created by MAC on 2021/3/23.
//

#import "BaseNavBar.h"
#import "SearchListViewController.h"

@interface BaseNavBar()<UITextFieldDelegate>

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *searchBackView;
@property (strong, nonatomic) UIButton *saoBtn, *messageBtn;
@property (strong, nonatomic) UILabel *searchLable;
@property (strong, nonatomic) MyLinearLayout *line, *searchLy;

@end

@implementation BaseNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)searchBtnClicked:(UIButton *)sender{
    
    [self.currentViewController.navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
}
-(void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myHorzMargin = 10;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.cacheEstimatedRect = YES;
    self.rootLy.subviewHSpace = 10;
    [self addSubview:self.rootLy];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBtnClicked:)];
    self.searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.searchLy.weight = 1;
    self.searchLy.myHeight = 30;
    self.searchLy.myTop = RootStatusBarHeight;
    self.searchLy.gravity = MyGravity_Vert_Center;
    self.searchLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    self.searchLy.layer.cornerRadius = 5;
    self.searchLy.layer.masksToBounds = YES;
    self.searchLy.layer.borderWidth = .5;
    self.searchLy.layer.borderColor = UIColor.clearColor.CGColor;
    [self.searchLy addGestureRecognizer:tap];
    [self.rootLy addSubview:self.searchLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.myWidth = img.myHeight = 20;
    img.myLeft = 5;
    [self.searchLy addSubview:img];
    
    self.searchLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.searchLable.font = [UIFont systemFontOfSize:13];
    self.searchLable.text = @"输入宝贝名称";
    self.searchLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.75];
    self.searchLable.myWidth = 80;
    self.searchLable.myHeight = 20;
    self.searchLable.myLeft = 7;
    [self.searchLy addSubview:self.searchLable];
    
    self.messageBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(saoyisao) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"xiaoxi" HeightLightBackgroundImage:@"scan"];
    self.messageBtn.myWidth = self.messageBtn.myHeight = 30;
    self.messageBtn.myTop = RootStatusBarHeight;
    [self.rootLy addSubview:self.messageBtn];
    
    self.saoBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(saoyisao) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"scan" HeightLightBackgroundImage:@"scan"];
    self.saoBtn.myWidth = self.saoBtn.myHeight = 30;
    self.saoBtn.myTop = RootStatusBarHeight;
    [self.rootLy addSubview:self.saoBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
