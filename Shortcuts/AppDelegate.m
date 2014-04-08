//
//  AppDelegate.m
//  Shortcuts
//
//  Created by Ray Wenderlich on 9/25/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "ShortcutsDatabase.h"

@implementation AppDelegate

- (void)customizeAppearance
{
  // Set the background image for UINavigationBars
  UIImage *gradientImage44 = [[UIImage imageNamed:@"nav_white_44"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
  UIImage *gradientImage32 = [[UIImage imageNamed:@"nav_white_32"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
  
  [[UINavigationBar appearance] setBackgroundImage:gradientImage44
                     forBarMetrics:UIBarMetricsDefault];
  [[UINavigationBar appearance] setBackgroundImage:gradientImage32
                     forBarMetrics:UIBarMetricsLandscapePhone];
  
  // Set the background image for back buttons
  UIImage *buttonBackUns30 = [[UIImage imageNamed:@"button_back_uns_30"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 6)];
  [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBackUns30
                            forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  UIImage *buttonBackSel30 = [[UIImage imageNamed:@"button_back_sel_30"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 6)];
  [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBackSel30
                            forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
  
  UIImage *buttonBackUns24 = [[UIImage imageNamed:@"button_back_uns_24"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 6)];
  [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBackUns24
                            forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
  UIImage *buttonBackSel24 = [[UIImage imageNamed:@"button_back_sel_24"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 6)];
  [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBackSel24
                            forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
  
  // Set title text for bar buttons
  [[UIBarButtonItem appearance] setTitleTextAttributes:
   @{ UITextAttributeTextColor : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],
    UITextAttributeTextShadowColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5],
    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
    UITextAttributeFont: [UIFont fontWithName:@"Courier" size:0.0],
   } forState:UIControlStateNormal];

  [[UIBarButtonItem appearance] setTitleTextAttributes:
   @{ UITextAttributeTextColor : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],
    UITextAttributeTextShadowColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8],
    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
    UITextAttributeFont: [UIFont fontWithName:@"Courier" size:0.0],
   } forState:UIControlStateHighlighted];
  
  
  // Set title text for navigation bar
  [[UINavigationBar appearance] setTitleTextAttributes:
   @{ UITextAttributeTextColor : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],
    UITextAttributeTextShadowColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8],
    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
    UITextAttributeFont: [UIFont fontWithName:@"Courier" size:0.0],
   }];
  
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  ShortcutsDatabase * db = [ShortcutsDatabase sharedDatabase];
  NSLog(@"%@", db.shortcutsByMenu);
  NSLog(@"%@", db.shortcutsByKey);
  
  [self customizeAppearance];
  
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
