//
//  homecontrolView.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/11.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "homecontrolView.h"

@implementation homecontrolView{
    UIImageView *imgTitle;
    UILabel *lblTitle;
}

- (id) init
{
    if (self=[super init]){
        [self defaultInit];
    }
    return self;
}

- (void) defaultInit
{
    //头部图片
    imgTitle=[[UIImageView alloc]init];
    [self addSubview:imgTitle];
    [imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    lblTitle=[[UILabel alloc]init];
    lblTitle.font=[UIFont cFontWithSize:12];
    lblTitle.textColor=kTitleColor;
    [self addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imgTitle.mas_bottom).offset(25);
    }];
    
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapSelf=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapselfClick)];
    [self addGestureRecognizer:tapSelf];
}

-(void)tapselfClick{
    if (self.selectBtnCilck) {
        self.selectBtnCilck();
    }
}

-(void)setImage:(NSString *)image{
    imgTitle.image=[UIImage imageNamed:image];
}

-(void)setTitle:(NSString *)title{
    lblTitle.text=title;
}

@end
