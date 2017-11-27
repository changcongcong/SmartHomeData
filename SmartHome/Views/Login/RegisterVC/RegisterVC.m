//
//  RegisterVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/25.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "RegisterVC.h"
#import "CLine.h"
#import "NSString+Extension.h"
#import "LoginModel.h"
#import "HNavigationBar.h"

@interface RegisterVC (){
    UITextField *txtPhone;
    UITextField *txtPassword;
    UITextField *txtPasswordAgain;
}

@end

@implementation RegisterVC
@synthesize oldPass;

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
    imgWhile.userInteractionEnabled=YES;
    imgWhile.image=[UIImage imageNamed:@"box_bg"];
    imgWhile.layer.masksToBounds=YES;
    imgWhile.layer.cornerRadius=5;
    [self.view addSubview:imgWhile];
    [imgWhile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(kScreenHScale(520));
        make.height.mas_equalTo(250);
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
    
    txtPasswordAgain=[[UITextField alloc]init];
    txtPasswordAgain.placeholder=@"请再次输入密码";
    txtPasswordAgain.font=[UIFont cFontWithSize:15];
    txtPasswordAgain.textColor=kTitleColor;
    [imgWhile addSubview:txtPasswordAgain];
    [txtPasswordAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgWhile).offset(45);
        make.centerX.equalTo(imgWhile);
        make.top.equalTo(lineshu2).offset(15);
        make.height.mas_equalTo(40);
    }];

    
    //横线
    CLine *lineshu3=[[CLine alloc]init];
    lineshu3.lineWidth=1;
    lineshu3.lineStyle=UILineStyleHorizon;
    [imgWhile addSubview:lineshu3];
    [lineshu3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgWhile);
        make.left.equalTo(imgWhile).offset(25);
        make.top.equalTo(txtPasswordAgain.mas_bottom).offset(1);
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
        make.height.mas_equalTo(50);
    }];
    
    txtPhone.text=@"ios";//@"thinkgem";
    txtPassword.text=@"adminn";
    txtPasswordAgain.text=@"adminn";
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
    
    if ([self showCheckErrorHUDWithTitle:@"" SubTitle:@"请输入密码" checkTxtField:txtPasswordAgain]) {
        return ;
    }
    
    if (![txtPasswordAgain.text isEqualToString:txtPassword.text]) {
        [self showErrorHUDWithTitle:@"两次输入的密码不一致" SubTitle:nil Complete:nil];
        return;
    }
    
    //1.设置请求参数
    [self showLoadingHUDWithTitle:@"正在登录" SubTitle:nil];
    NSDictionary *dict = @{@"encodeOriginPwd":[SMTool getSercure:oldPass],
                           @"encodeNewPwd":[SMTool getSercure:txtPasswordAgain.text]};
    //2.开始请求
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostRegisterWithActionName:@"/photo/update/pwd" andPramater:dict andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        [self hideLoadM];
        [self showErrorHUDWithTitle:@"服务异常，请联系客服人员" SubTitle:nil Complete:nil];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        LoginModel *model=[LoginModel yy_modelWithJSON:responseObject];
        if (![model.code isEqualToString:@"1"]) {
            [self showErrorHUDWithTitle:responseObject[@"errorMsg"] SubTitle:nil Complete:nil];
            return ;
        }
        [self hideLoadM];
        [self dismissViewControllerAnimated:YES completion:nil];
    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        [self hideLoadM];
    }];
}



@end
