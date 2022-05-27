//
//  FansHeaderView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "FansHeaderView.h"

@interface FansHeaderView()

@property (strong, nonatomic) UIButton *curBtn;

@end

@implementation FansHeaderView
- (void)chooseFansType:(UIButton *)sender{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chooseWhitchType:)]) {
        [self.delegate chooseWhitchType:sender.tag];
    }
    
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor colorNamed:@"color-red"]];
    
    [self.curBtn setTitleColor:color_3 forState:UIControlStateNormal];
    [self.curBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    self.curBtn = sender;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    MyLinearLayout *backLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    backLy.myHorzMargin = 0;
    backLy.myHeight = MyLayoutSize.wrap;
    backLy.gravity = MyGravity_Vert_Center;
    backLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    backLy.subviewHSpace = 12;
    backLy.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:backLy];
    
    UIButton *zhituiBtn = [BaseButton CreateBaseButtonTitle:@"直推" Target:self Action:@selector(chooseFansType:) Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    zhituiBtn.myWidth = 100;
    zhituiBtn.myHeight = 32;
    zhituiBtn.layer.cornerRadius = 16;
    zhituiBtn.layer.masksToBounds = YES;
    [backLy addSubview:zhituiBtn];
    
    UIButton *jiantuiBtn = [BaseButton CreateBaseButtonTitle:@"间推" Target:self Action:@selector(chooseFansType:) Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    jiantuiBtn.myWidth = 100;
    jiantuiBtn.myHeight = 32;
    jiantuiBtn.layer.cornerRadius = 16;
    jiantuiBtn.layer.masksToBounds = YES;
    [backLy addSubview:jiantuiBtn];
    
    self.curBtn = zhituiBtn;
    
}
@end
