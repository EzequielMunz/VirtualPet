//
//  PetRanking.m
//  VirtualPet
//
//  Created by Ezequiel on 12/3/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetRanking.h"
#import "Pet.h"
#import "DataModelManager.h"

@interface PetRanking ()

@end

@implementation PetRanking

- (instancetype) init
{
    self = [super init];
    
    if(self)
    {
        self.petRankingArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

//****************************************************
// Ordenar Array
//****************************************************

- (void) sortArray
{
    self.petRankingSortedArray = [self.petRankingArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSNumber* level1 = [NSNumber numberWithInt:((Pet*)a).petLevel];
        NSNumber* level2 = [NSNumber numberWithInt:((Pet*)b).petLevel];
        
        return [level2 compare: level1];
    }];
}

//********************************************************
// Data Management
//********************************************************

- (void) fetchPetRankingData
{
    NSManagedObjectContext *context = [[DataModelManager sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest =[[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:context];
    
    [fetchRequest setFetchLimit:200];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"petLevel" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Pet* pet in fetchedObjects)
    {
        NSLog(@"Pet: %@", pet.petName);
    }
    
    if(!error)
    {
        self.petRankingArray = [NSMutableArray arrayWithArray:fetchedObjects];
        [self sortArray];
    }
}

- (void) insertPetRankingData
{
    NSManagedObjectContext *context = [[DataModelManager sharedInstance] managedObjectContext];

    //Guardamos los cambios en el contexto.
    
    for (Pet* pet in self.petRankingArray)
    {
        [[[DataModelManager sharedInstance] managedObjectContext] insertObject:pet];
    }
    
    NSError *localerror;
    if (![context save:&localerror])
    {
        NSLog(@"Error, couldn't save: %@", [localerror localizedDescription]);
        [context rollback];
    }
}

- (void) deletePetRankingData
{
    NSManagedObjectContext *context = [[DataModelManager sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSArray * pets = [context executeFetchRequest:fetchRequest error:&error];
    if(!error)
    {
        for (Pet * pet in pets)
        {
            [context deleteObject:pet];
        }
        
        NSError *saveError = nil;
        if (![context save:&saveError]) { //Guardamos los cambios en el contexto.
            NSLog(@"Error, couldn't delete: %@", [saveError localizedDescription]);
            [context rollback];
        }
    }
}


@end
