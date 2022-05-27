//
//  MoneyView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/18.
//

#import "MoneyView.h"
#import "MyEarningViewController.h"
#import "MyYangLaoViewController.h"
#import "WithDrawViewController.h"

@interface MoneyView()

@property (weak, nonatomic) IBOutlet UILabel *dyj;
@property (weak, nonatomic) IBOutlet UILabel *yue;
@property (weak, nonatomic) IBOutlet UILabel *gxz;
@property (weak, nonatomic) IBOutlet UILabel *llz;
@property (weak, nonatomic) IBOutlet UILabel *ylj;
@property (weak, nonatomic) IBOutlet UILabel *bhylj;


@end

@implementation MoneyView

- (void)setModel:(THUserWithDrawModel *)model{
    
    self.dyj.text = NSStringFormat(@"%ld",model.deducteValue);
    self.yue.text = NSStringFormat(@"%ld",model.balanceValue);
    self.gxz.text = NSStringFormat(@"%ld",model.contributeValue);
    self.llz.text = NSStringFormat(@"%ld",model.lotusValue);
    self.ylj.text = NSStringFormat(@"%ld",model.totalAnnuityMoney);
    self.bhylj.text = NSStringFormat(@"%ld",model.totalAnnuityWithdraw);
}
- (IBAction)btnCLicked:(UIButton *)sender {
    
    if (sender.tag == 0 || sender.tag == 2 || sender.tag == 3) {
        
        MyEarningViewController *vc = [[MyEarningViewController alloc] init];
        vc.navType = sender.tag;
        [self.currentViewController.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1){
        
        WithDrawViewController *vc = [[WithDrawViewController alloc] init];
        vc.withDrawType = 1;
        [self.currentViewController.navigationController pushViewController:vc animated:YES];
    }else{
        MyYangLaoViewController *vc = [[MyYangLaoViewController alloc] init];
        
        [self.currentViewController.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
