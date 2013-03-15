//
//  MapViewController.m
//  MKMapView
//
//  Created by zucknet on 13/3/14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "MapViewController.h"
#import "MyMapAnnotation.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) ];
    mapView.delegate=self;
    [self.view addSubview:mapView];
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 31.22;
    theCoordinate.longitude= 121.47;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.15;
    theSpan.longitudeDelta=0.15;
    
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    
    [mapView setMapType:MKMapTypeStandard];
    [mapView setRegion:theRegion];
    
    [self addPoint];
    
}

-(void)addPoint{
    
    MyMapAnnotation* annot1 = [[MyMapAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = 31.2401;
	coor.longitude = 121.4902;
	annot1.coordinate = coor;
	annot1.title = @"外滩";
    
    MyMapAnnotation* annot2 = [[MyMapAnnotation alloc]init];
	CLLocationCoordinate2D coor1;
    coor1.latitude = 31.1957;
    coor1.longitude = 121.4368;
    annot2.coordinate = coor1;
    annot2.title = @"徐家汇";
    
    testArray = [[NSArray alloc]initWithObjects:annot1,annot2,nil];
    [mapView addAnnotations:testArray];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MyMapAnnotation class]]) {
        static NSString* travellerAnnotationIdentifier = @"TravellerAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:travellerAnnotationIdentifier];
        if (!pinView)
        {
            MKAnnotationView* customPinView = [[MKAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:travellerAnnotationIdentifier];
            customPinView.canShowCallout = YES;  //很重要，运行点击弹出标签
            customPinView.tag = -1;
            
            if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
                NSLog(@"系统低于iOS 6....");
            } else {
                
                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                [rightButton addTarget:self
                                action:@selector(showDetails)  //点击右边的按钮之后，显示另外一个页面
                      forControlEvents:UIControlEventTouchUpInside];
                customPinView.rightCalloutAccessoryView = rightButton;                
            }
            
            UIImage *image = [UIImage imageNamed:@"here"];
            customPinView.image = image;
            customPinView.opaque = YES;
            
            [customPinView setAutoresizesSubviews:YES];
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0){
    NSLog(@"选中我了，我是。。");
    CLLocationCoordinate2D corr = [view.annotation coordinate];
    coorToBeSend = corr;
    NSLog(@"%f",corr.longitude);
    NSLog(@"%f",corr.latitude);
}

-(void)showDetails{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"使用苹果自带地图导航",nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self SendAppleMap];
            break;
        default:
            break;
    }
}

-(void)SendAppleMap{
    CLLocationCoordinate2D to;
    //要去的目标经纬度
    to.latitude = coorToBeSend.latitude;
    to.longitude = coorToBeSend.longitude;
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];//调用自带地图（定位）
    //显示目的地坐标。画路线
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
    
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                   launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                  
                                                             forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

