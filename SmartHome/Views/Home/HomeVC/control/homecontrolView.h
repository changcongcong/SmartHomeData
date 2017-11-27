//
//  homecontrolView.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/11.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homecontrolView : UIView

@property(strong,nonatomic)NSString *title;

@property(strong,nonatomic)NSString *image;

@property (nonatomic, copy) void(^selectBtnCilck)();

@end
