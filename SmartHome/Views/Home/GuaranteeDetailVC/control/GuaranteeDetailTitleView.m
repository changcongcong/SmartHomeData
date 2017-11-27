//
//  GuaranteeDetailTitleView.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/18.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeDetailTitleView.h"

@implementation GuaranteeDetailTitleView{
    UILabel *lblTitle,*lblSubmit;
}

- (id) init
{
    if (self=[super init]){
        [self creatView];
    }
    return self;
}

-(void)creatView{
    lblTitle=[[UILabel alloc]init];
    lblTitle.textColor=[UIColor colorWithHexString:@"999999"];
    lblTitle.font=[UIFont cFontWithSize:15];
    [self addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
    }];
    
    lblSubmit=[[UILabel alloc]init];
    lblSubmit.textColor=[UIColor colorWithHexString:@"333333"];
    lblSubmit.font=[UIFont cFontWithSize:15];
    [self addSubview:lblSubmit];
    [lblSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20);
    }];
}

-(void)setTitle:(NSString *)title{
    lblTitle.text=title;
}

-(void)setSubmit:(NSString *)submit{
    lblSubmit.text=submit;
}

-(void)setSubmitcolor:(UIColor *)submitcolor{
    lblSubmit.textColor=submitcolor;
}

@end
