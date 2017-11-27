//
//  GuaranteeDetailVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/17.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeDetailVC.h"
#import "GuaranteeDetailHeadView.h"
#import "GuaranteeDetailTitleView.h"
#import "CLine.h"
#import "ImproveVC.h"
#import "YYText.h"
#import "WETextView.h"
#import "GuaranteeDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Check.h"
#import "LHRatingView.h"

@interface GuaranteeDetailVC (){
    GuaranteeDetailTitleView *viewRepairType;
    GuaranteeDetailTitleView *viewRepairLocation;
    GuaranteeDetailTitleView *viewRepairTime;
    GuaranteeDetailTitleView *viewRepairAssignTime;
    GuaranteeDetailTitleView *viewRepairLocation1;
    GuaranteeDetailTitleView *viewRepairAssignTime1;
    UILabel *lblLocation;
    UILabel *lblDetailReson;
    UIImageView *imgSelectOne,*imgSelectTwo,*imgSelectThree;
    WETextView *txtView;
    GuaranteeDetailModel *model;
    GuaranteeDetailHeadView *viewHead;
    UIButton *btnImprove;
    UIImageView *viewImprove;
    LHRatingView *rView;
}

@end

@implementation GuaranteeDetailVC
@synthesize repairId;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"报修详情";
    [self loadData];
}

-(void)loadData{
    HHttpRequest *request=[HHttpRequest new];
    [self showLoadingHUDWithTitle:@"正在获取信息..." SubTitle:nil];
    NSMutableArray *dic=[[NSMutableArray alloc] init];
    [dic addObject:@"R2016002"];
    [dic addObject:repairId];
    [request httpPostListRequestWithActionName:@"photo/data/procedure"
                                 andJsonString:@"p"
                                   andPramater:dic
                          andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {//无数据或者数据错误
                              [self hideLoadM];
                          }
                     andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {//请求成功
                         [self hideLoadM];
                         model=[GuaranteeDetailModel yy_modelWithJSON:responseObject];
                         
                         [self updateModel:responseObject];
                     }
                      andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {//请求失败

                          [self hideLoadM];
                      }];

}

