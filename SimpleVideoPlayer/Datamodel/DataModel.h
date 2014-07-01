//
//  DataModel.h
//  YouTubeTableView
//
//  Created by John Mattos on 2/12/12.
//  Copyright (c) 2012 Gladiator Apps L.L.C.. All rights reserved.
//

@class DataModel, ReachabilityManager;

@protocol DataModelDelegate <NSObject>
-(void) dataModelDataChanged:(DataModel *)dataModel;
@end

@interface DataModel : NSObject
@property (nonatomic, strong) NSMutableArray *videoIDs;
@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, strong) NSArray *imageCaptions;
@property (nonatomic, retain) id <DataModelDelegate> delegate;

- (void) loadDummyVideoIDs;

@end
