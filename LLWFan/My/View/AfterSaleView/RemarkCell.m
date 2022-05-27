//
//  RemarkCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "RemarkCell.h"
#import "ReleaseImageView.h"

@interface RemarkCell()<UITextViewDelegate,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto,_isShowLocation;
}
@property (strong, nonatomic) MyLinearLayout         *rootLy;
@property (strong, nonatomic) WWMPlaceholderTextView *remarkTV;
@property (strong, nonatomic) UILabel                *remarkNum;
@property (strong, nonatomic) UIButton               *choosePictureBtn;
@property (strong, nonatomic) MyFlowLayout           *imgLy;

@end

@implementation RemarkCell

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
    
    self.remarkTV = [[WWMPlaceholderTextView alloc] initWithFrame:CGRectZero];
    self.remarkTV.myHorzMargin = 0;
    self.remarkTV.myHeight = MyLayoutSize.wrap;
    self.remarkTV.placeholder = @"补充描述，有助于商家更好的处理今后问题";
    self.remarkTV.placeholderColor = color_9;
    self.remarkTV.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.remarkTV.delegate = self;
    [remarkLy addSubview:self.remarkTV];
    
    self.remarkNum = [BaseLabel CreateBaseLabelStr:@"0/200" Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentRight Tag:0];
    self.remarkNum.myHorzMargin = 0;
    self.remarkNum.myHeight = MyLayoutSize.wrap;
    [remarkLy addSubview:self.remarkNum];
    
    self.imgLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
    self.imgLy.subviewHSpace = 8;
    self.imgLy.myHorzMargin = 0;
    self.imgLy.myHeight = MyLayoutSize.wrap;
    [remarkLy addSubview:self.imgLy];
    
    self.choosePictureBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(choosePicture) Font:[UIFont systemFontOfSize:10] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    [self.choosePictureBtn setImage:IMAGE_NAMED(@"choosePicture") forState:UIControlStateNormal];
    self.choosePictureBtn.myWidth = self.choosePictureBtn.myHeight = (ScreenWidth - 88)/3;
    [self.imgLy addSubview:self.choosePictureBtn];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    self.remarkNum.text = NSStringFormat(@"%ld/200",textView.text.length);
    
    if (textView.text.length >= 200) {
        
        textView.text = [textView.text substringToIndex:199];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (self.returnRemarkBlock) {
        
        self.returnRemarkBlock(textView.text);
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
- (void)choosePicture{
    
    [self pushTZImagePickerController];
}
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    imagePickerVc.navigationBar.tintColor = [UIColor blackColor];
    // imagePickerVc.naviBgColor = [UIColor whiteColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch.isOn; // 在内部显示拍照按钮
    //    imagePickerVc.allowTakeVideo = self.showTakeVideoBtnSwitch.isOn;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    // imagePickerVc.photoWidth = 1600;
    // imagePickerVc.photoPreviewMaxWidth = 1600;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
     imagePickerVc.navigationBar.barTintColor = [UIColor lightGrayColor];
     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
     imagePickerVc.oKButtonTitleColorNormal = [UIColor colorNamed:@"color-red"];
     imagePickerVc.navigationBar.translucent = NO;
    [imagePickerVc setIconThemeColor:[UIColor colorNamed:@"color-red"]];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
//    imagePickerVc.allowTakeVideo = NO;
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor colorNamed:@"color-red"] forState:UIControlStateNormal];
    }];
    
     [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
         
//     cell.contentView.clipsToBounds = YES;
//     cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
     }];
     
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    //    imagePickerVc.allowPickingVideo = self.allowPickingVideoSwitch.isOn;
    //    imagePickerVc.allowPickingImage = self.allowPickingImageSwitch.isOn;
    //    imagePickerVc.allowPickingOriginalPhoto = self.allowPickingOriginalPhotoSwitch.isOn;
    //    imagePickerVc.allowPickingGif = self.allowPickingGifSwitch.isOn;
    //    imagePickerVc.allowPickingMultipleVideo = self.allowPickingMuitlpleVideoSwitch.isOn; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    //    imagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    //    imagePickerVc.showSelectBtn = NO;
    //    imagePickerVc.allowCrop = self.allowCropSwitch.isOn;
    //    imagePickerVc.needCircleCrop = self.needCircleCropSwitch.isOn;
    // 设置竖屏下的裁剪尺寸
    //    NSInteger left = 30;
    //    NSInteger widthHeight = self.view.tz_width - 2 * left;
    //    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    //    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    //    imagePickerVc.showSelectedIndex = self.showSelectedIndexSwitch.isOn;
    
    // 设置拍照时是否需要定位，仅对选择器内部拍照有效，外部拍照的，请拷贝demo时手动把pushImagePickerController里定位方法的调用删掉
    // imagePickerVc.allowCameraLocation = NO;
    
    // 自定义gif播放方案
    //    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
    //        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
    //        FLAnimatedImageView *animatedImageView;
    //        for (UIView *subview in imageView.subviews) {
    //            if ([subview isKindOfClass:[FLAnimatedImageView class]]) {
    //                animatedImageView = (FLAnimatedImageView *)subview;
    //                animatedImageView.frame = imageView.bounds;
    //                animatedImageView.animatedImage = nil;
    //            }
    //        }
    //        if (!animatedImageView) {
    //            animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:imageView.bounds];
    //            animatedImageView.runLoopMode = NSDefaultRunLoopMode;
    //            [imageView addSubview:animatedImageView];
    //        }
    //        animatedImageView.animatedImage = animatedImage;
    //    }];
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.currentViewController.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;

    [self.imgLy removeAllSubviews];
    [_selectedPhotos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        __block ReleaseImageView *imgV = [[[NSBundle mainBundle] loadNibNamed:@"ReleaseImageView" owner:nil options:nil] lastObject];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.myWidth = imgV.myHeight = (ScreenWidth - 88) / 3;
        imgV.tag = idx;
        [imgV.img setImage:obj];
        [self.imgLy addSubview:imgV];
        weakSelf(imgV)
        imgV.deleteClickHandler = ^{
            
            [self->_selectedPhotos removeObject:obj];
            [self->_selectedAssets removeObject:assets[idx]];
            [weakSelf removeFromSuperview];
        };
    }];
    if (self.returnImageBlock) {
        
        self.returnImageBlock(_selectedPhotos);
    }
    [self.imgLy addSubview:self.choosePictureBtn];
    
}
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    
     if ([albumName isEqualToString:@"视频"]) {
         return NO;
     }else{
         return YES;
     }
}
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    return YES;
}
@end
