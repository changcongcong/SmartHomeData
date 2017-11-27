//
//  DoorOpenVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/21.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "DoorOpenVC.h"

@interface DoorOpenVC (){
    UIImageView *imgArrowOne;
    UIImageView *imgArrowTwo;
    UIImageView *imgArrowThree;
    BOOL canClick;
    CLabel *lblName;//用户名
    CLabel *lblPlace;//地点
}

@end

@implementation DoorOpenVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"开门";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblName=[[CLabel alloc]init];
    lblName.textColor=[UIColor colorWithHexString:@"333333"];
    lblName.font=[UIFont cFontWithSize:16];
    [self.view addSubview:lblName];
    [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
    }];
    
    lblPlace=[[CLabel alloc]init];
    lblPlace.textColor=[UIColor colorWithHexString:@"333333"];
    lblPlace.font=[UIFont cFontWithSize:11];
    [self.view addSubview:lblPlace];
    [lblPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lblName.mas_bottom).offset(10);
    }];

    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    lblName.text=[NSString stringWithFormat:@"Hi!%@",loginRe.name];//@"Hi!张三";
    lblPlace.text=loginRe.roomInfo;

    
    imgArrowOne=[[UIImageView alloc]init];
    imgArrowOne.image=[UIImage imageNamed:@"icon_door_circle3"];
    imgArrowOne.hidden=YES;
    [self.view addSubview:imgArrowOne];
    [imgArrowOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(kScreenW*250/370);
    }];
    
    imgArrowTwo=[[UIImageView alloc]init];
    imgArrowTwo.image=[UIImage imageNamed:@"icon_door_circle3"];
    imgArrowTwo.hidden=YES;
    [self.view addSubview:imgArrowTwo];
    [imgArrowTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(kScreenW*250/370);
    }];
    
    imgArrowThree=[[UIImageView alloc]init];
    imgArrowThree.image=[UIImage imageNamed:@"icon_door_circle3"];
    imgArrowThree.hidden=YES;
    [self.view addSubview:imgArrowThree];
    [imgArrowThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(kScreenW*250/370);
    }];
    
    UIButton *btnOpenDoor=[[UIButton alloc]init];
    [btnOpenDoor setImage:[UIImage imageNamed:@"icon_door_circle.png"] forState:UIControlStateNormal];
    [btnOpenDoor addTarget:self action:@selector(btnOpenDoorClick) forControlEvents:UIControlEventTouchUpInside];
    btnOpenDoor.adjustsImageWhenHighlighted=NO;
    [self.view addSubview:btnOpenDoor];
    [btnOpenDoor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(kScreenW*250/370);
    }];
    canClick=YES;
}

-(void)btnOpenDoorClick{
    if (!canClick) {
        return ;
    }
    canClick=NO;
    imgArrowOne.hidden=NO;
    imgArrowOne.transform = CGAffineTransformMakeScale(1, 1);
    
    imgArrowTwo.hidden=NO;
    imgArrowTwo.transform = CGAffineTransformMakeScale(1, 1);
    
    imgArrowThree.hidden=NO;
    imgArrowThree.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.8
                     animations:^{
                         imgArrowOne.transform = CGAffineTransformMakeScale(1.7, 1.7);
                     }completion:^(BOOL finish){
                         imgArrowOne.hidden=YES;
                     }];
    [self performSelector:@selector(delayMethodOne) withObject:nil/*可传任意类型参数*/ afterDelay:0.4];
    [self performSelector:@selector(delayMethodTwo) withObject:nil/*可传任意类型参数*/ afterDelay:0.8];

}

-(void)delayMethodOne{
    [UIView animateWithDuration:0.8
                     animations:^{
                         imgArrowTwo.transform = CGAffineTransformMakeScale(1.7, 1.7);
                     }completion:^(BOOL finish){
                         imgArrowTwo.hidden=YES;
                     }];
}

-(void)delayMethodTwo{
    [UIView animateWithDuration:0.8
                     animations:^{
                         imgArrowThree.transform = CGAffineTransformMakeScale(1.7, 1.7);
                     }completion:^(BOOL finish){
                         imgArrowThree.hidden=YES;
                         canClick=YES;
                     }];
}

@end
