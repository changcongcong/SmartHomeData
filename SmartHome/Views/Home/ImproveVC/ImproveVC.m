//
//  ImproveVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/18.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "ImproveVC.h"
#import "LHRatingView.h"
#import "CLine.h"
#import "YYText.h"
#import "WETextView.h"

@interface ImproveVC (){
    LHRatingView * rView;
    WETextView *txtView;
}

@end

@implementation ImproveVC
@synthesize repairId;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"评价";
}

-(void)createView:(UIView *)contentView{
    UIView *viewWhileBG=[[UIView alloc]init];
    viewWhileBG.backgroundColor=[UIColor whiteColor];
//    viewWhileBG.layer.masksToBounds=YES;
    viewWhileBG.layer.cornerRadius=5;
    [contentView addSubview:viewWhileBG];
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.top.equalTo(contentView).offset(15);
    }];
    
    //服务评论
    UILabel *lblTitle=[[UILabel alloc]init];
    lblTitle.text=@"服务评价";
    lblTitle.textColor=[UIColor colorWithHexString:@"333333"];
    lblTitle.font=[UIFont cFontWithSize:16];
    [viewWhileBG addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.top.equalTo(viewWhileBG).offset(25);
    }];
    
    //点赞手指
    UIImageView *imgFiger=[[UIImageView alloc]init];
    imgFiger.image=[UIImage imageNamed:@"icon_improve_figer"];
    [viewWhileBG addSubview:imgFiger];
    [imgFiger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblTitle);
        make.right.equalTo(lblTitle.mas_left).offset(-10);
    }];
    
    rView = [[LHRatingView alloc]initWithFrame:CGRectMake(kScreenW/2-100, 50, 200, 35)];
        rView.ratingType = INTEGER_TYPE;//整颗星
    rView.score=5;
    [viewWhileBG addSubview:rView];
    
    CLine *lineshu1=[[CLine alloc]init];
    lineshu1.lineWidth=2;
    lineshu1.lineStyle=UILineStyleHorizon;
    lineshu1.lineColor=[UIColor colorWithHexString:@"ffc452"];
    [viewWhileBG addSubview:lineshu1];
    [lineshu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(90);
        make.top.equalTo(rView.mas_bottom).offset(20);
    }];
    
    //满意
    UILabel *lblSatisfied=[[UILabel alloc]init];
    lblSatisfied.text=@"满意";
    lblSatisfied.textAlignment=NSTextAlignmentCenter;
    lblSatisfied.backgroundColor=[UIColor whiteColor];
    lblSatisfied.textColor=[UIColor colorWithHexString:@"999999"];
    lblSatisfied.font=[UIFont cFontWithSize:11];
    [viewWhileBG addSubview:lblSatisfied];
    [lblSatisfied mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(lineshu1);
        make.width.mas_equalTo(40);
    }];
    
    CLine *lineshu2=[[CLine alloc]init];
    lineshu2.lineWidth=1;
    lineshu2.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineshu2];
    [lineshu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(1);
        make.left.equalTo(viewWhileBG).offset(15);
        make.top.equalTo(lblSatisfied.mas_bottom).offset(20);
    }];
    
    txtView=[[WETextView alloc]init];
    txtView.placeholderText=@"服务是否给力？写下您的意见吧~";
    txtView.placeholderFont=[UIFont cFontWithSize:14];
    txtView.placeholderTextColor=[UIColor colorWithHexString:@"cccccc"];
    txtView.font=[UIFont cFontWithSize:14];
    txtView.textColor=[UIColor colorWithHexString:@"333333"];
    [viewWhileBG addSubview:txtView];
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(lineshu2.mas_bottom).offset(20);
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(150);
    }];
    
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(txtView).offset(20);
    }];
    
    UIButton *btnImprove=[[UIButton alloc]init];
    [btnImprove setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnImprove setTitle:@"提交" forState:UIControlStateNormal];
    [btnImprove addTarget:self action:@selector(btnImproveClick) forControlEvents:UIControlEventTouchUpInside];
    [btnImprove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnImprove.titleLabel.font=[UIFont cFontWithSize:15];
    [contentView addSubview:btnImprove];
    [btnImprove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(viewWhileBG.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(20);
        make.height.mas_equalTo(40);
    }];
}

-(void)btnImproveClick{
    if ([self showCheckErrorHUDWithTitle:@"请输入评论" SubTitle:nil checkTxtField:txtView]) {
        return ;
    }
    
    HHttpRequest *request=[HHttpRequest new];
    [self showLoadingHUDWithTitle:@"正在获取信息..." SubTitle:nil];
    NSDictionary *dic=@{@"formId":@"28",
                        @"register":@{@"guarantee_id":repairId,
                                      @"score":[NSString stringWithFormat:@"%f",rView.score*2],
                                      @"evaluate":txtView.text
                                }};

    [request httpPostNoLoginRequestWithActionName:@"photo/form/saveFormDataJson"
                                    andJsonString:@"json"
                                   andPramater:dic
                          andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {//无数据或者数据错误
                              [self hideLoadM];
                          }
                     andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {//请求成功
                         [self hideLoadM];
                           [self.navigationController popViewControllerAnimated:YES];
                     }
                      andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {//请求失败
                          
                          [self hideLoadM];

                      }];
    
}
@end
