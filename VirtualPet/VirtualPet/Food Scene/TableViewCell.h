//
//  TableViewCell.h
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *myLblName;

@end
