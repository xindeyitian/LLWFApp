//
//  ProductShareView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "ProductShareView.h"

@interface ProductShareView()

@property (strong, nonatomic) MyLinearLayout *productLy;
@property (strong, nonatomic) UIImageView    *productImage, *qrCode;
@property (strong, nonatomic) UILabel        *productName, *productPrice, *productOldPrice;

@end

@implementation ProductShareView
- (void)setModel:(ProductDetailModel *)model{
    
    _model = model;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImgs.images[0]] placeholderImage:IMAGE_NAMED(@"")];
    self.productName.text = model.goodsName;
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.marketPrice);
    self.productOldPrice.text = NSStringFormat(@"¥%.2f",model.salePrice);;
}
- (void)funcBtnClicked:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
        {
            //分享到朋友圈
        }
            break;
        case 1:
        {
            //分享到微信好友
        }
            break;
        case 2:
        {
            //截图保存相册
            [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
            UIImage *image = [self snapshotSingleView:self.productLy];
            [self loadImageFinished:image];
        }
            break;
        case 3:
        {
            //赋值口令
        }
            break;
            
        default:
            break;
    }
}
- (UIImage *)snapshotSingleView:(UIView *)view
{
    CGRect rect =  view.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO,0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), ^{
//           dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//            });
    });
    if (error == nil) {
//        [weakSelf showText:@"保存成功" maskType:SSProgressHUDMaskTypeBlack finished:nil];
        
    } else {
//        [weakSelf showText:@"保存失败" maskType:SSProgressHUDMaskTypeBlack finished:nil];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCusView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCusView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    [self addSubview:self.rootLy];
    
    self.productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.productLy.myHorzMargin = 35;
    self.productLy.myHeight = MyLayoutSize.wrap;
    self.productLy.padding = UIEdgeInsetsMake(8, 8, 12, 8);
    self.productLy.layer.cornerRadius = 8;
    self.productLy.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.productLy.layer.shadowOffset = CGSizeMake(0,2);
    self.productLy.layer.shadowOpacity = 1;
    self.productLy.layer.shadowRadius = 4;
    self.productLy.backgroundColor = UIColor.whiteColor;
    self.productLy.myBottom = -30;
    [self.rootLy addSubview:self.productLy];
    self.productLy.layer.zPosition = 1;
    
    self.productImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.productImage.myHeight = self.productImage.myWidth = ScreenWidth - 70 - 16;
    self.productImage.layer.cornerRadius = 8;
    self.productImage.layer.masksToBounds = YES;
    [self.productLy addSubview:self.productImage];
    
    self.productName = [BaseLabel CreateBaseLabelStr:@"阔色法式复古针织连衣裙2021阔色法式复" Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.productName.myHorzMargin = 0;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.numberOfLines = 0;
    self.productName.myTop = 8;
    [self.productLy addSubview:self.productName];
    
    MyLinearLayout *priceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    priceLy.myHorzMargin = 0;
    priceLy.myHeight = MyLayoutSize.wrap;
    priceLy.myTop = 8;
    priceLy.gravity = MyGravity_Vert_Bottom;
    priceLy.subviewHSpace = 8;
    [self.productLy addSubview:priceLy];
    
    self.productPrice = [BaseLabel CreateBaseLabelStr:@"¥38.90" Font:[UIFont fontWithName:@"DIN-Medium" size:18] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.productPrice.myWidth = self.productPrice.myHeight = MyLayoutSize.wrap;
    [priceLy addSubview:self.productPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:25] range:NSMakeRange(1, [self.productPrice.text rangeOfString:@"."].location - 1)];
    self.productPrice.attributedText = attr;
    
    self.productOldPrice = [BaseLabel CreateBaseLabelStr:@"¥288.88" Font:[UIFont systemFontOfSize:11] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.productOldPrice.myWidth = self.productOldPrice.myHeight = MyLayoutSize.wrap;
    [priceLy addSubview:self.productOldPrice];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.productOldPrice.text attributes:attribtDic];
    self.productOldPrice.attributedText = attribtStr;
   
    MyLinearLayout *imgLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    imgLy.myHorzMargin = 0;
    imgLy.myHeight = MyLayoutSize.wrap;
    imgLy.gravity = MyGravity_Vert_Center;
    [self.productLy addSubview:imgLy];
    
    UIImageView *shareImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"shareProduct")];
    shareImage.myWidth = 140;
    shareImage.myHeight = 45;
    shareImage.myLeft = 8;
    [imgLy addSubview:shareImage];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [imgLy addSubview:nilView];
    
    self.qrCode = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.qrCode.myWidth = self.qrCode.myHeight = 96;
    [imgLy addSubview:self.qrCode];
    
    MyLinearLayout *bottomShareLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    bottomShareLy.myHorzMargin = 0;
    bottomShareLy.myHeight = MyLayoutSize.wrap;
    bottomShareLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    bottomShareLy.gravity = MyGravity_Horz_Center;
    bottomShareLy.paddingTop = 30;
    [self.rootLy addSubview:bottomShareLy];
    
    UILabel *shareTitle = [BaseLabel CreateBaseLabelStr:@"分 享" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    shareTitle.myWidth = shareTitle.myHeight = MyLayoutSize.wrap;
    shareTitle.myTop = 12;
    [bottomShareLy addSubview:shareTitle];
    
    MyFlowLayout *btnLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:4];
    btnLy.myHorzMargin = 50;
    btnLy.myHeight = MyLayoutSize.wrap;
    btnLy.subviewHSpace = 20;
    btnLy.myTop = 12;
    [bottomShareLy addSubview:btnLy];
    
    NSArray *titleArr = @[@"朋友圈",@"微信好友",@"下载",@"复制口令"];
    NSArray *imgArr = @[@"shareWXFriend",@"shareWX",@"download",@"copyword"];
    
    for (int i = 0; i < 4; i++) {
        
        DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectZero];
        btn.buttonStyle = DKSButtonImageTop;
        btn.padding = 6;
        btn.tag = i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAMED(imgArr[i]) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn setTitleColor:color_9 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(funcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.myWidth = (ScreenWidth - 100 - 60) / 4;
        btn.myHeight = 75;
        [btnLy addSubview:btn];
    }
    
    UIButton *cancleBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(cancle) Font:[UIFont systemFontOfSize:18] BackgroundColor:UIColor.whiteColor Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    cancleBtn.myHorzMargin = 0;
    cancleBtn.myHeight = 55;
    cancleBtn.myTop = 12;
    [bottomShareLy addSubview:cancleBtn];
    
    
}
- (void)cancle{
    
    if (self.cancleCilcked) {
        
        self.cancleCilcked();
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
