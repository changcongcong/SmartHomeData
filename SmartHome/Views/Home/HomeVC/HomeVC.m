//
//  HomeVC.m
//  SmartHome
//
//  Created by waterpant on 2017/11/6.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "HomeVC.h"
#import "CLine.h"
#import "homecontrolView.h"
#import "LoginVC.h"
#import "GuaranteeVC.h"
#import "DoorOpenVC.h"

@interface HomeVC (){
    CLabel *lblName;//用户名
    CLabel *lblPlace;//地点
}

@end

@implementation HomeVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.tabBarController.tabBar setHidden:NO];
    [self.tabBarController.tabBar setTranslucent:NO];
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    lblName.text=[NSString stringWithFormat:@"Hi!%@",loginRe.name];//@"Hi!张三";
    lblPlace.text=loginRe.roomInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //头部背景
    UIImageView *viewHead=[[UIImageView alloc]init];
    viewHead.userInteractionEnabled=YES;
    viewHead.image=[UIImage imageNamed:@"index_bg"];
    [self.view addSubview:viewHead];
    [viewHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    lblName=[[CLabel alloc]init];
    lblName.textColor=[UIColor whiteColor];
    lblName.font=[UIFont cFontWithSize:16];
    [viewHead addSubview:lblName];
    [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewHead);
        make.top.equalTo(viewHead).offset(30);
    }];
    
    lblPlace=[[CLabel alloc]init];
    lblPlace.textColor=[UIColor whiteColor];
    lblPlace.font=[UIFont cFontWithSize:11];
    [viewHead addSubview:lblPlace];
    [lblPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewHead);
        make.top.equalTo(lblName.mas_bottom).offset(10);
    }];
    
    UIImageView *viewBG=[[UIImageView alloc]init];
    viewBG.userInteractionEnabled=YES;
    viewBG.image=[UIImage imageNamed:@"index_wbox"];
    [self.view addSubview:viewBG];
    [viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(120);
    }];
    
    //竖着的线
    CLine *lineshu=[[CLine alloc]init];
    lineshu.lineWidth=1;
    lineshu.lineStyle=UILineStyleVertical;
    lineshu.lineColor=[UIColor clearColor];
    [viewBG addSubview:lineshu];
    [lineshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(viewBG);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(250);
    }];
    
    //横着的线
    CLine *lineheng=[[CLine alloc]init];
    lineheng.lineWidth=1;
    lineheng.lineColor=[UIColor clearColor];
    lineheng.lineStyle=UILineStyleHorizon;
    [viewBG addSubview:lineheng];
    [lineheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(viewBG);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(1);
    }];
    
    //智能开门
    homecontrolView *viewDoor=[[homecontrolView alloc]init];
    viewDoor.image=@"index_icon1";
    viewDoor.title=@"智能开门";
    [viewDoor setSelectBtnCilck:^{
        DoorOpenVC *open=[[DoorOpenVC alloc]init];
        [self.navigationController pushViewController:open animated:YES];
    }];
    [viewBG addSubview:viewDoor];
    [viewDoor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineshu);
        make.bottom.equalTo(lineheng.mas_top).offset(-2);
        make.left.equalTo(viewBG).offset(25);
        make.right.equalTo(lineshu).offset(-2);
    }];
    
    //我的合同
    homecontrolView *viewContract=[[homecontrolView alloc]init];
    viewContract.image=@"index_icon2";
    viewContract.title=@"我的合同";
    [viewBG addSubview:viewContract];
    [viewContract mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineshu);
        make.bottom.equalTo(lineheng.mas_top).offset(-2);
        make.right.equalTo(viewBG).offset(-25);
        make.left.equalTo(lineshu).offset(2);
    }];
    
    //我的账单
    homecontrolView *viewBill=[[homecontrolView alloc]init];
    viewBill.image=@"index_icon3";
    viewBill.title=@"我的账单";
    [viewBG addSubview:viewBill];
    [viewBill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineshu);
        make.top.equalTo(lineheng.mas_bottom).offset(40);
        make.left.equalTo(viewBG).offset(25);
        make.right.equalTo(lineshu).offset(-2);
    }];
    
    //我的保修
    homecontrolView *viewGuarantee=[[homecontrolView alloc]init];
    viewGuarantee.image=@"index_icon4";
    viewGuarantee.title=@"我的保修";
    [viewGuarantee setSelectBtnCilck:^{
        GuaranteeVC *vc=[[GuaranteeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [viewBG addSubview:viewGuarantee];
    [viewGuarantee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineshu);
        make.top.equalTo(lineheng.mas_bottom).offset(40);
        make.right.equalTo(viewBG).offset(-25);
        make.left.equalTo(lineshu).offset(2);
    }];
    
    LoginVC *vc=[[LoginVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
