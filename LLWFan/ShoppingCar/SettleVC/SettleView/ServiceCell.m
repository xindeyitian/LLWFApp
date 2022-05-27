//
//  ServiceCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "ServiceCell.h"

@interface ServiceCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *sendService, *manjianService, *message;

@end

@implementation ServiceCell
- (void)chooseSendService{
    
    
}
- (void)chooseManjian{
    
    
}
- (void)setCellWithModel:(UnionOrderModel *)model{
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.rootLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.rootLy addSubview:self.contentLy];
    
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSendService)];
    
    MyLinearLayout *sendServiceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    sendServiceLy.myHorzMargin = 0;
    sendServiceLy.myHeight = 48;
    sendServiceLy.gravity = MyGravity_Vert_Center;
    sendServiceLy.subviewHSpace = 8;
    [sendServiceLy addGestureRecognizer:sendTap];
    [self.contentLy addSubview:sendServiceLy];
    
    UILabel *send = [[UILabel alloc] initWithFrame:CGRectZero];
    send.text = @"配送服务";
    send.font = [UIFont systemFontOfSize:17];
    send.textColor = color_3;
    send.myWidth = send.myHeight = MyLayoutSize.wrap;
    [sendServiceLy addSubview:send];
    
    self.sendService = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sendService.weight = 1;
    self.sendService.myHeight = MyLayoutSize.wrap;
    self.sendService.font = [UIFont systemFontOfSize:17];
    self.sendService.textColor = color_3;
    self.sendService.text = @"包邮";
    self.sendService.textAlignment = NSTextAlignmentRight;
    [sendServiceLy addSubview:self.sendService];
    
    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right.myWidth = 13;
    right.myHeight = 13;
    [sendServiceLy addSubview:right];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    sendServiceLy.bottomBorderline = line;
    
    UITapGestureRecognizer *manjianTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseManjian)];
    
    MyLinearLayout *manjianLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    manjianLy.myHorzMargin = 0;
    manjianLy.myHeight = 48;
    manjianLy.gravity = MyGravity_Vert_Center;
    manjianLy.subviewHSpace = 8;
    manjianLy.visibility = MyVisibility_Gone;
    [manjianLy addGestureRecognizer:manjianTap];
    [self.contentLy addSubview:manjianLy];
    
    UILabel *manjian = [[UILabel alloc] initWithFrame:CGRectZero];
    manjian.text = @"优惠券";
    manjian.font = [UIFont systemFontOfSize:17];
    manjian.textColor = color_3;
    manjian.myWidth = manjian.myHeight = MyLayoutSize.wrap;
    [manjianLy addSubview:manjian];
    
    self.manjianService = [[UILabel alloc] initWithFrame:CGRectZero];
    self.manjianService.weight = 1;
    self.manjianService.myHeight = MyLayoutSize.wrap;
    self.manjianService.font = [UIFont systemFontOfSize:17];
    self.manjianService.textColor = color_9;
    self.manjianService.text = @"暂无优惠券";
    self.manjianService.textAlignment = NSTextAlignmentRight;
    [manjianLy addSubview:self.manjianService];
    
    //右箭头
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right1.myWidth = 13;
    right1.myHeight = 13;
    [manjianLy addSubview:right1];
    
    MyBorderline *line1 = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    manjianLy.bottomBorderline = line1;
    
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseManjian)];
    
    MyLinearLayout *messageLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    messageLy.myHorzMargin = 0;
    messageLy.myHeight = 48;
    messageLy.gravity = MyGravity_Vert_Center;
    messageLy.subviewHSpace = 8;
    [messageLy addGestureRecognizer:messageTap];
    [self.contentLy addSubview:messageLy];
    
    UILabel *messageTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    messageTitle.text = @"留言备注";
    messageTitle.font = [UIFont systemFontOfSize:17];
    messageTitle.textColor = color_3;
    messageTitle.myWidth = messageTitle.myHeight = MyLayoutSize.wrap;
    [messageLy addSubview:messageTitle];
    
    self.message = [[UILabel alloc] initWithFrame:CGRectZero];
    self.message.weight = 1;
    self.message.myHeight = MyLayoutSize.wrap;
    self.message.font = [UIFont systemFontOfSize:17];
    self.message.textColor = color_9;
    self.message.text = @"无备注";
    self.message.textAlignment = NSTextAlignmentRight;
    [messageLy addSubview:self.message];
    
    //右箭头
    UIImageView *right2 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right2.myWidth = 13;
    right2.myHeight = 13;
    [messageLy addSubview:right2];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
