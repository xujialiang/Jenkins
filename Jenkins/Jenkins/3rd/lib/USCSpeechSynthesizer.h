//
//  USCOnlineTTS.h
//  tts_online_test2
//
//  Created by yunzhisheng-zy on 14-12-4.
//  Copyright (c) 2014年 usc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark 协议
@protocol USCSpeechSynthesizerDelegate <NSObject>

/**
 *  合成器启动
 */
- (void)synthesizerSpeechStart;

/**
 *  开始朗读回调
 */
- (void)synthesizerSpeechStartSpeaking;

/**
 *  合成取消回调,包括取消合成和取消播放
 */
- (void)synthesizerDidCanceled;

/**
 *  朗读暂停回调
 */
- (void)synthesizerSpeechDidPaused;

/**
 *  朗读恢复回调
 */
- (void)synthesizerSpeechDidResumed;

/**
 *  朗读结束回调
 */
- (void)synthesizerSpeechDidFinished;

/**
 *  TTS中间出错回调
 *
 *  @param error 错误对象
 */
- (void)synthesizerErrorOccurred:(NSError *)error;

@end

#pragma mark -
#pragma mark 类
// @class - 在线TTS类
// @brief - 在线把文字转语音
@interface USCSpeechSynthesizer : NSObject

@property (nonatomic,weak) id<USCSpeechSynthesizerDelegate> delegate;

/**
 *  初始化
 *
 *  @param appkey appkey
 *
 *  @return
 */
- (id)initWithAppkey:(NSString *)appkey;

/**
 *  开始合成
 *
 *  @param text 要合成的文字
 */
- (void)speaking:(NSString *)text;

/**
 *  立即停止播放和合成。
 */
- (void)cancelSpeaking;

/**
 *  暂停播放
 */
- (void)pauseSpeaking;

/**
 *  恢复播放
 */
- (void)resumeSpeaking;

- (void)setTTSAddress:(NSString *)address public:(BOOL)isPublic;

@end
