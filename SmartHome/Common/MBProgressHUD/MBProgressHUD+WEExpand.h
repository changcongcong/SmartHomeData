//
//  MBProgressHUD+WEExpand.h
//  waterelephantloan
//
//  Created by leo on 2017/8/29.
//  Copyright © 2017年 waterelephant. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WEExpand)
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

/**
 *  加载动态图 （按照需求传入 text,需要就传 努力加载中…，不需要则传 nil）
 *
 *  @param text 文本提示 (努力加载中…)
 *  @param view 没有特殊需求 传nil
 */
+ (void)showGiftWithMessage:(NSString *)text view:(UIView *)view;

/**
 *  展示弹出框信息
 */
+ (void)showMessage:(NSString *)message icon:(NSString *)icon supView:(UIView *)supView;

/**
 *  请求成功时的弹窗
 *
 *  @param success 成功文本
 */
+ (void)showSuccess:(NSString *)success;
/**
 *  请求失败时的弹窗
 *
 *  @param error 失败文本
 */
+ (void)showError:(NSString *)error;
/**
 *  弹窗消失
 */
+ (void)hideHUD;


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message view:(UIView *)view;

@end
