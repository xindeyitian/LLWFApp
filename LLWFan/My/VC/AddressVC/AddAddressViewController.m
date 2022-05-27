//
//  AddAddressViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/15.
//

#import "AddAddressViewController.h"
#import "AddressListViewController.h"
#import "PaySuccessViewController.h"

@interface AddAddressViewController ()<UITextViewDelegate>
{
    NSString *_provinceCode, *_provinceName, *_cityCode, *_cityName, *_areaCode, *_areaName;
}
@property (strong, nonatomic) UITextField *name, *phone;
@property (strong, nonatomic) UILabel *region;
@property (strong, nonatomic) UISwitch *defAddress;
@property (strong, nonatomic) UIButton    *saveBtn, *delBtn;
@property (strong, nonatomic) UITextView *addressTV, *address;

@end

@implementation AddAddressViewController
- (void)saveAddress{
    
    if (!self.name.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请填写收货人姓名" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!self.phone.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请填写收货人手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!_provinceName.length || !_provinceCode.length || !_cityName.length || !_cityCode.length || !_areaName.length || !_areaCode.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请填写收货人所在地区" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!self.address.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请填写收货人详细地址" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (self.addressModel) {
        
        [THHttpManager addressEditWithAddress:self.address.text AndAddressID:self.addressModel.addressID AndAreaCode:_areaCode AndAreaName:_areaName AndCityCode:_cityCode AndCityName:_cityName AndIfDefault:self.defAddress.on AndPhoneNum:self.phone.text AndProvinceCode:_provinceCode AndProvinceName:_provinceName AndRealName:self.name.text AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
           
            if (returnCode == 200) {
                
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"修改收货地址成功" AndType:success IsHideBg:NO AnddataBlock:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }else{
        
        [THHttpManager addressAddWithAddress:self.address.text AndAreaCode:_areaCode AndAreaName:_areaName AndCityCode:_cityCode AndCityName:_cityName AndIfDefault:self.defAddress.on AndPhoneNum:self.phone.text AndProvinceCode:_provinceCode AndProvinceName:_provinceName AndRealName:self.name.text AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"添加收货地址成功" AndType:success IsHideBg:NO AnddataBlock:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }
}
- (void)delAddress{
    
    [THHttpManager addressDeleteWithAddresswID:self.addressModel.addressID AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
       
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"删除收货地址成功" AndType:success IsHideBg:YES AnddataBlock:^{
                          
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
//    PaySuccessViewController *vc = [[PaySuccessViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)chooseRegion{
    
    BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
    pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        
        self.region.text = NSStringFormat(@"%@%@%@",province.name,city.name,area.name);
        self.region.textColor = color_3;
        self->_provinceCode = province.code;
        self->_provinceName = province.name;
        self->_cityCode = city.code;
        self->_cityName = city.name;
        self->_areaCode = area.code;
        self->_areaName = area.name;
    };
    [pickView show];
}
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView == self.addressTV) {
        
        BHAddressModel *model = [BHAddressParser bh_parserToAddressModelWithText:textView.text];
        self.name.text = model.name;
        self.phone.text = model.phone;
        self.region.text = NSStringFormat(@"%@%@%@", model.province, model.city, model.district);
        self.address.text = model.detailAddress;
//        [self.addressTV resignFirstResponder];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"收货地址"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 0;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:rootLy];
    
    MyLinearLayout *nameLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    nameLy.myHorzMargin = 0;
    nameLy.myHeight = 48;
    nameLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    nameLy.subviewHSpace = 12;
    nameLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:nameLy];
    //name布局
    MyBorderline *nameLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5 headIndent:12 tailIndent:12];
    nameLy.bottomBorderline = nameLine;
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    nameTitle.font = [UIFont systemFontOfSize:17];
    nameTitle.textColor = color_3;
    nameTitle.text = @"姓名";
    nameTitle.myWidth = 85;
    nameTitle.myHeight = 24;
    [nameLy addSubview:nameTitle];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectZero];
    self.name.textColor = color_3;
    self.name.placeholder = @"收货人姓名";
    self.name.font = [UIFont systemFontOfSize:17];
    self.name.weight = 1;
    self.name.myHeight = 24;
    [nameLy addSubview:self.name];
    //电话布局
    MyLinearLayout *phoneLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    phoneLy.myHorzMargin = 0;
    phoneLy.myHeight = 48;
    phoneLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    phoneLy.subviewHSpace = 12;
    phoneLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:phoneLy];
    
    MyBorderline *phoneLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5 headIndent:12 tailIndent:12];
    phoneLy.bottomBorderline = phoneLine;
    
    UILabel *phoneTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    phoneTitle.font = [UIFont systemFontOfSize:17];
    phoneTitle.textColor = color_3;
    phoneTitle.text = @"电话";
    phoneTitle.myWidth = 85;
    phoneTitle.myHeight = 24;
    [phoneLy addSubview:phoneTitle];
    
    self.phone = [[UITextField alloc] initWithFrame:CGRectZero];
    self.phone.textColor = color_3;
    self.phone.placeholder = @"收货人手机号";
    self.phone.font = [UIFont systemFontOfSize:17];
    self.phone.weight = 1;
    self.phone.myHeight = 24;
    [phoneLy addSubview:self.phone];
    //邮政编码布局
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseRegion)];
    
    MyLinearLayout *regionLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    regionLy.myHorzMargin = 0;
    regionLy.myHeight = 48;
    regionLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    regionLy.subviewHSpace = 12;
    regionLy.backgroundColor = UIColor.whiteColor;
    [regionLy addGestureRecognizer:tap];
    [rootLy addSubview:regionLy];

    MyBorderline *regionLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5 headIndent:12 tailIndent:12];
    regionLy.bottomBorderline = regionLine;

    UILabel *regionTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    regionTitle.font = [UIFont systemFontOfSize:17];
    regionTitle.textColor = color_3;
    regionTitle.text = @"所在地区";
    regionTitle.myWidth = 85;
    regionTitle.myHeight = 24;
    [regionLy addSubview:regionTitle];

    self.region = [[UILabel alloc] initWithFrame:CGRectZero];
    self.region.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    self.region.text = @"请选择地区";
    self.region.font = [UIFont systemFontOfSize:17];
    self.region.weight = 1;
    self.region.myHeight = 24;
    [regionLy addSubview:self.region];
    //地址布局
    MyLinearLayout *addressLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    addressLy.myHorzMargin = 0;
    addressLy.myHeight = MyLayoutSize.wrap;
    addressLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    addressLy.subviewHSpace = 12;
    addressLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:addressLy];
    
    MyBorderline *addressLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5 headIndent:12 tailIndent:12];
    addressLy.bottomBorderline = addressLine;
    
    UILabel *addressTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    addressTitle.font = [UIFont systemFontOfSize:17];
    addressTitle.textColor = color_3;
    addressTitle.text = @"详细地址";
    addressTitle.myWidth = 85;
    addressTitle.myHeight = 24;
    [addressLy addSubview:addressTitle];
    
    self.address = [[UITextView alloc] initWithFrame:CGRectZero];
    self.address.textColor = color_3;
    self.address.font = [UIFont systemFontOfSize:17];
    self.address.weight = 1;
    self.address.myHeight = 56;
    self.address.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [addressLy addSubview:self.address];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"街道门牌、楼层房间号等信息";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [placeHolderLabel sizeToFit];
    [self.address addSubview:placeHolderLabel];
       // same font
    placeHolderLabel.font = [UIFont systemFontOfSize:17];
    [self.address setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    MyLinearLayout *pasteboardLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    pasteboardLy.backgroundColor = UIColor.whiteColor;
    pasteboardLy.myHorzMargin = 0;
    pasteboardLy.myHeight = MyLayoutSize.wrap;
    pasteboardLy.gravity = MyGravity_Horz_Center;
    pasteboardLy.paddingBottom = 12;
    [rootLy addSubview:pasteboardLy];
    
    self.addressTV = [[UITextView alloc] initWithFrame:CGRectZero];
    self.addressTV.myHorzMargin = 12;
    self.addressTV.myHeight = 72;
    self.addressTV.myTop = 12;
    self.addressTV.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.addressTV.layer.cornerRadius = 4;
    self.addressTV.layer.masksToBounds = YES;
    self.addressTV.font = [UIFont systemFontOfSize:12];
    self.addressTV.textColor = color_3;
    self.addressTV.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12);
    self.addressTV.delegate = self;
    self.addressTV.returnKeyType = UIReturnKeyDone;
    [pasteboardLy addSubview:self.addressTV];
    
    UILabel *placeHolderLabel1 = [[UILabel alloc] init];
    placeHolderLabel1.text = @"试试粘贴收件人姓名、手机号、收货地址，可快速识别您的收货信息";
    placeHolderLabel1.numberOfLines = 0;
    placeHolderLabel1.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [placeHolderLabel1 sizeToFit];
    [self.addressTV addSubview:placeHolderLabel1];
       // same font
    placeHolderLabel1.font = [UIFont systemFontOfSize:12.f];
    [self.addressTV setValue:placeHolderLabel1 forKey:@"_placeholderLabel"];
    
    UILabel *paste = [[UILabel alloc] initWithFrame:CGRectZero];
    paste.text = @"地址粘贴板";
    paste.myWidth = paste.myHeight = MyLayoutSize.wrap;
    paste.textColor = color_6;
    paste.font = [UIFont systemFontOfSize:12];
    paste.myTop = 12;
    [pasteboardLy addSubview:paste];
    
    //默认地址布局
    MyLinearLayout *defAddressLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    defAddressLy.myHorzMargin = 0;
    defAddressLy.myHeight = 48;
    defAddressLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    defAddressLy.subviewHSpace = 12;
    defAddressLy.backgroundColor = UIColor.whiteColor;
    defAddressLy.myTop = 12;
    [rootLy addSubview:defAddressLy];
    
    UILabel *defAddressTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    defAddressTitle.font = [UIFont systemFontOfSize:17];
    defAddressTitle.textColor = color_3;
    defAddressTitle.text = @"设为默认收货地址";
    defAddressTitle.weight = 1;
    defAddressTitle.myHeight = 24;
    [defAddressLy addSubview:defAddressTitle];
    
    self.defAddress = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.defAddress.tintColor = [UIColor colorNamed:@"color-red"];
    self.defAddress.myWidth = self.defAddress.myHeight = MyLayoutSize.wrap;
    [defAddressLy addSubview:self.defAddress];
    
    self.saveBtn = [BaseButton CreateBaseButtonTitle:@"保存" Target:self Action:@selector(saveAddress) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:[UIColor colorWithHexString:@"#FFFFFF"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.saveBtn.myHorzMargin = 12;
    self.saveBtn.myHeight = 44;
    self.saveBtn.layer.cornerRadius = 22;
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.myTop = 72;
    [rootLy addSubview:self.saveBtn];
    
    self.delBtn = [BaseButton CreateBaseButtonTitle:@"删除" Target:self Action:@selector(delAddress) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.delBtn.myHorzMargin = 12;
    self.delBtn.myHeight = 44;
    self.delBtn.layer.cornerRadius = 22;
    self.delBtn.layer.masksToBounds = YES;
    self.delBtn.layer.borderColor = [UIColor colorWithHexString:@"#E5E5E5"].CGColor;
    self.delBtn.layer.borderWidth = 1;
    self.delBtn.myTop = 16;
    [rootLy addSubview:self.delBtn];
    
    if (self.addressModel) {
        
        self.name.text = self.addressModel.realName;
        self.phone.text = self.addressModel.phoneNum;
        self.region.text = NSStringFormat(@"%@%@%@",self.addressModel.provinceName,self.addressModel.cityName,self.addressModel.areaName);
        self.address.text = self.addressModel.address;
        _provinceCode = self.addressModel.provinceCode;
        _provinceName = self.addressModel.provinceName;
        _cityCode = self.addressModel.cityCode;
        _cityName = self.addressModel.cityName;
        _areaCode = self.addressModel.areaCode;
        _areaName = self.addressModel.areaName;
        self.defAddress.on = self.addressModel.ifDefault.integerValue;
    }
}
@end
