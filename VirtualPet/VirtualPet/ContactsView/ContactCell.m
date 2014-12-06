//
//  ContactCell.m
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "ContactCell.h"

@interface ContactCell ()
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblCompany;
@property (strong, nonatomic) IBOutlet UILabel *lblTelefono;
@property (strong, nonatomic) IBOutlet UILabel *lblEMail;


@end

@implementation ContactCell

- (instancetype) initWithContact:(Contact *)contact
{
    self = [super init];
    
    if(self)
    {
        self.myContact = contact;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnMailTouched:(id)sender
{
    [self.delegate openMailComposer:self.myContact.eMail];
}

- (IBAction)btnPhoneTouched:(id)sender
{
    [self.delegate doACall: self.myContact.phone];
}

- (void) fillWithContact: (Contact*) contact
{
    self.myContact = contact;
    
    [self.lblName setText:[NSString stringWithFormat:@"%@, %@", self.myContact.lastName, self.myContact.firstName]];
    [self.lblCompany setText:self.myContact.company];
    [self.lblTelefono setText:self.myContact.phone];
    [self.lblEMail setText:self.myContact.eMail];
}

@end
