//
//  HRequest.m
//  Car
//
//  Created by HeLiulin on 15/9/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "HHttpRequest.h"
#import "NSString+Extension.h"

#define boundary @"AaB03x"

@interface HHttpRequest ()<NSURLConnectionDataDelegate>

@property(nonatomic,copy) didDataErrorBlock dataErrorBlock;
@property(nonatomic,copy) didRequestSuccessBlock successBlock;
@property(nonatomic,copy) didRequestFailedBlock failedBlock;
@end

@implementation HHttpRequest

- (void) httpPostNormalWithActionName:(NSString*)actionName
                 andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
            andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
             andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock{
    // POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //创建异步连接（形式二）
    [request setHTTPMethod:@"POST"];
    //获取一个主队列
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      NSData * dataaa = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataaa options:NSJSONReadingMutableLeaves error:nil];
                                      NSLog(@"%@",jsonDict);
                                      NSLog(@"%@",response);
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          if (error) {
                                              if (failedBlock){
                                                  failedBlock(nil,error);
                                              }
                                              return ;
                                          }
                                          
                                          if (successBlock){
                                              successBlock(nil,jsonDict);
                                          }
                                      });
                                  }];
    [task resume];
}


- (void) httpPosImageRequestWithActionName:(NSString*)actionName
                               andPramater:(NSDictionary*)pramaters
                      andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
                 andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
                  andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock{
    
        NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
        NSString *accToken=loginRe.accesstoken;
    //    //创建url对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript,multipart/form-data", nil];
    //上传图片/文字，只能同POST
      NSString *bodyStr = [NSString stringWithFormat:@"accesstoken=%@&IMEICODE=%@&nowDate=%@",accToken,[SMTool getIMEICODE],[SMTool getNowTimeTimestamp]];
    [manager POST:urlString parameters:@{@"token":[SMTool getSercure:bodyStr]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
        for (UIImage *imgPic in pramaters[@"files"]) {
            NSData *imageData = [self compressOriginalImage:imgPic toMaxDataSizeKBytes:1000];//UIImagePNGRepresentation(imgPic);
            [formData appendPartWithFileData:imageData name:@"files" fileName:@"btn_login_c.png" mimeType:@"png"];
        }
        

        // [formData appendPartWithFormData:[@"wfWiEWrgEFA9A78512weF7106A" dataUsingEncoding:NSUTF8StringEncoding]

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"obj = %@",obj[@"error_msg"]);
        if ([obj.allKeys containsObject:@"code"]) {
            if (successBlock){
                successBlock(nil,obj);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock){
            failedBlock(nil,error);
        }
    }];
}
- (void) httpPostListRequestWithActionName:(NSString*)actionName
                             andJsonString:(NSString *)json
                               andPramater:(NSArray*)pramaters
                      andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
                 andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
                  andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock{
    // POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    //创建参数字符串对象
    NSString *parmStr1 = [self getstringwithArray:pramaters];
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    NSString *accToken=loginRe.accesstoken;
    NSString *bodyStr = [NSString stringWithFormat:@"accesstoken=%@&IMEICODE=%@&nowDate=%@",accToken,[SMTool getIMEICODE],[SMTool getNowTimeTimestamp]];
    NSLog(@"%@",[SMTool getSercure:bodyStr]);
    //    [request setValue:[NSString stringWithFormat:@"%@", [SMTool getSercure:bodyStr]] forHTTPHeaderField:@"token"];
    //    [request setValue:[NSString stringWithFormat:@"%@", parmStr1] forHTTPHeaderField:@"json"];
    NSString *sadasf=[NSString stringWithFormat:@"token=%@&%@=%@",[SMTool getSercure:bodyStr],json,parmStr1];
    //
    NSData *datae = [sadasf dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:datae];
    //创建异步连接（形式二）
    [request setHTTPMethod:@"POST"];
    //获取一个主队列
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      NSData * dataaa = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataaa options:NSJSONReadingMutableLeaves error:nil];
                                      NSLog(@"%@",jsonDict);
                                      NSLog(@"%@",response);
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          if (error) {
                                              if (failedBlock){
                                                  failedBlock(nil,error);
                                              }
                                          }
                                          
                                          if ([jsonDict.allKeys containsObject:@"code"]) {
                                              if (successBlock){
                                                  successBlock(nil,jsonDict);
                                              }
                                          }else{
                                              if (dataErrorBlock){
                                                  dataErrorBlock(nil,@"服务器异常,请连续客服人员");
                                              }
                                          }
                                      });
                                  }];
    
    [task resume];

}

