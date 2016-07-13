//
//  PressButton.m
//  YueAi
//
//  Created by 郭洪军 on 7/13/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "PressButton.h"
#import <AVFoundation/AVFoundation.h>

@interface PressButton ()

@property (nonatomic, strong) UIView *recordAlertView;
@property (nonatomic, weak) UILabel  *cancelLabel;
@property (nonatomic, weak) UIImageView *recordImageView;
@property (nonatomic, weak) UIImageView *peakImageView;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSString *file;
@property (nonatomic, weak) NSTimer *timer;

@end


@implementation PressButton

- (instancetype)init
{
    if (self = [super init]) {
        [self setTitle:@"按住说话" forState:UIControlStateNormal];
        [self setTitle:@"松开结束" forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(pressTouchDown)      forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(pressTouchDragExit)  forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(pressTouchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(pressTouchUpInside)  forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(pressTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    }
    
    return self;
}

#pragma mark - button action
- (void)pressTouchDown {
    [self.window addSubview:self.recordAlertView];
    
    [self.recordAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.window);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    self.cancelLabel.text = @"手指上划，取消发送";
    self.recordImageView.image = [UIImage imageNamed:@"message_record"];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    self.file = [NSString stringWithFormat:@"Library/voice/%ld.wav", (NSInteger)interval];
    NSURL *url = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:self.file]];
    
    NSDictionary *recordSetting = @{AVSampleRateKey : @8000.0,
                                    AVLinearPCMBitDepthKey : @16,
                                    AVNumberOfChannelsKey : @1,
                                    AVFormatIDKey : @(kAudioFormatLinearPCM),
                                    AVEncoderAudioQualityKey : @(AVAudioQualityMedium)};
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    self.audioRecorder.meteringEnabled = YES;
    
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(recordTimerFire:) userInfo:@(interval) repeats:YES];
}

- (void)pressTouchDragExit {
    self.cancelLabel.text = @"松开手指，取消发送";
    self.recordImageView.image = [UIImage imageNamed:@"message_cancel"];
    self.peakImageView.image = nil;
}

- (void)pressTouchDragEnter {
    self.cancelLabel.text = @"手指上划，取消发送";
    self.recordImageView.image = [UIImage imageNamed:@"message_record"];
}

- (void)pressTouchUpInside {
    NSTimeInterval interval = 0;
    if ([self.timer isValid]) {
        interval = [[NSDate date] timeIntervalSince1970] - [self.timer.userInfo doubleValue];
        [self.timer invalidate];
    }
    
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
        
        if (interval > 1) {
            [self.recordAlertView removeFromSuperview];
            
            NSString *text = [NSString stringWithFormat:@"%ld\"+%@", (NSInteger)interval, self.file];
            self.sendVoice(text);
            
        } else {
            [self.audioRecorder deleteRecording];
            
            self.cancelLabel.text = @"说话时间太短";
            self.recordImageView.image = [UIImage imageNamed:@"message_tooshort"];
            self.peakImageView.image = nil;
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(alertTimerFire:) userInfo:nil repeats:NO];
        }
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)pressTouchUpOutside {
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
        [self.audioRecorder deleteRecording];
    }
    
    [self.recordAlertView removeFromSuperview];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

#pragma mark - timer fire
- (void)recordTimerFire:(NSTimer *)timer {
    [self.audioRecorder updateMeters];
    NSInteger lowPassResults = (NSInteger)(([self.audioRecorder peakPowerForChannel:0]+40)/5);
    
    if (lowPassResults < 2) {
        self.peakImageView.image = [UIImage imageNamed:@"peak1"];
    } else if (lowPassResults > 6) {
        self.peakImageView.image = [UIImage imageNamed:@"peak7"];
    } else {
        self.peakImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"peak%ld", lowPassResults]];
    }
}

- (void)alertTimerFire:(NSTimer *)timer {
    [timer invalidate];
    [self.recordAlertView removeFromSuperview];
}

#pragma mark - getter method
- (UIView *)recordAlertView {
    if (!_recordAlertView) {
        _recordAlertView = [[UIView alloc] init];
        _recordAlertView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _recordAlertView.layer.cornerRadius = 8;
        
        UILabel *cancelLabel = [[UILabel alloc] init];
        cancelLabel.font = [UIFont systemFontOfSize:15];
        cancelLabel.textColor = [UIColor whiteColor];
        [_recordAlertView addSubview:self.cancelLabel = cancelLabel];
        [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_recordAlertView);
            make.bottom.equalTo(_recordAlertView).offset(-5);
        }];
        
        UIImageView *recordImageView = [[UIImageView alloc] init];
        [_recordAlertView addSubview:self.recordImageView = recordImageView];
        [recordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_recordAlertView);
            make.left.equalTo(_recordAlertView).offset(25);
        }];
        
        UIImageView *peakImageView = [[UIImageView alloc] init];
        [_recordAlertView addSubview:self.peakImageView = peakImageView];
        [peakImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_recordAlertView);
            make.right.equalTo(_recordAlertView).offset(-25);
            make.left.equalTo(recordImageView.mas_right);
        }];
    }
    
    return _recordAlertView;
}


@end






















































