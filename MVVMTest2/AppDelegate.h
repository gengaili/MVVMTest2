//
//  AppDelegate.h
//  MVVMTest2
//
//  Created by LG on 16/5/26.
//  Copyright © 2016年 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCNavigationControllerStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) MRCNavigationControllerStack *navigationControllerStack;

@end

