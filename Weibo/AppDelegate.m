//
//  AppDelegate.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "AppDelegate.h"
#import "IFSTabBarController.h"
#import "IFSNewFeatureViewController.h"
#import "IFSWelcomeViewController.h"

#define BundleVersionKey @"CFBundleVersion"
#define UserDefaults [NSUserDefaults standardUserDefaults]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self chooseViewController];
    [self.window makeKeyAndVisible];
    
    [UITabBar appearance].tintColor = ThemeColor;
    [UITabBar appearance].translucent = NO;
    
    [UINavigationBar appearance].tintColor = ThemeColor;
    [UINavigationBar appearance].translucent = NO;
    
    return YES;
}

- (void)chooseViewController {
    if ([self newFeature]) {
        self.window.rootViewController = [[IFSNewFeatureViewController alloc] init];
    } else {
        if (SharedUser) {
            self.window.rootViewController = [[IFSWelcomeViewController alloc] init];
        } else {
            self.window.rootViewController = [[IFSTabBarController alloc] init];
        }
    }
}

- (BOOL)newFeature {
    CGFloat currentVersion = [[NSBundle mainBundle].infoDictionary[BundleVersionKey] doubleValue];
    CGFloat oldVersion = [UserDefaults doubleForKey:BundleVersionKey];
    if (currentVersion > oldVersion) {
        [UserDefaults setDouble:currentVersion forKey:BundleVersionKey];
        [UserDefaults synchronize];
        return YES;
    } else {
        return NO;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
