//
//  USCSpeechUnderstander.h
//  nlu&asr
//
//  Created by yunzhisheng on 14-12-1.
//  Copyright (c) 2014年 usc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    USC_ASR_SERVICE_ADDRESS = 100,
    USC_NLU_URL = 1000
}USCSpeechUnderstanderProperty;

typedef enum
{
    RATE_8K = 8000,
    RATE_16K =16000,
    BANDWIDTH_AUTO,
}USCBankWidth;

@class USCScene,USCSpeechResult,USCSceneManage;

#pragma mark -
#pragma mark 代理
@protocol USCSpeechUnderstanderDelegate <NSObject>

/**
 *  检测到用户说话
 */
- (void)onSpeechStart;

/**
 *  录音开始回调
 */
- (void)onRecordingStart;

/**
 *  录音停止回调
 */
- (void)onRecordingStop:(NSData *)data;

/**
 *  识别开始回调
 */
- (void)onRecognizerStart;

/**
 *  vad 超时回调
 */
- (void)onVADTimeout;

/**
 *  识别结果回调
 *
 *  @param result 结果
 *  @param isLast 是否是最后一次
 */
- (void)onRecognizerResult:(NSString *)result isLast:(BOOL)isLast;

/**
 *  音量大小回调
 *
 *  @param volume 音量大小
 */
- (void)onUpdateVolume:(int)volume;

/**
 *  语义返回结果回调
 *
 *  @param result 结果
 */
- (void)onUnderstanderResult:(USCSpeechResult *)result;

/**
 *  整个过程结束回调
 *
 *  @param error error = nil 正常结束
 */
- (void)onEnd:(NSError *)error;

@end

#pragma mark -
#pragma mark 类
// @class - 语音理解类
// @brief - 语音识别和语义理解
@interface USCSpeechUnderstander : NSObject

@property (nonatomic,weak) id<USCSpeechUnderstanderDelegate> delegate;

/**
 *  初始化
 *
 *  @param context context
 *  @param appKey  appKey description
 *  @param secret  secret description
 */
- (id)initWithContext:(NSString *)context appKey:(NSString *)appKey secret:(NSString *)secret;

/**
 *  设置语义理解场景
 *
 *  @param scene 场景
 */
- (void)setNluScenario:(NSString *)scenario;

/**
 *  语义理解
 *
 *  @param text 要理解的内容
 */
- (void)textUnderstander:(NSString *)text;

/**
 *  设置vad超时时间，单位ms
 *
 *  @param frontTime ：开始说话之前的停顿超时时间，默认3000ms
 *  @param backTime  ：开始说话之后的停顿超时时间，默认1000ms
 */
- (void)setVadFrontTimeout:(int)frontTime BackTimeout:(int)backTime;

/**
 *
 *  上传个性化数据
 *
 *  @param userData 用户数据
 */
- (void)setUserData:(NSDictionary *)userData;

/**
 *
 *  获取session id
 *
 *  @return 当前识别会话ID
 */
- (NSString *)getSessionId;

/**
 *
 *  设置识别领域
 *
 *  @param engine 领域
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL)setEngine:(NSString *)engine;

/**
 *  设置语音
 *
 *  @param language 语音
 */
- (void)setLanguage:(NSString *)language;

/**
 *  设置别超时时间
 *
 *  @param recognizationTime 超时时间
 */
- (void)setRecognizationTimeout:(float)recognizationTime;

/**
 *  开始
 */
- (void)start;

/**
 *  停止录音；并开始等待识别结束
 */
- (void)stop;

/**
 * 取消识别
 */
- (void)cancel;

/**
 * 设置在线识别带宽
 *
 *  @param rate 录音采样率，支持参数BANDWIDTH_AUTO、RATE_8K、RATE_16K，默认为RATE_16K.
 RATE_16K
 */
- (void)setBandwidth:(int)rate;

/*!
 *
 *  @brief  设置标点符号
 *
 *  @param isEnable 是否开启
 */
- (void)setPunctuation:(BOOL)isEnable;

/*!
 *
 *  @brief  设置是否允许播放提示音
 *
 *  @param isAllowed 是否
 *
 */
-(void)setPlayingBeep:(BOOL)isAllowed;

/**
 *
 *  设置属性
 *
 *  @param property 属性value
 *  @param key      属性key
 */
- (void)setProperty:(NSString *)property forKey:(int)key;

/**
 *  获取当前sdk版本号
 *
 *  @return 版本号
 */
+ (NSString *)getVersion;

@end
