//
//  MRCLoginViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewModel.h"
#import "MRCSettingsViewModel.h"
@interface MRCLoginViewModel ()

@property (nonatomic, copy, readwrite) NSURL *avatarURL;

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@property (nonatomic, strong, readwrite) RACCommand *browserLoginCommand;
@property (nonatomic, strong, readwrite) RACCommand *exchangeTokenCommand;

@end

@implementation MRCLoginViewModel

- (void)initialize {
    [super initialize];
    //头像
    
    //登录按钮信号
//    self.validLoginSignal = [[RACSignal
//    	combineLatest:@[ RACObserve(self, username), RACObserve(self, password) ]
//        reduce:^(NSString *username, NSString *password) {
//        	return @(username.length > 0 && password.length > 0);
//        }]
//        distinctUntilChanged];
    
    @weakify(self)
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^(id input){
        @strongify(self)
        MRCSettingsViewModel *settingViewModel = [[MRCSettingsViewModel alloc]initWithServices:self.services params:nil];
        [self.services pushViewModel:settingViewModel animated:YES];
        
        return  [RACSignal empty];
    }];
    
    
    
    }

- (void)setUsername:(NSString *)username {
    _username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