-(void)createView:(UIView *)contentView{
    //报修进度
    UILabel *lblBaoxiuJindu=[[UILabel alloc]init];
    lblBaoxiuJindu.text=@"报修进度";
    lblBaoxiuJindu.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoxiuJindu.font=[UIFont cFontWithSize:13];
    [contentView addSubview:lblBaoxiuJindu];
    [lblBaoxiuJindu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(15);
    }];
    
    //状态
    viewHead=[[GuaranteeDetailHeadView alloc]init];
    [contentView addSubview:viewHead];
    [viewHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(50);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *viewWhileBG=[[UIImageView alloc]init];
    viewWhileBG.image=[UIImage imageNamed:@"box_bg"];
    [contentView addSubview:viewWhileBG];
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.top.equalTo(viewHead.mas_bottom).offset(20);
    }];
    
    //报修进度
    UILabel *lblBaoxiuJinduDetail=[[UILabel alloc]init];
    lblBaoxiuJinduDetail.text=@"报修详情";
    lblBaoxiuJinduDetail.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoxiuJinduDetail.font=[UIFont cFontWithSize:13];
    [viewWhileBG addSubview:lblBaoxiuJinduDetail];
    [lblBaoxiuJinduDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.top.equalTo(viewWhileBG).offset(25);
    }];
    
    UIImageView *imgLocation=[[UIImageView alloc]init];
    imgLocation.image=[UIImage imageNamed:@"icon_baoxiudetail_righttop"];
    [viewWhileBG addSubview:imgLocation];
    [imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWhileBG).offset((kScreenW-40)*34/(687+17));
        make.right.equalTo(viewWhileBG).offset(-(kScreenW-40)*17/(687+17));
    }];
    
    lblLocation=[[UILabel alloc]init];
    lblLocation.textColor=[UIColor whiteColor];
    lblLocation.font=[UIFont cFontWithSize:15];
    [imgLocation addSubview:lblLocation];
    [lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgLocation);
        make.centerX.equalTo(imgLocation).offset(5);
    }];
    
    //报修类型
    viewRepairType=[[GuaranteeDetailTitleView alloc]init];
    viewRepairType.title=@"报修类型";
    [viewWhileBG addSubview:viewRepairType];
    [viewRepairType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewWhileBG);
        make.top.equalTo(viewWhileBG).offset(50);
        make.height.mas_equalTo(45);
    }];
    
    //报修位置
    viewRepairLocation=[[GuaranteeDetailTitleView alloc]init];
    viewRepairLocation.title=@"报修位置";
    [viewWhileBG addSubview:viewRepairLocation];
    [viewRepairLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewWhileBG);
        make.top.equalTo(viewRepairType.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    //预约时间
    viewRepairAssignTime=[[GuaranteeDetailTitleView alloc]init];
    viewRepairAssignTime.title=@"预约时间";
    [viewWhileBG addSubview:viewRepairAssignTime];
    [viewRepairAssignTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewWhileBG);
        make.top.equalTo(viewRepairLocation.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    //竖着的线
    CLine *lineshu=[[CLine alloc]init];
    lineshu.lineWidth=1;
    lineshu.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineshu];
    [lineshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(1);
        make.left.equalTo(viewWhileBG).offset(15);
        make.top.equalTo(viewRepairAssignTime.mas_bottom).offset(10);
    }];
    
    lblDetailReson=[[UILabel alloc]init];
    lblDetailReson.numberOfLines=0;
    lblDetailReson.textColor=[UIColor colorWithHexString:@"333333"];
    lblDetailReson.font=[UIFont cFontWithSize:14];
    [viewWhileBG addSubview:lblDetailReson];
    [lblDetailReson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(lineshu).offset(20);
    }];
    
    imgSelectOne=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectOne];
    [imgSelectOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lblDetailReson.mas_bottom).offset(20);
    }];
    
    imgSelectTwo=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectTwo];
    [imgSelectTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(85);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lblDetailReson.mas_bottom).offset(20);
    }];
    
    imgSelectThree=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectThree];
    [imgSelectThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(150);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lblDetailReson.mas_bottom).offset(20);
    }];

    CLine *lineshu1=[[CLine alloc]init];
    lineshu1.lineWidth=1;
    lineshu1.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineshu1];
    [lineshu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(1);
        make.left.equalTo(viewWhileBG).offset(15);
        make.top.equalTo(imgSelectOne.mas_bottom).offset(20);
    }];
    
    //指派时间
    viewRepairTime=[[GuaranteeDetailTitleView alloc]init];
    viewRepairTime.title=@"派修时间";
    viewRepairTime.submitcolor=[UIColor colorWithHexString:@"2dde3d"];
    [viewWhileBG addSubview:viewRepairTime];
    [viewRepairTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewWhileBG);
        make.top.equalTo(lineshu1.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewRepairTime).offset(45);
    }];
    
    btnImprove=[[UIButton alloc]init];
    [btnImprove setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnImprove setTitle:@"去评价" forState:UIControlStateNormal];
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
    
    viewImprove=[[UIImageView alloc]init];
    viewImprove.image=[UIImage imageNamed:@"box_bg"];
    [contentView addSubview:viewImprove];
    [viewImprove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.top.equalTo(btnImprove.mas_bottom);
        make.height.mas_equalTo(200);
    }];
    
    //报修进度
    UILabel *lblCommentDetail=[[UILabel alloc]init];
    lblCommentDetail.text=@"评价详情";
    lblCommentDetail.textColor=[UIColor colorWithHexString:@"999999"];
    lblCommentDetail.font=[UIFont cFontWithSize:13];
    [viewImprove addSubview:lblCommentDetail];
    [lblCommentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewImprove);
        make.top.equalTo(viewImprove).offset(30);
    }];
    
    //报修类型
    GuaranteeDetailTitleView *viewRepairType1=[[GuaranteeDetailTitleView alloc]init];
    viewRepairType1.title=@"评分";
    [viewImprove addSubview:viewRepairType1];
    [viewRepairType1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewImprove);
        make.top.equalTo(viewImprove).offset(60);
        make.height.mas_equalTo(45);
    }];
    
    rView = [[LHRatingView alloc]initWithFrame:CGRectMake(kScreenW/2, 70, 60, 20)];
    rView.ratingType = INTEGER_TYPE;//整颗星
    [viewImprove addSubview:rView];

    //报修位置
    viewRepairLocation1=[[GuaranteeDetailTitleView alloc]init];
    viewRepairLocation1.title=@"描述";
    [viewImprove addSubview:viewRepairLocation1];
    [viewRepairLocation1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewImprove);
        make.top.equalTo(viewRepairType1.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    //预约时间
    viewRepairAssignTime1=[[GuaranteeDetailTitleView alloc]init];
    viewRepairAssignTime1.title=@"评论时间";
    [viewImprove addSubview:viewRepairAssignTime1];
    [viewRepairAssignTime1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewWhileBG);
        make.top.equalTo(viewRepairLocation1.mas_bottom);
        make.height.mas_equalTo(45);
    }];

    
}

-(void)updateModel:(NSDictionary *)dicParter{
    GuaranteeDetailDetailModel *modelDetail=model.results[0];
    viewHead.vaildState=modelDetail.statusVal;
    lblLocation.text=modelDetail.repair_type;
    viewRepairType.submit=modelDetail.repair_project;
    viewRepairLocation.submit=modelDetail.repair_position;
    viewRepairAssignTime.submit=modelDetail.repairTimes;
    lblDetailReson.text=[dicParter[@"results"][0]objectForKey:@"description"];//modelDetail.description;
    NSArray *arrayPath=[modelDetail.pathes componentsSeparatedByString:@","];
    viewRepairTime.submit=modelDetail.repairTime;
    viewRepairLocation1.submit=modelDetail.evaluate;
    viewRepairAssignTime1.submit=modelDetail.commentDate;
    rView.score=modelDetail.score.floatValue;
    if ([modelDetail.score checkIsEmpty]) {
        [viewImprove mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
        viewImprove.hidden=YES;
        [btnImprove mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        btnImprove.hidden=NO;
    }else{
        [viewImprove mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
        }];
        viewImprove.hidden=NO;
        [btnImprove mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
        btnImprove.hidden=YES;
    }
    
    for (NSInteger iNumber=0; iNumber<arrayPath.count; iNumber++) {
        if (iNumber==0) {
              [imgSelectOne sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",arrayPath[iNumber]]]];
        }
        
        if (iNumber==1) {
            [imgSelectTwo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",arrayPath[iNumber]]]];
        }
        
        if (iNumber==2) {
            [imgSelectThree sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",arrayPath[iNumber]]]];
        }
    }
}

-(void)btnImproveClick{
    ImproveVC *improve=[[ImproveVC alloc]init];
    improve.repairId=repairId;
    [self.navigationController pushViewController:improve animated:YES];
}

@end
