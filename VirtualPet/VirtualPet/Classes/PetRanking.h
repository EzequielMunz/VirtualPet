//
//  PetRanking.h
//  VirtualPet
//
//  Created by Ezequiel on 12/3/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetRanking : NSObject

@property (nonatomic, strong) NSMutableArray* petRankingArray;
@property (nonatomic, strong) NSArray* petRankingSortedArray;

- (void) sortArray;

- (void) fetchPetRankingData;
- (void) insertPetRankingData;
- (void) deletePetRankingData;

@end
