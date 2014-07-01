//
//  VideoTableCell.m
//  MyFirstVideoApp
//
//  Created by ACS Xerox on 6/3/13.
//  Copyright (c) 2013 Xerox Corporation. All rights reserved.
//

#import "VideoTableCell.h"

@implementation VideoTableCell

@synthesize videoNameLabel, videoTimeLabel, videoView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
