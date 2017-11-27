//
//  GuaranteeDetailHeadView.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/17.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeDetailHeadView.h"
#import "CLine.h"

@implementation GuaranteeDetailHeadView{
    UIImageView *imgOne,*imgTwo,*imgThree;
    CLine *lineOne,*lineTwo;
    UILabel *lblOne,*lblTwo,*lblThree;
}

- (id) init
{
    if (self=[super init]){
        [self creatView];
    }
    return self;
}

-(void)creatView{
    imgTwo=[[UIImageView alloc]init];
    imgTwo.image=[UIImage imageNamed:@"icon_grey_o"];
    [self addSubview:imgTwo];
    [imgTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    lblTwo=[[UILabel alloc]init];
    lblTwo.font=[UIFont cFontWithSize:10];
    lblTwo.text=@"派修";
    lblTwo.textColor=[UIColor colorWithHexString:@"cccccc"];
    [self addSubview:lblTwo];
    [lblTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imgTwo.mas_bottom).offset(5);
    }];
    
    lineOne=[[CLine alloc]init];
    lineOne.lineWidth=3;
    lineOne.lineStyle=UILineStyleHorizon;
    [self addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(imgTwo.mas_left).offset(-15);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(80);
    }];
    
    lineTwo=[[CLine alloc]init];
    lineTwo.lineWidth=3;
    lineTwo.lineStyle=UILineStyleHorizon;
    [self addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(imgTwo.mas_right).offset(15);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(80);
    }];
    
    imgOne=[[UIImageView alloc]init];
    imgOne.image=[UIImage imageNamed:@"icon_grey_o"];
    [self addSubview:imgOne];
    [imgOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(lineOne.mas_left).offset(-15);
    }];
    
    lblOne=[[UILabel alloc]init];
    lblOne.font=[UIFont cFontWithSize:10];
    lblOne.text=@"受理";
    lblOne.textColor=[UIColor colorWithHexString:@"cccccc"];
    [self addSubview:lblOne];
    [lblOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgOne);
        make.top.equalTo(imgOne.mas_bottom).offset(5);
    }];
    
    imgThree=[[UIImageView alloc]init];
    imgThree.image=[UIImage imageNamed:@"icon_grey_o"];
    [self addSubview:imgThree];
    [imgThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(lineTwo.mas_right).offset(15);
    }];
    
    lblThree=[[UILabel alloc]init];
    lblThree.text=@"已完成";
    lblThree.textColor=[UIColor colorWithHexString:@"cccccc"];
    lblThree.font=[UIFont cFontWithSize:10];
    [self addSubview:lblThree];
    [lblThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgThree);
        make.top.equalTo(imgThree.mas_bottom).offset(5);
    }];
}

-(void)setVaildState:(NSString *)vaildState{
    imgTwo.image=[UIImage imageNamed:@"icon_grey_o"];
    imgOne.image=[UIImage imageNamed:@"icon_grey_o"];
    imgThree.image=[UIImage imageNamed:@"icon_grey_o"];
    lblTwo.textColor=[UIColor colorWithHexString:@"cccccc"];
    lblOne.textColor=[UIColor colorWithHexString:@"cccccc"];
    lblThree.textColor=[UIColor colorWithHexString:@"cccccc"];
    lineOne.lineColor=[UIColor colorWithHexString:@"d5d5d5"];
    lineTwo.lineColor=[UIColor colorWithHexString:@"d5d5d5"];

    if ([vaildState isEqualToString:@"100"]) {
        //带受理
    }
    
    if ([vaildState isEqualToString:@"101"]) {
        //已受理 icon_green_ok
            imgOne.image=[UIImage imageNamed:@"icon_green_ok"];
            lblOne.textColor=[UIColor colorWithHexString:@"2fd13f"];
    }
    
    if ([vaildState isEqualToString:@"102"]) {
        //不受理
    }
    
    if ([vaildState isEqualToString:@"103"]) {
        //派修中
        imgOne.image=[UIImage imageNamed:@"icon_green_ok"];
        lblOne.textColor=[UIColor colorWithHexString:@"2fd13f"];
        imgTwo.image=[UIImage imageNamed:@"icon_green_ok"];
        lblTwo.textColor=[UIColor colorWithHexString:@"2fd13f"];
        lineOne.lineColor=[UIColor colorWithHexString:@"2fd13f"];
        
    }
    
    if ([vaildState isEqualToString:@"104"]) {
        //已完成
        imgOne.image=[UIImage imageNamed:@"icon_green_ok"];
        lblOne.textColor=[UIColor colorWithHexString:@"2fd13f"];
        imgTwo.image=[UIImage imageNamed:@"icon_green_ok"];
        lblTwo.textColor=[UIColor colorWithHexString:@"2fd13f"];
        lineOne.lineColor=[UIColor colorWithHexString:@"2fd13f"];
        imgThree.image=[UIImage imageNamed:@"icon_green_ok"];
        lblThree.textColor=[UIColor colorWithHexString:@"2fd13f"];
        lineTwo.lineColor=[UIColor colorWithHexString:@"2fd13f"];
    }
    [lineOne setNeedsDisplay];
    [lineTwo setNeedsDisplay];
    

}

@end
