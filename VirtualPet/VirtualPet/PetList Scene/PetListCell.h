//
//  PetListCell.h
//  VirtualPet
//
//  Created by Ezequiel on 11/29/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@protocol MapProtocol <NSObject>

@required
- (void) goToMapWithLocation: (Pet*) pet;

@end

@interface PetListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UILabel *petNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *petLevelLabel;

@property (weak, nonatomic) id <MapProtocol> delegate;

- (void) setPet: (Pet*) pet;

@end
