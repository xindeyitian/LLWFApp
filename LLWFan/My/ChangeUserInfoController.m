//
//  ChangeUserInfoController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "ChangeUserInfoController.h"
#import "UserInfoCell.h"
#import "UserPswCell.h"
#import "UserAccountCell.h"
#import "ChangeInfoHeaderView.h"
#import "ChangeInfoFooterView.h"

@interface ChangeUserInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTable;
@property (strong, nonatomic) NSArray     *titleArr;
@property (strong, nonatomic) UIButton *chooseImgBtn;

@end

@implementation ChangeUserInfoController
- (void)logOut{
    
    [THUserManager logOut];
}
- (void)changeUserImg:(UIButton *)sender{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
     if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
         [[AllNoticePopUtility shareInstance] popViewWithTitle:@"此应用未授权相册，请去设置-隐私打开" AndType:warning IsHideBg:YES  AnddataBlock:^{
                      
         }];
            return;
     }
    
    [[UpLoadUserpicTool shareManager] selectUserpicSourceWithViewController:[THAPPService shareAppService].currentViewController SourceType:SourceTypeAll FinishSelectImageBlcok:^(UIImage *image) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [THHttpManager getUpTokenAndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [THHttpManager dealDataWithToken:[data objectForKey:@"token"] Images:@[image] AndTitle:@"user/avator" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                    
                    if (returnCode == 200) {
                        NSMutableArray *imgList = (NSMutableArray *)data;
                        [THHttpManager changeAvatarWithAvatar:imgList[0] AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                            
                            if (returnCode == 200) {
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"更换成功" AndType:success IsHideBg:YES AnddataBlock:nil];
                                [self.chooseImgBtn setImage:image forState:UIControlStateNormal];
                            }else{
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                            }
                        }];
                    }else{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }
                }];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"设置"];
    self.infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped];
    self.infoTable.delegate = self;
    self.infoTable.dataSource = self;
    self.infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoTable.showsVerticalScrollIndicator = NO;
    self.infoTable.backgroundColor = color_f5;
    [self.view addSubview:self.infoTable];
    
    [self.infoTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.infoTable registerClass:[UserInfoCell class] forCellReuseIdentifier:@"UserInfoCell"];
    [self.infoTable registerClass:[UserPswCell class] forCellReuseIdentifier:@"UserPswCell"];
    [self.infoTable registerClass:[UserAccountCell class] forCellReuseIdentifier:@"UserAccountCell"];
    [self.infoTable registerClass:[ChangeInfoHeaderView class] forHeaderFooterViewReuseIdentifier:@"ChangeInfoHeaderView"];
    [self.infoTable registerClass:[ChangeInfoFooterView class] forHeaderFooterViewReuseIdentifier:@"ChangeInfoFooterView"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MyLinearLayout *chooseHeaderImgLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        chooseHeaderImgLy.myHorzMargin = 0;
        chooseHeaderImgLy.myHeight = 170;
        chooseHeaderImgLy.gravity = MyGravity_Horz_Center;
        chooseHeaderImgLy.paddingTop = 34;
        [cell.contentView addSubview:chooseHeaderImgLy];
        
        self.chooseImgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        self.chooseImgBtn.myWidth = 100;
        self.chooseImgBtn.myHeight = 100;
        ViewBorderRadius(self.chooseImgBtn, 50, 1, UIColor.whiteColor);
        [self.chooseImgBtn sd_setImageWithURL:[NSURL URLWithString:THUserManagerShareTHUserManager.userModel.avatar] forState:UIControlStateNormal];
        [self.chooseImgBtn addTarget:self action:@selector(changeUserImg:) forControlEvents:UIControlEventTouchUpInside];
        [chooseHeaderImgLy addSubview:self.chooseImgBtn];
        
        UILabel *lable = [BaseLabel CreateBaseLabelStr:@"点击修改头像" Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
        lable.myWidth = lable.myHeight = MyLayoutSize.wrap;
        lable.myTop = 5;
        [chooseHeaderImgLy addSubview:lable];
        
        return cell;
    }else if (indexPath.section == 1) {
        
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        
        return cell;
    }else if (indexPath.section == 2){
        
        UserPswCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPswCell"];
        
        return cell;
    }else if(indexPath.section == 3){
        
        UserAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserAccountCell"];
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.backgroundColor = UIColor.clearColor;
        
        UIButton *logOut = [BaseButton CreateBaseButtonTitle:@"退出登录" Target:self Action:@selector(logOut) Font:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"] Color:color_6 Frame:CGRectMake(12, 8, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:0];
        ViewBorderRadius(logOut, 25, 1, color_9);
        [cell.contentView addSubview:logOut];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        return 175;
    }else if (indexPath.section == 4){
        
        return 70;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        
        return 24;
    }else{
        
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        
        ChangeInfoFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ChangeInfoFooterView"];
        return footer;
    }else{
        
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        
        return 12;
    }else{
        
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        
        ChangeInfoHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ChangeInfoHeaderView"];
        return header;
    }else{
        
        return [UIView new];
    }
}
@end
