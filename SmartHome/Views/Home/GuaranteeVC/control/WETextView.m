//
//  WETextView.m
//  SevenWallet
//
//  Created by waterpant on 2017/11/10.
//  Copyright © 2017年 waterelephant. All rights reserved.
//

#import "WETextView.h"
#import "WELineView.h"

@implementation WETextView

#pragma mark - 初始化 -
-(instancetype)init{
    
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 35)];
    view.backgroundColor=[UIColor whiteColor];
    self.inputAccessoryView = view;
    
    WELineView *line=[[WELineView alloc]init];
    line.lineDirection=LineStyleHorizontal;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    //确认按钮
    UIButton *btnSure=[[UIButton alloc]init];
    [btnSure setTitle:@"确认" forState:UIControlStateNormal];
    [btnSure setTitleColor:[UIColor colorWithHexString:@"2894FF"] forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(btnSureClick) forControlEvents:UIControlEventTouchUpInside];
    btnSure.titleLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:btnSure];
    [btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(view);
        make.width.mas_equalTo(80);
    }];
}

-(void)btnSureClick{
    [self resignFirstResponder];
}


@end
