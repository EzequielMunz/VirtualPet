//
//  PetTests.m
//  VirtualPet
//
//  Created by Ezequiel on 12/5/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Pet.h"
#import "MyPet.h"
#import "NetworkAccessObject.h"

@interface PetTests : XCTestCase

@end

@implementation PetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1EnergyGoesDown
{
    MyPet* pet = [MyPet sharedInstance];
    pet.petEnergy = 100;
    int energy = pet.petEnergy - 10; //Restamos 10 a la energy del Pet
    [pet doExcercise];
    XCTAssertTrue(energy == pet.petEnergy, @"No es igual papa");
}

- (void)test2ExperienceGoesUp
{
    MyPet* pet = [MyPet sharedInstance];
    int experience = [pet getActualExp] + 15; //Sumamos 15 a la experiencia del Pet
    [pet gainExperience];
    XCTAssertTrue(experience == [pet getActualExp], @"No es igual papa");
}

- (void)test3LevelUpKeepExperience
{
    MyPet* pet = [MyPet sharedInstance];
    pet.petActualExperience = 90;
    pet.petNeededExperience = 100;
    [pet gainExperience];
    
    XCTAssertTrue(pet.petActualExperience == 5, @"No es igual papa");
}

- (void)test4ServicePostWorking
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"test4ServicePostWorking"];
    
    NetworkAccessObject* dao = [[NetworkAccessObject alloc] init];
    [dao doPOSTPetUpdate:^(NSURLSessionDataTask* task, id responseObject){
    XCTAssertTrue([[responseObject objectForKey:@"status"] isEqualToString:@"ok"], @"No es igual papa");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError* error){
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            XCTFail(@"No se updateo papa");
        }
    }];
}

- (void)test5ServiceGetWorking
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"test5ServiceGetWorking"];
    
    NetworkAccessObject* dao = [[NetworkAccessObject alloc] init];
    [dao doGETPetInfo:^(NSURLSessionDataTask* task, id responseObject){
        NSString* code = [responseObject objectForKey:@"code"];
        XCTAssertTrue([code isEqualToString:@"em3896"], @"No es igual papa");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError* error){
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)test6ServiceGetListWorking
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"test6ServiceGetListWorking"];
    
    NetworkAccessObject* dao = [[NetworkAccessObject alloc] init];
    [dao doGETPetList:^(NSURLSessionDataTask* task, id responseObject){
       
        NSArray* array = (NSArray*)responseObject;
        XCTAssertTrue(array.count >= 1, @"No hay datos papa");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError* error){
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

@end
