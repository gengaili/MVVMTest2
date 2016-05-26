//
//  MRCLoginViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewController.h"
#import "MRCLoginViewModel.h"
//#import "MRCHomepageViewController.h"
//#import "MRCHomepageViewModel.h"
//#import "IQKeyboardReturnKeyHandler.h"
//#import "TGRImageViewController.h"
//#import "TGRImageZoomAnimationController.h"
#import "MRCSettingsViewController.h"
#import "MRCSettingsViewModel.h"
@interface MRCLoginViewController () <UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UIButton *avatarButton;

@property (nonatomic, weak) IBOutlet UIImageView *usernameImageView;
@property (nonatomic, weak) IBOutlet UIImageView *passwordImageView;

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UIButton *browserLoginButton;

@property (nonatomic, strong, readonly) MRCLoginViewModel *viewModel;
//@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation MRCLoginViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
//
    self.avatarButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarButton.layer.borderWidth = 2.0f;

    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;

  
    //return 下面的
    @weakify(self)
    [[self
    	rac_signalForSelector:@selector(textFieldShouldReturn:)
        fromProtocol:@protocol(UITextFieldDelegate)]
    	subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            if (tuple.first == self.passwordTextField)
                [self.viewModel.loginCommand execute:nil];
        }];

    self.passwordTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//继承的
- (void)bindViewModel {
    [super bindViewModel];

    //头像
	@weakify(self)
    [RACObserve(self.viewModel, avatarURL) subscribeNext:^(NSURL *avatarURL) {
    	@strongify(self)
        [self.avatarButton sd_setImageWithURL:avatarURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default-avatar"]];
    }];

    //用户名和密码
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;

    //登录按钮
   
    //登录按钮是否可用
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;

    //点击登录按钮
    [[self.loginButton
        rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(id x) {
            @strongify(self)
            
       [self.viewModel.loginCommand execute:nil];
        }];

    self.browserLoginButton.rac_command = self.viewModel.browserLoginCommand;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
 
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  
   
    return nil;
}

@end
