//
//  CustomMapPoint.m
//  VirtualPet
//
//  Created by Ezequiel on 12/1/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "CustomMapPoint.h"

@implementation CustomMapPoint

- (instancetype) initWithPet: (Pet*) pet{
    self = [super init];
    
    if(self)
    {
        self.coordinate = pet.location.coordinate;
        _title = pet.petName;
        _subtitle = [NSString stringWithFormat:@"Lvl %d", pet.petLevel];
        _image = pet.petImageName;
    }
    
    return self;
}

- (MKAnnotationView*) getAnnotationView
{
    MKAnnotationView* annotation = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"CustomMapPoint"];
    annotation.enabled = YES;
    annotation.canShowCallout = YES;
    
    UIImageView* myView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]];
    myView.frame = CGRectMake(0,0,40,40);
    
    annotation.leftCalloutAccessoryView = myView;

    annotation.image = [UIImage imageNamed:self.image];
    annotation.bounds = CGRectMake(0,0,40,40);
    
    return annotation;
}

@end
