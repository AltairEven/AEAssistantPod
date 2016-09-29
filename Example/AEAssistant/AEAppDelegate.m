//
//  AEAppDelegate.m
//  AEAssistant
//
//  Created by qianye.qy on 09/20/2016.
//  Copyright (c) 2016 qianye.qy. All rights reserved.
//

#import "AEAppDelegate.h"
#import <AEAssistant/AEAssistant_Network.h>

@interface AEAppDelegate ()

@property (nonatomic, strong) AEHttpRequestHandler *request;

@end

@implementation AEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    self.request = [[AEHttpRequestHandler alloc] initWithUrlString:@"https://api-testesports.alisports.com/v1/setting"];
    self.request = [[AEHttpRequestHandler alloc] initWithUrlString:@"http://www.51zzl.com/images/xxyl/xingge.jpg"];
    AEHttpRequestConfiguration *config = [AEHttpRequestConfiguration defaultConfiguration];
    [config setDisplayDebugInfo:YES];
    [self.request setRequestConfiguration:config];
    [[AEHttpCookieManager sharedManager] setCookieDomain:@"alisports.com"];
    [[AEHttpCookieManager sharedManager] setIcsonCookieWithName:@"TestCookieName" andValue:@"TestCookieValue"];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
