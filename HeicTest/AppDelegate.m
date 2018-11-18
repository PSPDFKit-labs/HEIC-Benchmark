//
//  AppDelegate.m
//  HeicTest
//
//  Created by Aditya Krishnadevan on 15/11/2018.
//  Copyright © 2018 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HeicTest-Swift.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIViewController *vc;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.vc = [[ViewController alloc] init];
    //self.vc = [[HEICBenchmarkVC alloc] init];
    self.vc.view.backgroundColor = UIColor.yellowColor;
    self.window.rootViewController = self.vc;
    return YES;
}

@end
