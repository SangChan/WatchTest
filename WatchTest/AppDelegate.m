//
//  AppDelegate.m
//  WatchTest
//
//  Created by SangChan on 2015. 5. 6..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLabel" object:nil userInfo:userInfo];
    int randomNumber = [[userInfo objectForKey:@"randomNumber"]intValue];
    for (int i = randomNumber; i > 1; i--) {
        if([self isPrime:i]) {
            reply(@{@"primeNumber":[NSString stringWithFormat:@"%d",i]});
            return ;
        }
    }
    reply(@{@"primeNumber":@"2"});
}


-(BOOL)isPrime:(int)num
{
    if(num <= 1) return NO;
    if(num == 2) return YES;
    
    for (int i = 2; i <= num/2; i++)
    {
        if(num%i == 0) return NO;
    }
    return YES;
}

@end
