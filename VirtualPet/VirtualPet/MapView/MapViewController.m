//
//  ViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 12/1/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MapViewController.h"
#import "CustomMapPoint.h"


@interface MapViewController ()

@property (strong, nonatomic) Pet* myPet;

@end

@implementation MapViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPet: (Pet*) pet
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.myPet = pet;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//************************************************************
// Metodos del Delegate
//************************************************************

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    MKCoordinateRegion region;
    region.center = self.myPet.location.coordinate;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    
    // Seteamos el PIN
    CustomMapPoint* annotation = [[CustomMapPoint alloc] initWithPet:self.myPet];
    [mapView addAnnotation:annotation];
    
    [mapView setRegion:region animated:YES];
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[CustomMapPoint class]])
    {
        static NSString* identifier = @"CustomMapPoint";
        
        CustomMapPoint* customAnnotation = (CustomMapPoint*)annotation;
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(annotationView == nil)
        {
            annotationView = [customAnnotation getAnnotationView];
        }
        else{
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    else{
         return nil;
    }
}

@end
