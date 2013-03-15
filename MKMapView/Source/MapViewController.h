//
//  MapViewController.h
//  MKMapView
//
//  Created by zucknet on 13/3/14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class MyMapAnnotation;

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>{
    MKMapView *mapView;
    NSArray *testArray;
    CLLocationCoordinate2D coorToBeSend;
}

@property(nonatomic,strong)MKMapView *mapView;

@end