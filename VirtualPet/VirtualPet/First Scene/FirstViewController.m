//
//  FirstViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "FirstViewController.h"
#import "SelectImgViewController.h"
#import "MyPet.h"

@interface FirstViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtPetName;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:@"Name"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self setTitle:@"---"];
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

- (IBAction)btnContinueTouch:(id)sender
{
    //[self setPetName:self.txtPetName.text];
    self.petName = self.txtPetName.text;
    
    if([self validateName:self.petName])
    {
        SelectImgViewController *selectImgView = [[SelectImgViewController alloc] initWithNibName:@"SelectImgViewController" bundle:[NSBundle mainBundle]];
        [[MyPet sharedInstance] setPetName:self.petName];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FIRST_STEP_KEY];
        
        [self.navigationController pushViewController:selectImgView animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid pet name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (BOOL) validateName :(NSString* ) name
{
    BOOL validated = NO;
    
    // Validamos si tiene mas de 6 Caracteres.
    long longitud = [name length];
    if(longitud > 3)
    {
        validated = YES;
    }
    
    return validated;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

// Valida los caracterres del TextField
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length)
    {
        return YES;
    }
    else if(!string.length){
        return YES;
    }
    
    return NO;
}

@end
