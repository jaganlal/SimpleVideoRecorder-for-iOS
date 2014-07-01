//
//  Video.h
//  YouTubeTableView
//
//  Created by John Mattos on 2/12/12.
//  Copyright (c) 2012 Gladiator Apps L.L.C.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerViewController.h"

@interface Video : NSObject
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *youtubeURL;
@property (nonatomic, strong) MPMoviePlayerController *videoPlayer;
@property (nonatomic, strong) VideoPlayerViewController *multiVideoPlayer;
@end
