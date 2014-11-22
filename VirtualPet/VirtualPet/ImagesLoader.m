//
//  ImagesLoader.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "ImagesLoader.h"

@implementation ImagesLoader

- (void) loadPetComiendoArrayWithTag: (PetImageTag)tag
{
    NSArray* aux;
    switch (tag) {
        case PET_CIERVO:
            aux = @[@"ciervo_comiendo_1",@"ciervo_comiendo_2",@"ciervo_comiendo_3",@"ciervo_comiendo_4"];
            break;
        case PET_GATO:
            aux = @[@"gato_comiendo_1",@"gato_comiendo_2",@"gato_comiendo_3",@"gato_comiendo_4"];
            break;
        case PET_JIRAFA:
            aux = @[@"jirafa_comiendo_1",@"jirafa_comiendo_2",@"jirafa_comiendo_3",@"jirafa_comiendo_4"];
            break;
        case PET_LEON:
            aux = @[@"leon_comiendo_1",@"leon_comiendo_2",@"leon_comiendo_3",@"leon_comiendo_4"];
            break;
        default:
            break;
    }
    self.imgPetComiendo = [NSArray arrayWithArray:aux];
}

@end
