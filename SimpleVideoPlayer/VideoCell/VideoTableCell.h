//
//  VideoTableCell.h
//  MyFirstVideoApp
//
//  Created by ACS Xerox on 6/3/13.
//  Copyright (c) 2013 Xerox Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableCell : UITableViewCell {

}

@property (nonatomic, retain) IBOutlet UILabel *videoNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *videoTimeLabel;
@property (nonatomic, retain) IBOutlet UIView *videoView;


@end
