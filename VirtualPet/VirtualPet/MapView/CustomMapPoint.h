//
//  CustomMapPoint.h
//  VirtualPet
//
//  Created by Ezequiel on 12/1/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Pet.h"

@interface CustomMapPoint : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly, copy) NSString *image;

-(instancetype) initWithPet: (Pet*) pet andAddress: (NSString*) address;
-(MKAnnotationView*) getAnnotationView;

@end
