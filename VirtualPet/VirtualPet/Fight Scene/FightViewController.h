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

@interface FightViewController : UIViewController <MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate>

@property (nonatomic, strong) CMMotionManager* motionManager;

//--------------- Multipeer -----------------

@property (nonatomic, strong) MCBrowserViewController *browserVC;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCPeerID *myPeerID;

@property (strong, nonatomic) IBOutlet UIButton *browserButton;
@property (strong, nonatomic) IBOutlet UITextView *textBox;
@property (strong, nonatomic) IBOutlet UITextField *chatBox;
@property (strong, nonatomic) IBOutlet UIImageView *imgEnemy;
@property (strong, nonatomic) IBOutlet UIImageView *imgMine;
@property (strong, nonatomic) IBOutlet UILabel *nameEnemy;
@property (strong, nonatomic) IBOutlet UILabel *nameMine;
@property (strong, nonatomic) IBOutlet UILabel *healthEnemy;
@property (strong, nonatomic) IBOutlet UILabel *healthMine;
@property (strong, nonatomic) IBOutlet UIImageView *imgHitMine;
@property (strong, nonatomic) IBOutlet UIImageView *imgHitEnemy;

@end
