//
//  SearchNavBar.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "SearchNavBar.h"

@interface SearchNavBar()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIButton       *backBtn;
@property (strong, nonatomic) UITextField    *searchTF;

@end

@implementation SearchNavBar
- (void)searchProduct{
    
    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager searchWithKeyword:self.searchTF.text AndPageNum:@"1" AndPageSize:@"10" AndProductCategoryId:@"" AndShopId:@"" AndSort:@"0" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            });
            if (self.searchResuleBlcok) {
                
                self.searchResuleBlcok([ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]],self.searchTF.text);
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            });
        }
    }];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)back{
    
    [self.currentViewController.navigationController popViewControllerAnimated:YES];
}
-(void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = KNavBarHeight;
    self.rootLy.subviewHSpace = 0;
    self.rootLy.gravity = MyGravity_Vert_Bottom;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    self.backBtn.myWidth = 40;
    self.backBtn.myHeight = 40;
    [self.rootLy addSubview:self.backBtn];
    
    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.weight = 1;
    searchLy.myHeight = 30;
    searchLy.myBottom = 5;
    searchLy.layer.borderWidth = 1;
    searchLy.layer.borderColor = [UIColor colorWithHexString:@"#E61F10"].CGColor;
    searchLy.layer.cornerRadius = 6;
    searchLy.layer.masksToBounds = YES;
    searchLy.gravity = MyGravity_Vert_Center;
    searchLy.padding = UIEdgeInsetsMake(0, 8, 0, 12);
    [self.rootLy addSubview:searchLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    [img setImage:IMAGE_NAMED(@"放大镜_black")];
    img.myWidth = img.myHeight = 20;
    img.myLeft = 8;
    [searchLy addSubview:img];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 30;
    self.searchTF.placeholder = @"搜索店铺名称";
    self.searchTF.backgroundColor = UIColor.whiteColor;
    self.searchTF.tintColor = UIColor.redColor;
    self.searchTF.myLeft = 5;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.font = [UIFont systemFontOfSize:13];
    [searchLy addSubview:self.searchTF];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchProduct) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    searchBtn.backgroundColor = UIColor.whiteColor;
    searchBtn.myWidth = 50;
    searchBtn.myHeight = 40;
    [self.rootLy addSubview:searchBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
