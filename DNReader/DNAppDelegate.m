//
//  DNAppDelegate.m
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNAppDelegate.h"
#import "DNMasterViewController.h"
#ifdef TESTFLIGHT
#define NSLog TFLog
#endif

@implementation DNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
#ifdef TESTFLIGHT
	[TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
	[TestFlight takeOff:@"82256e4f-ca35-4930-a539-c4b0062bb8c1"];
#endif
	
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
	[[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
	[[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0.09 green:0.278 blue:0.69 alpha:1]];
	[[UIRefreshControl appearance]setTintColor:[UIColor colorWithRed:0.251 green:0.478 blue:0.82 alpha:1]];
	
//	[[UINavigationBar appearance] setTitleTextAttributes:
//	 [NSDictionary dictionaryWithObjectsAndKeys:
//	  [UIFont fontWithName:@"Helvetica" size:20], UITextAttributeFont,
//	  [UIColor blackColor], UITextAttributeTextColor,
//	  [UIColor whiteColor], UITextAttributeTextShadowColor,
//	  [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,nil]];
//	[[UINavigationBar appearance] setTitleVerticalPositionAdjustment:-0.5f forBarMetrics:UIBarMetricsDefault];
//
	
	
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

	DNMasterViewController *masterViewController = [[DNMasterViewController alloc] initWithNibName:@"DNMasterViewController" bundle:nil];
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
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
