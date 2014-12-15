//
//  FightViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 12/12/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface FightViewController : UIViewController <MCBrowserViewControllerDelegate, MCSessionDelegate>

@property (nonatomic, strong) CMMotionManager* motionManager;

//--------------- Multipeer -----------------

@property (nonatomic, strong) MCBrowserViewController *browserVC;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCPeerID *myPeerID;

@end
