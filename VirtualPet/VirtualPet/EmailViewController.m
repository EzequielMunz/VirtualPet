//
//  EmailViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/22/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "EmailViewController.h"
#define MAIL_MESSAGE_BODY @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!"
#define MAIL_SUBJECT @"Que app copada"

@interface EmailViewController ()

@end

@implementation EmailViewController

- (instancetype) initWithPetName:(NSString *)petName
{
    self = [super init];
    
    if(self)
    {
        self.petName = petName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sendMail:(id)sender
{
    self.myMailView = [[MFMailComposeViewController alloc] init];
    self.myMailView.mailComposeDelegate = self;
    [self.myMailView setSubject:MAIL_SUBJECT];
    [self.myMailView setMessageBody:[NSString stringWithFormat:MAIL_MESSAGE_BODY, self.petName] isHTML:NO];
    //[self presentViewController:self.myMailView animated:YES completion:nil];
}

#pragma mark - Mail Delegate Methods

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if(result)
    {
        
    }
    if(error)
    {
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
