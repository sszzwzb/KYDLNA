//
//  AppDelegate.m
//  KYDLNA
//
//  Created by kaiyi on 2021/3/15.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor ];
    [self.window makeKeyAndVisible];
    
    
    ViewController *AR = [[ViewController alloc]init];
    UINavigationController *NARVC = [[UINavigationController alloc]initWithRootViewController:AR];
    self.window.rootViewController = NARVC;
    
    
    return YES;
}


@end
