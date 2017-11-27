//
//  LoginVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/11.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "LoginVC.h"
#import "CLine.h"
#import "NSString+Extension.h"
#import "LoginModel.h"
#import "HNavigationBar.h"
#import "RegisterVC.h"

@interface LoginVC (){
    UITextField *txtPhone;
    UITextField *txtPassword;
}

@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(HNavigationBar*)self.navigationController.navigationBar setHidden:YES];
    [(HNavigationBar*)self.navigationController.navigationBar setTranslucent:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgBG=[[UIImageView alloc]init];
    imgBG.userInteractionEnabled=YES;
    imgBG.backgroundColor=[UIColor colorWithHexString:@"Fffbf6"];
    [self.view addSubview:imgBG];
    [imgBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //底部图片
    UIImageView *imgBottom=[[UIImageView alloc]init];
    imgBottom.image=[UIImage imageNamed:@"login_bg.png"];
    [self.view addSubview:imgBottom];
    [imgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.bottom.equalTo(self.view);
        make.height.mas_equalTo(kScreenWScale(114));
    }];
    
    //白色背景图片
    UIImageView *imgWhile=[[UIImageView alloc]init];
    imgWhile.image=[UIImage imageNamed:@"box_bg"];
    [self.view addSubview:imgWhile];
    [imgWhile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(kScreenHScale(520));
        make.height.mas_equalTo(210);
    }];
    
    //惠家
    UIImageView *imgTop=[[UIImageView alloc]init];
    imgTop.image=[UIImage imageNamed:@"login_logo"];
    [self.view addSubview:imgTop];
    [imgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
    }];
    
    txtPhone=[[UITextField alloc]init];
    txtPhone.placeholder=@"请输入手机号";
    txtPhone.font=[UIFont cFontWithSize:15];
    txtPhone.textColor=kTitleColor;
    [imgWhile addSubview:txtPhone];
    [txtPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgWhile).offset(45);
        make.centerX.equalTo(imgWhile);
        make.top.equalTo(imgWhile).offset(25);
        make.height.mas_equalTo(40);
    }];
    
    //横线
    CLine *lineshu1=[[CLine alloc]init];
    lineshu1.lineWidth=1;
    lineshu1.lineStyle=UILineStyleHorizon;
    [imgWhile addSubview:lineshu1];
    [lineshu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgWhile);
        make.left.equalTo(imgWhile).offset(25);
        make.top.equalTo(txtPhone.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    txtPassword=[[UITextField alloc]init];
    txtPassword.placeholder=@"请输入密码";
    txtPassword.font=[UIFont cFontWithSize:15];
    txtPassword.textColor=kTitleColor;
    [imgWhile addSubview:txtPassword];
    [txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgWhile).offset(45);
        make.centerX.equalTo(imgWhile);
        make.top.equalTo(lineshu1).offset(15);
        make.height.mas_equalTo(40);
    }];
    
    //横线
    CLine *lineshu2=[[CLine alloc]init];
    lineshu2.lineWidth=1;
    lineshu2.lineStyle=UILineStyleHorizon;
    [imgWhile addSubview:lineshu2];
    [lineshu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgWhile);
        make.left.equalTo(imgWhile).offset(25);
        make.top.equalTo(txtPassword.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    //登录按钮
    UIButton *btnLogin=[[UIButton alloc]init];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"btn_login_c.png"] forState:UIControlStateNormal];
//    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnLogin.titleLabel.font=[UIFont cFontWithSize:15];
    [self.view addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgWhile);
        make.centerY.equalTo(imgWhile.mas_bottom);
        make.left.equalTo(imgWhile).offset(35);
        make.height.mas_equalTo(60);
    }];

    txtPhone.text=@"thinkgem";
    txtPassword.text=@"admin";
}

//登录按钮
-(void)btnLoginClick{
    [self hideKeyBoard];
    if ([self showCheckErrorHUDWithTitle:@"" SubTitle:@"请输入手机号" checkTxtField:txtPhone]) {
        return ;
    }
   
    if ([self showCheckErrorHUDWithTitle:@"" SubTitle:@"请输入密码" checkTxtField:txtPassword]) {
        return ;
    }
    
    //1.设置请求参数
    [self showLoadingHUDWithTitle:@"正在登录" SubTitle:nil];
    NSDictionary *dict = @{@"username":txtPhone.text,
                           @"password":[SMTool getSercure:txtPassword.text],
                           @"IMEICODE":[SMTool getIMEICODE],
                           @"nowDate":[SMTool getNowTimeTimestamp]};
    //2.开始请求
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostRequestWithActionName:@"photo/login/login" andPramater:dict andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        [self hideLoadM];
        [self showErrorHUDWithTitle:@"服务器异常,请连续客服人员" SubTitle:nil Complete:nil];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        [self hideLoadM];
//        modelDetail=[ExpertAppointmentModel objectWithKeyValues:responseObject];
//        [self upDataView:modelDetail];
        NSLog(@"%@",responseObject);
        
        LoginModel *model=[LoginModel yy_modelWithJSON:responseObject];
        LoginResultModel *loginRe=model.results[0];
        if (![model.code isEqualToString:@"1"]) {
            [self showErrorHUDWithTitle:responseObject[@"errorMsg"] SubTitle:nil Complete:nil];
            return ;
        }
        
//        if ([loginRe.imeicode isEqualToString:[SMTool getIMEICODE]]&&loginRe.is_first_login.boolValue) {
//            [Global sharedInstance].model=model;
//            RegisterVC *vc=[[RegisterVC alloc]init];
//            vc.oldPass=txtPassword.text;
//            [self presentViewController:vc animated:YES completion:nil];
//            return ;
//        }
        
        [Global sharedInstance].model=model;
        [self dismissViewControllerAnimated:YES completion:nil];
    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        [self hideLoadM];
    }];
}




@end
