//
//  MRCFeedbackViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCFeedbackViewModel.h"

@interface MRCFeedbackViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *submitFeedbackCommand;

@end

@implementation MRCFeedbackViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Feedback";
    
    RACSignal *validSubmitSignal = [[[RACObserve(self, content)
        map:^(NSString *content) {
        	return [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }]
        map:^(NSString *content) {
            return @(content.length > 0);
        }]
        distinctUntilChanged];
    
    
       self.submitFeedbackCommand = [[RACCommand alloc] initWithEnabled:validSubmitSignal signalBlock:^(id input) {
                       [self.services popViewModelAnimated:YES];
           return [RACSignal empty];
            }];
    
    [self.submitFeedbackCommand.errors subscribe:self.errors];
}

@end
