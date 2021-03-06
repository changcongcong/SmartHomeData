//
//  HHttpRequest.h
//  Car
//
//  Created by HeLiulin on 15/9/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#define kUrlRoot @"http://t9601.bizduo.com/zflow2a_hzerp"
//#define kUrlRoot @"http://10.1.1.112:8080/zflow2a_hzerp"

typedef void(^didDataErrorBlock) (NSURLSessionTask *operation, id responseObject);
typedef void(^didRequestSuccessBlock) (NSURLSessionTask *operation, id responseObject);
typedef void(^didRequestFailedBlock) (NSURLSessionTask *operation, NSError *error);

@interface HHttpRequest : NSObject
///请求超时时间
@property(nonatomic,readwrite) CGFloat timeoutInterval;
@property(nonatomic,readwrite) BOOL acTop;

- (void) httpPostNormalWithActionName:(NSString*)actionName
                  andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
             andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
              andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;

- (void) httpPosImageRequestWithActionName:(NSString*)actionName
                                  andPramater:(NSDictionary*)pramaters
                         andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
                    andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
                     andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;

- (void) httpPostNoLoginRequestWithActionName:(NSString*)actionName
                                andJsonString:(NSString *)json
                           andPramater:(NSDictionary*)pramaters
                  andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
             andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
              andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;

- (void) httpPostListRequestWithActionName:(NSString*)actionName
                                andJsonString:(NSString *)json
                                  andPramater:(NSArray*)pramaters
                         andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
                    andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
                     andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;

- (void) httpPostRegisterWithActionName:(NSString*)actionName
                           andPramater:(NSDictionary*)pramaters
                  andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
             andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
              andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;


- (void) httpPostRequestWithActionName:(NSString*)actionName
                          andPramater:(NSDictionary*)pramaters
                 andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
            andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
             andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock;
@end
