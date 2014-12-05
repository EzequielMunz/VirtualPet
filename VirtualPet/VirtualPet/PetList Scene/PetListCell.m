//
//  PetListCell.m
//  VirtualPet
//
//  Created by Ezequiel on 11/29/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetListCell.h"
#import "MapViewController.h"


NSString* const URL_PATH = @"tamagotchi://Pet/";

@interface PetListCell()

@property (nonatomic, strong) Pet* myPet;

@end

@implementation PetListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPet:(Pet *)pet
{
    [self.petImageBtn setBackgroundImage:[UIImage imageNamed:pet.petImageName] forState:UIControlStateNormal];
    [self.petLevelLabel setText:[NSString stringWithFormat:@"%d", pet.petLevel]];
    [self.petNameLabel setText:pet.petName];
    
    if([pet.userID isEqualToString:@"em3896"])
    {
        [self setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [self setBackgroundColor:[UIColor colorWithRed:100 green:0 blue:0 alpha:0.2]];
    }
    
    self.myPet = pet;
}

- (IBAction)btnMapTouched:(id)sender
{
    [self.delegate goToMapWithLocation:self.myPet];
}

- (IBAction)btnImagePetTouched:(id)sender
{
    // Iniciar la URL
    NSString* fullPath = [NSString stringWithFormat:@"%@%@", URL_PATH, self.myPet.userID];
 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fullPath]];

}

@end