- (void) httpPostNoLoginRequestWithActionName:(NSString*)actionName
                                andJsonString:(NSString *)json
                          andPramater:(NSDictionary*)pramaters
                 andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
            andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
             andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock
{
    
    // POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    //创建参数字符串对象
    NSString *parmStr1 = [self convertNologinToJSONData:pramaters];
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    NSString *accToken=loginRe.accesstoken;
    NSString *bodyStr = [NSString stringWithFormat:@"accesstoken=%@&IMEICODE=%@&nowDate=%@",accToken,[SMTool getIMEICODE],[SMTool getNowTimeTimestamp]];
    NSLog(@"%@",[SMTool getSercure:bodyStr]);
//    [request setValue:[NSString stringWithFormat:@"%@", [SMTool getSercure:bodyStr]] forHTTPHeaderField:@"token"];
//    [request setValue:[NSString stringWithFormat:@"%@", parmStr1] forHTTPHeaderField:@"json"];
    NSString *sadasf=[NSString stringWithFormat:@"token=%@&%@=%@",[SMTool getSercure:bodyStr],json,parmStr1];
//
    NSData *datae = [sadasf dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:datae];
    //创建异步连接（形式二）
    [request setHTTPMethod:@"POST"];
    //获取一个主队列
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      NSData * dataaa = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataaa options:NSJSONReadingMutableLeaves error:nil];
                                      NSLog(@"%@",jsonDict);
                                      NSLog(@"%@",response);
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          if (error) {
                                              if (failedBlock){
                                                  failedBlock(nil,error);
                                              }
                                          }
                                          
                                          if ([jsonDict.allKeys containsObject:@"code"]) {
                                              if (successBlock){
                                                  successBlock(nil,jsonDict);
                                              }
                                          }else{
                                              if (dataErrorBlock){
                                                  dataErrorBlock(nil,@"服务器异常,请连续客服人员");
                                              }
                                          }
                                      });
                                  }];
    
    [task resume];
}

- (void) httpPostRegisterWithActionName:(NSString*)actionName
                            andPramater:(NSDictionary*)pramaters
                   andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
              andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
               andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock{
    // POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    

    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    NSString *accToken=loginRe.accesstoken;
    NSString *bodyStr = [NSString stringWithFormat:@"accesstoken=%@&IMEICODE=%@&nowDate=%@",accToken,[SMTool getIMEICODE],[SMTool getNowTimeTimestamp]];
    
    
    NSString *sadasf=[NSString stringWithFormat:@"token=%@&encodeOriginPwd=%@&encodeNewPwd=%@",[SMTool getSercure:bodyStr],pramaters[@"encodeOriginPwd"],pramaters[@"encodeNewPwd"]];
    //
    NSData *datae = [sadasf dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:datae];
    
    //    NSArray *arrayKey=pramaters.allKeys;
    //
    //    for (NSString *keysa in arrayKey) {
    //        [request setValue:[NSString stringWithFormat:@"%@", pramaters[keysa]] forHTTPHeaderField:keysa];
    //    }
    //
    [request setHTTPMethod:@"POST"];
    //创建异步连接（形式二）
    //获取一个主队列
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      NSData * dataaa = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataaa options:NSJSONReadingMutableLeaves error:nil];
                                      NSLog(@"%@",jsonDict);
                                      NSLog(@"%@",response);
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          if (error) {
                                              if (failedBlock){
                                                  failedBlock(nil,error);
                                              }
                                          }
                                          
                                          if ([jsonDict.allKeys containsObject:@"code"]) {
                                                  if (successBlock){
                                                      successBlock(nil,jsonDict);
                                                  }
                                         
                                          }else{
                                             
                                          }
                                      });
                                  }];
    
    [task resume];
}

