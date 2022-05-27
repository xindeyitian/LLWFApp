//
//  YLTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "YLTableViewCell.h"

@interface YLTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *from, *num, *time, *allNum;


@end

@implementation YLTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.rootLy.subviewVSpace = 4;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.padding = UIEdgeInsetsMake(0, 12, 12, 12);
    self.contentLy.backgroundColor = UIColor.whiteColor;
//    self.contentLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Center;
    self.contentLy.subviewVSpace = 4;
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    topLy.gravity = MyGravity_Vert_Center;
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:topLy];
    
    self.from = [[UILabel alloc] initWithFrame:CGRectZero];
    self.from.font = [UIFont systemFontOfSize:13];
    self.from.textColor = color_3;
    self.from.text = @"天天赚钱-分享商品";
    self.from.weight = 1;
    self.from.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:self.from];
    
    self.num = [[UILabel alloc] initWithFrame:CGRectZero];
    self.num.font = [UIFont fontWithName:@"DIN-Medium" size:13];
    self.num.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.num.text = @"+5.6600";
    self.num.myWidth = MyLayoutSize.wrap;
    self.num.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:self.num];
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.gravity = MyGravity_Vert_Center;
    bottomLy.myHorzMargin = 0;
    bottomLy.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:bottomLy];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectZero];
    self.time.font = [UIFont systemFontOfSize:12];
    self.time.textColor = color_9;
    self.time.text = @"10-12 12:30";
    self.time.weight = 1;
    self.time.myHeight = MyLayoutSize.wrap;
    [bottomLy addSubview:self.time];
    
    self.allNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allNum.font = [UIFont systemFontOfSize:12];
    self.allNum.textColor = color_9;
    self.allNum.text = @"贡献值1398.0000";
    self.allNum.myWidth = MyLayoutSize.wrap;
    self.allNum.myHeight = MyLayoutSize.wrap;
    [bottomLy addSubview:self.allNum];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
