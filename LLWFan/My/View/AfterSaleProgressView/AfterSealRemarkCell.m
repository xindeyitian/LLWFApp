//
//  AfterSealRemarkCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/1.
//

#import "AfterSealRemarkCell.h"

@interface AfterSealRemarkCell()

@property (strong, nonatomic) MyLinearLayout         *rootLy;
@property (strong, nonatomic) UILabel                *remarkLable;
@property (strong, nonatomic) UILabel                *remarkNum;
@property (strong, nonatomic) UIButton               *choosePictureBtn;
@property (strong, nonatomic) MyFlowLayout           *imgLy;

@end

@implementation AfterSealRemarkCell
- (void)initCellWithModel:(AfterSaleDetailModel *)model{
    
    self.remarkLable.text = model.dealDesc;
    self.remarkNum.text = NSStringFormat(@"%ld/200",model.dealDesc.length);
    [self.imgLy removeAllSubviews];
    
    for (int i = 0; i < model.imgUrlList.count; i++) {
        
        NSString *url = model.imgUrlList[i];
        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE_NAMED(@"")];
        img.myWidth = img.myHeight = (ScreenWidth - 88) / 3;
        [self.imgLy addSubview:img];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
-(void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.subviewVSpace = 12;
    contentLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:contentLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"补充描述和凭证" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:title];
    
    MyLinearLayout *remarkLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    remarkLy.myHorzMargin = 0;
    remarkLy.myHeight = MyLayoutSize.wrap;
    remarkLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    remarkLy.subviewVSpace = 8;
    remarkLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    remarkLy.layer.cornerRadius = 12;
    remarkLy.layer.masksToBounds = YES;
    [contentLy addSubview:remarkLy];
    
    self.remarkLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.remarkLable.myHorzMargin = 0;
    self.remarkLable.myHeight = MyLayoutSize.wrap;
    self.remarkLable.font = [UIFont systemFontOfSize:12];
    self.remarkLable.textColor = color_6;
    self.remarkLable.numberOfLines = 0;
    self.remarkLable.text = @"物流太慢，质量差";
    [remarkLy addSubview:self.remarkLable];
    
    self.remarkNum = [BaseLabel CreateBaseLabelStr:@"0/200" Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentRight Tag:0];
    self.remarkNum.myHorzMargin = 0;
    self.remarkNum.myHeight = MyLayoutSize.wrap;
    [remarkLy addSubview:self.remarkNum];
    
    self.imgLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
    self.imgLy.subviewHSpace = 8;
    self.imgLy.myHorzMargin = 0;
    self.imgLy.myHeight = MyLayoutSize.wrap;
    [remarkLy addSubview:self.imgLy];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
