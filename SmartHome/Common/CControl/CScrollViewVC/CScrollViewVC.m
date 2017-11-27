//
//  CScrollViewVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "CScrollViewVC.h"

@interface CScrollViewVC ()

@end

@implementation CScrollViewVC
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView=[[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self.view);
    }];
    self.scrollView.alwaysBounceVertical=YES;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.scrollsToTop=YES;
    
    self.viewContent=[[UIView alloc] init];
    
    [self.scrollView addSubview:self.viewContent];
    [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        
    }];
    [self createView:self.viewContent];
    
    if (self.viewContent.subviews.count>0){
        [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.viewContent.subviews.lastObject).offset(10);
        }];
    }
}
- (void) createView:(UIView*)contentView
{
    
}

@end
