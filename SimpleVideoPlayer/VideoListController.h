//
//  ViewController.h
//  PointOUT
//
//  Created by ACS Xerox on 6/4/13.
//  Copyright (c) 2013 Kimberly-Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface VideoListController : UIViewController <DataModelDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
  IBOutlet UITableView *videosTableView;
}

@property (nonatomic,strong) DataModel *dataModel;
@property(nonatomic,retain) UITableView *videosTableView;

-(IBAction)recordVideo;

@end
