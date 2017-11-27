//
//  GuaranteeCell.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/17.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeCell.h"
#import "CLine.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Check.h"

@implementation GuaranteeCell{
    UILabel *lblLockTime;
    UILabel *lblTiele,*lblSubmit,*lblState,*lblZhiTime,*lblDoor;
    UIImageView *imgOne,*imgTwo,*imgThree;
    UIImageView *imgLock;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return self;
}

- (void) createView
{
    //竖着的线
    CLine *lineshu=[[CLine alloc]init];
    lineshu.lineWidth=1;
    lineshu.lineStyle=UILineStyleVertical;
    [self addSubview:lineshu];
    [lineshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1);
        make.left.equalTo(self).offset(23);
    }];
    
    //时钟图片
    UIImageView *imgLockTop=[[UIImageView alloc]init];
    imgLockTop.image=[UIImage imageNamed:@"icon_time_lock"];
    [self addSubview:imgLockTop];
    [imgLockTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lineshu);
        make.top.equalTo(self).offset(15);
    }];
    
    lblLockTime=[[UILabel alloc]init];
    lblLockTime.textColor=[UIColor colorWithHexString:@"b2b2b2"];
    lblLockTime.font=[UIFont cFontWithSize:11];
    [self addSubview:lblLockTime];
    [lblLockTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgLockTop);
        make.left.equalTo(imgLockTop.mas_right).offset(10);
    }];
    
    //白色背景
    UIImageView *viewWhileBG=[[UIImageView alloc]init];
    viewWhileBG.userInteractionEnabled=YES;
    viewWhileBG.image=[UIImage imageNamed:@"box_bg"];
    [self addSubview:viewWhileBG];
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(33);
        make.top.equalTo(self).offset(42);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];

    //标题
    lblTiele=[[UILabel alloc]init];
    lblTiele.textColor=[UIColor colorWithHexString:@"333333"];
    lblTiele.font=[UIFont cFontWithSize:17];
    [self addSubview:lblTiele];
    [lblTiele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(25);
        make.top.equalTo(viewWhileBG).offset(20);
    }];
    
    //副标题
    lblSubmit=[[UILabel alloc]init];
    lblSubmit.textColor=[UIColor colorWithHexString:@"999999"];
    lblSubmit.font=[UIFont cFontWithSize:13];
    [self addSubview:lblSubmit];
    [lblSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(25);
        make.top.equalTo(viewWhileBG).offset(50);
    }];
    
    //状态
    lblState=[[UILabel alloc]init];
    lblState.textColor=[UIColor colorWithHexString:@"fb3e3e"];
    lblState.font=[UIFont cFontWithSize:13];
    [self addSubview:lblState];
    [lblState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewWhileBG).offset(-25);
        make.top.equalTo(viewWhileBG).offset(20);
    }];
    
    //三张图片
    imgOne=[[UIImageView alloc]init];
    [self addSubview:imgOne];
    [imgOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(25);
        make.top.equalTo(lblSubmit.mas_bottom).offset(15);
        make.width.height.mas_equalTo((kScreenW-122)/3);
    }];
    
    imgTwo=[[UIImageView alloc]init];
    [self addSubview:imgTwo];
    [imgTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(35+(kScreenW-122)/3);
        make.top.equalTo(lblSubmit.mas_bottom).offset(15);
        make.width.height.mas_equalTo((kScreenW-122)/3);
    }];

    imgThree=[[UIImageView alloc]init];
    [self addSubview:imgThree];
    [imgThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(38+(kScreenW-122)/3*2);
        make.top.equalTo(lblSubmit.mas_bottom).offset(15);
        make.width.height.mas_equalTo((kScreenW-122)/3);
    }];
    
    //时钟图片
    imgLock=[[UIImageView alloc]init];
    imgLock.image=[UIImage imageNamed:@"icon_time_lock"];
    [viewWhileBG addSubview:imgLock];
    [imgLock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(25);
        make.bottom.equalTo(viewWhileBG).offset(-20);
    }];

    lblZhiTime=[[UILabel alloc]init];
    lblZhiTime.textColor=[UIColor colorWithHexString:@"666666"];
    lblZhiTime.font=[UIFont cFontWithSize:12];
    [viewWhileBG addSubview:lblZhiTime];
    [lblZhiTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgLock.mas_right).offset(10);
        make.centerY.equalTo(imgLock);
    }];
    
    lblDoor=[[UILabel alloc]init];

    lblDoor.textColor=[UIColor whiteColor];
    lblDoor.font=[UIFont cFontWithSize:10];
    lblDoor.layer.masksToBounds=YES;
    lblDoor.layer.cornerRadius=2;
    lblDoor.textAlignment=NSTextAlignmentCenter;
    lblDoor.backgroundColor=[UIColor colorWithHexString:@"f57f27"];
    [viewWhileBG addSubview:lblDoor];
    [lblDoor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblState);
        make.centerY.equalTo(imgLock);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(20);
    }];
}

-(void)setModel:(GuaranteeModel *)model{
    lblTiele.text=model.repair_project;
    lblLockTime.text=[SMTool timeWithTimeIntervalString:model.createDate];
    lblSubmit.text=model.desc; //repairTime
    imgLock.hidden=YES;
    if (![model.repairTime checkIsEmpty]) {
         lblZhiTime.text=[NSString stringWithFormat:@"维修时间 %@",[SMTool timeWithTimeIntervalString:model.repairTime]];
        imgLock.hidden=NO;
    }
    lblDoor.text=model.repair_type;
    lblState.text=model.status;
    
    imgOne.image=nil;
    imgTwo.image=nil;
    imgThree.image=nil;
    NSArray *imagePatch=[model.smallPathes componentsSeparatedByString:@","];
    
    for (NSInteger iNumber=0; iNumber<imagePatch.count; iNumber++) {
        if (iNumber==0) {
            [imgOne sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",imagePatch[iNumber]]]];
        }
        
        if (iNumber==1) {
            [imgTwo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",imagePatch[iNumber]]]];
        }
        
        if (iNumber==2) {
            [imgThree sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://t9601.bizduo.com/zflow2a_hzerp%@",imagePatch[iNumber]]]];
        }
    }
    
}

@end