- (void) httpPostRequestWithActionName:(NSString*)actionName
                           andPramater:(NSDictionary*)pramaters
                  andDidDataErrorBlock:(didDataErrorBlock)dataErrorBlock
             andDidRequestSuccessBlock:(didRequestSuccessBlock)successBlock
              andDidRequestFailedBlock:(didRequestFailedBlock)failedBlock{
    
    // POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kUrlRoot,actionName];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    

    //创建参数字符串对象
    NSString *parmStr = [self convertToJSONData:pramaters];
//    if ([@"username=thinkgem&password=BGNJM&IMEICODE=7FD67166-F90C-4747-A1E5-90FD23107783&nowDate=1511070084000" isEqualToString:parmStr]) {
//        NSLog(@"成功");
//        return ;
//    } http://10.1.1.96:18080/zflow2a_hzerp/photo/form/saveFormDataJson
    
    //将字符串转换为NSData对象
    NSData *datae = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:datae];
    
//    NSArray *arrayKey=pramaters.allKeys;
//    
//    for (NSString *keysa in arrayKey) {
//        [request setValue:[NSString stringWithFormat:@"%@", pramaters[keysa]] forHTTPHeaderField:keysa];
//    }
//    
    [request setHTTPMethod:@"POST"];
    //创建异步连接（形式二）
    //获取一个主队列
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      NSData * dataaa = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataaa options:NSJSONReadingMutableLeaves error:nil];
                                      NSLog(@"%@",jsonDict);
                                      NSLog(@"%@",response);
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          if (error) {
                                              if (failedBlock){
                                                  failedBlock(nil,error);
                                              }
                                          }
                                          
                                          if ([jsonDict.allKeys containsObject:@"code"]) {
                                              if (successBlock){
                                                  successBlock(nil,jsonDict);
                                              }
                                          }else{
                                              if (dataErrorBlock){
                                                  dataErrorBlock(nil,@"服务器异常,请连续客服人员");
                                              }
                                          }
                                      });
                                  }];
    
    [task resume];
 }

- (NSString*)convertNologinToJSONData:(NSDictionary *)infoDict
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}


- (NSString*)convertToJSONData:(NSDictionary *)infoDict
{
    if (!infoDict) {
        return @"";
    }
    
    NSArray *arrayKey=infoDict.allKeys;
    NSMutableString *result=[[NSMutableString alloc]init];
    for (NSInteger iNumber=0; iNumber<arrayKey.count; iNumber++) {
        if (iNumber==0) {
            [result appendString:[NSString stringWithFormat:@"%@=%@",arrayKey[iNumber],infoDict[arrayKey[iNumber]]]];
        }else{
            [result appendString:[NSString stringWithFormat:@"&%@=%@",arrayKey[iNumber],infoDict[arrayKey[iNumber]]]];
        }
    }
    
    return result;
}

- (NSString*)getstringwithArray:(NSArray *)infoDict
{
    if (infoDict.count<1) {
        return @"";
    }
    
    NSMutableString *result=[[NSMutableString alloc]init];
    for (NSInteger iNumber=0; iNumber<infoDict.count; iNumber++) {
        if (iNumber==0) {
            result=[infoDict[iNumber] mutableCopy];
        }else{
            [result appendString:[NSString stringWithFormat:@"|%@",infoDict[iNumber]]];
        }
    }
    return result;
}

- (NSData *)setBodydata:(NSString *)filePath
{
    //把文件转换为NSData
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    //1.构造body string
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    
    //2.拼接body string
    //(1)access_token
    [bodyString appendFormat:@"--%@\r\n", boundary];
    [bodyString appendFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n"];
    [bodyString appendFormat:@"xxxxxx\r\n"];
    
    //(2)status
    [bodyString appendFormat:@"--%@\r\n", boundary];
    [bodyString appendFormat:@"Content-Disposition: form-data; name=\"status\"\r\n\r\n"];
    [bodyString appendFormat:@"带图片的微博\r\n"];
    
    //(3)pic
    [bodyString appendFormat:@"--%@\r\n", boundary];
    [bodyString appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"file\"\r\n"];
    [bodyString appendFormat:@"Content-Type: application/octet-stream\r\n\r\n"];
    
    
    //3.string --> data
    NSMutableData *bodyData = [NSMutableData data];
    //拼接的过程
    //前面的bodyString, 其他参数
    [bodyData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    //图片数据
    [bodyData appendData:fileData];
    
    //4.结束的分隔线
    NSString *endStr = [NSString stringWithFormat:@"\r\n--%@--\r\n",boundary];
    //拼接到bodyData最后面
    [bodyData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bodyData;
}


/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

@end
