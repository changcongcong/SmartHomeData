//
//  CScrollViewVC.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "CViewControl.h"

@interface CScrollViewVC : CViewControl

@property(nonatomic,strong) UIView *viewContent;
@property(nonatomic,strong) UIScrollView *scrollView;
- (void) createView:(UIView*)contentView;

@end
