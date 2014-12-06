//
//  ContactsViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 12/5/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactManager.h"

NSString* const MAIL_BODY_MESSAGE = @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!";
NSString* const MAIL_SUBJECT = @"Que app copada";

@interface ContactsViewController ()

@property (nonatomic, strong) MFMailComposeViewController* myMailView;
@property (strong, nonatomic) IBOutlet UITableView *contactTableView;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[ContactManager sharedInstance] getAuthorization];
    
    [self.contactTableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ContactCell"];
    [self.contactTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//********************************************
// Metodos del Data Source 
//********************************************

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell* newCell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    if(!newCell)
    {
        newCell = [[ContactCell alloc] initWithContact:[ContactManager sharedInstance].contactList[indexPath.row]];
    }
    
    [newCell fillWithContact: [ContactManager sharedInstance].contactList[indexPath.row]];
    [newCell setDelegate:self];
    
    return newCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ContactManager sharedInstance].contactList.count;
}

#pragma mark - E-Mail Methods
//********************************************
// Metodo para abrir la pantalla de MAIL
//********************************************
- (void) sendEMail: (NSString*) recipient
{
    NSString* mailBody = [NSString stringWithFormat:MAIL_BODY_MESSAGE, [MyPet sharedInstance].petName];
    NSString* mailSubject = MAIL_SUBJECT;
    self.myMailView = [[MFMailComposeViewController alloc] init];
    self.myMailView.mailComposeDelegate = self;
    [self.myMailView setSubject:mailSubject];
    [self.myMailView setToRecipients:[NSArray arrayWithObject:recipient]];
    [self.myMailView setMessageBody:mailBody isHTML:NO];
    [self.myMailView setTitle:@"EMAIL"];
    [self presentViewController:self.myMailView animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Messagge sent succesfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            break;
        case MFMailComposeResultCancelled:
            [[[UIAlertView alloc] initWithTitle:@"Cancelled" message:@"Mail has been cancelled" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            break;
        case MFMailComposeResultFailed:
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error sending the E-Mail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            break;
        case MFMailComposeResultSaved:
            [[[UIAlertView alloc] initWithTitle:@"Save" message:@"Messagge saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//********************************************
// Contact Protocol Methods
//********************************************

- (void) openMailComposer: (NSString*) toRecipient
{
    NSLog(@"Abrir Mail");
    [self sendEMail:toRecipient];
}

- (void) doACall: (NSString*) toPhone
{
    NSLog(@"Hacer LLamada");
    NSString *tel = [[toPhone componentsSeparatedByCharactersInSet:
                    [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                         componentsJoinedByString:@""];
    tel = [NSString stringWithFormat:@"tel://%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
        
}

@end
