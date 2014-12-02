//
//  ViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 12/1/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Pet.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPet: (Pet*)pet;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetArray: (NSArray*) petArray;

@end
