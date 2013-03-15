//
//  AppDelegate.h
//  MKMapView
//
//  Created by zucknet on 13/3/14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)MapViewController *mapVc;

@end
