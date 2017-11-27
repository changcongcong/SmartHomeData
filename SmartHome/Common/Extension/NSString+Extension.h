//
//  NSStringEx.h
//  WeAct
//
//  Created by by Heliulin on 15/3/26.
//  Copyright (c) 2015年 上海翔汇网络技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) moneyFormat;
-(BOOL)isBlankString;
- (CGSize) sizeWithFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;
@end
