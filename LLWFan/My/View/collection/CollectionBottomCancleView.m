//
//  CollectionBottomCancleView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "CollectionBottomCancleView.h"

@interface CollectionBottomCancleView()

@property (strong, nonatomic) UIButton *allChooseBtn, *cancleBtn;

@end

@implementation CollectionBottomCancleView
- (void)allChoose{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chooseAllItem)]) {
        [self.delegate chooseAllItem];
    }
}
- (void)cancle{
    
    
}
- (instancetype)initWithFrame:(CGRect)frame AndViewType:(NSInteger )viewType
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomViewWithType:viewType];
    }
    return self;
}
- (void)initCustomViewWithType:(NSInteger )type{
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    rootLy.myWidth = ScreenWidth;
    rootLy.myHeight = 55;
    rootLy.gravity = MyGravity_Vert_Center;
    [self addSubview:rootLy];
    
    self.allChooseBtn = [BaseButton CreateBaseButtonTitle:@"全选" Target:self Action:@selector(allChoose) Font:[UIFont systemFontOfSize:13] BackgroundColor:UIColor.whiteColor Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    [self.allChooseBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    self.allChooseBtn.myWidth = 60;
    self.allChooseBtn.myHeight = 40;
    self.allChooseBtn.myLeft = 20;
    self.allChooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    [rootLy addSubview:self.allChooseBtn];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight =1;
    nilView.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:nilView];
    
    self.cancleBtn = [BaseButton CreateBaseButtonTitle:type ? @"取消关注":@"取消收藏" Target:self Action:@selector(cancle) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.cancleBtn.myWidth = 108;
    self.cancleBtn.myHeight = 40;
    self.cancleBtn.myRight = 12;
    self.cancleBtn.layer.cornerRadius = 20;
    self.cancleBtn.layer.masksToBounds = YES;
    [rootLy addSubview:self.cancleBtn];
    
}
@end
