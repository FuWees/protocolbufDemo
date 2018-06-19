//
//  WPSocketManager.h
//  protocolbufDemo
//
//  Created by wupeng on 2018/6/19.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatMsg;   //自定义Protobuf模型类

@interface WPSocketManager : NSObject

+ (instancetype)manager;  //获取实例对象

@property (nonatomic, assign, readonly) BOOL isConnected; //IM通道是否连接中

/** 建立连接 */
- (void)connectCompletion:(void(^)(BOOL finish, NSError *error))completion;

/** 断开连接 */
- (void)disconnect;

/** 给服务端发送消息 */
- (void)sendMessage:(ChatMsg *)msg;

@end
