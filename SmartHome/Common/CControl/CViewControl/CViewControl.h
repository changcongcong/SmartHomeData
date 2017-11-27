//
//  CViewControl.h
//  SmartHome
//
//  Created by waterpant on 2017/11/6.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CViewControl : UIViewController
typedef enum{
    HNoDataModeDefault,
    HNoDataModeNoSearchResult,
    HNoDataModeNoCartData,
    HNoDataModeNoOrderData
}HNoDataMode;

- (void) showLoadingHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle;
- (void) showOkHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle Complete:(void(^)())complete;
- (void) showErrorHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle Complete:(void(^)())complete;


- (void) showOkHUDNotAutoHideWithTitle:(NSString*)title SubTitle:(NSString*)subTitle;
- (void) showErrorHUDNotAutoHideWithTitle:(NSString*)title SubTitle:(NSString*)subTitle;
- (void) hideKeyBoard;

- (BOOL) showCheckErrorHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle checkTxtField:(UITextField *)txt;

-(void)hideLoadM;

@end
