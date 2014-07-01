//
//  DataModel.m
//  YouTubeTableView
//
//  Created by John Mattos on 2/12/12.
//  Copyright (c) 2012 Gladiator Apps L.L.C.. All rights reserved.
//

#import "DataModel.h"
#import "Video.h"

@interface DataModel()
@end

@implementation DataModel
@synthesize delegate=_delegate;
@synthesize imageURLs=_imageURLs;
@synthesize imageCaptions=_imageCaptions;
@synthesize videoIDs=_videoIDs;

- (void) loadDummyRemoteImages{
    NSLog(@"Setting up the dummy remote images");
    self.imageCaptions = [[NSArray alloc] initWithObjects:@"Frosty Spiderweb",@"Happy New Year!",nil];

    self.imageURLs = [[NSArray alloc] initWithObjects:@"http://farm6.static.flickr.com/5042/5323996646_9c11e1b2f6_b.jpg", @"http://farm6.static.flickr.com/5007/5311573633_3cae940638.jpg",nil];
}

- (void) loadDummyVideoIDs{
    NSLog(@"Setting up the dummy data");
  //self.videoIDs = [[NSMutableArray alloc] initWithCapacity:5];
  self.videoIDs = [[NSMutableArray alloc] init];

  /*NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtURL:url
                                                                    includingPropertiesForKeys:@[NSURLContentAccessDateKey]
                                                                                       options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                                  errorHandler:nil];
   */

  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:documentsDirectory];
  NSLog(@"Jaganlal documentsDirectory is %@", documentsDirectory);

  NSURL *fileURL;
  while (fileURL = [directoryEnumerator nextObject]) {

    NSLog(@"File url is %@", fileURL);

    if([[fileURL pathExtension] isEqualToString:@"MOV"] ) {
      Video *v1 = [[Video alloc]init];
      v1.videoTitle =@"My Recorded video";
      v1.youtubeURL = @"";
      v1.videoPlayer = nil;

      NSString *sFileName = [NSString stringWithFormat:@"%@", fileURL];
      NSString *resourcePath = [documentsDirectory stringByAppendingPathComponent:sFileName];
      NSLog(@"resourcePath is %@", resourcePath);
      NSURL *url = [NSURL fileURLWithPath:resourcePath isDirectory:NO];
      v1.multiVideoPlayer = [self getVideoPlayer: url];
      [self.videoIDs addObject:v1];      
    }
    else {
      NSLog(@"Not mov file.....");
    } //not movie file
  } //while loop

  [self.delegate dataModelDataChanged:self];



/*
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *resourcePath = [documentsDirectory stringByAppendingPathComponent:@"videos1.mov"];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSLog(@"Jaganlal resource path is %@", resourcePath);
  if([fileManager fileExistsAtPath:resourcePath]) {
    NSLog(@"Jaganlal new video");
    Video *v1 = [[Video alloc]init];
    v1.videoTitle =@"My Recorded video";
    v1.youtubeURL = @"";
    v1.videoPlayer = nil;
    NSURL *url = [NSURL fileURLWithPath:resourcePath isDirectory:NO];
    v1.multiVideoPlayer = [self getVideoPlayer: url];
    [self.videoIDs addObject:v1];
  }

    Video *videoOne = [[Video alloc]init];
    videoOne.videoTitle =@"I Like Turtles";
    videoOne.multiVideoPlayer = [self getVideoPlayer];
    [self.videoIDs addObject:videoOne];

    Video *video2 = [[Video alloc]init];
    video2.videoTitle =@"Dramatic Chipmunk";
    video2.multiVideoPlayer = [self getVideoPlayer];
    [self.videoIDs addObject:video2];
    
    Video *video3 = [[Video alloc]init];
    video3.videoTitle =@"Death Star Canteen";
    video3.multiVideoPlayer = [self getVideoPlayer];
    [self.videoIDs addObject:video3];
    
    Video *video4 = [[Video alloc]init];
    video4.videoTitle =@"Scary Maki";
    video4.multiVideoPlayer = [self getVideoPlayer];
    [self.videoIDs addObject:video4];
    
    Video *video5 = [[Video alloc]init];
    video5.videoTitle =@"Chad Vader S01E01";
    video5.multiVideoPlayer = [self getVideoPlayer];
    [self.videoIDs addObject:video5];
*/
    // Remember to tell the delegate data has changed
    [self.delegate dataModelDataChanged:self];
}

-(id) init{
  self = [super init];
  if (self) {
    [self loadDummyVideoIDs];
    [self loadDummyRemoteImages];
  }
  return self;
}

-(VideoPlayerViewController*) getVideoPlayer
{
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"video_1" withExtension:@"mp4"];
  VideoPlayerViewController *player = [[VideoPlayerViewController alloc] init];
  player.URL = url;
  player.view.frame = CGRectMake(0, 0, 200, 150);

  return player;
}

-(VideoPlayerViewController*) getVideoPlayer:(NSURL *) url
{
  VideoPlayerViewController *player = [[VideoPlayerViewController alloc] init];
  player.URL = url;
  player.view.frame = CGRectMake(0, 0, 200, 150);

  return player;
}

- (MPMoviePlayerController*) getVideoView
{
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"video_1" withExtension:@"mp4"];
  MPMoviePlayerController *mpc = [[MPMoviePlayerController alloc] init];
  mpc.contentURL = url;
  mpc.view.frame = CGRectMake(0, 0, 160, 140);

  mpc.shouldAutoplay = NO;
  mpc.repeatMode = MPMovieRepeatModeOne;
  [mpc prepareToPlay];

  [mpc pause];

  return mpc;
}

- (MPMoviePlayerController*) setMPPlayerControllerTo:(MPMoviePlayerController**) mpc
{
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"video_1" withExtension:@"mp4"];
  *mpc = [[MPMoviePlayerController alloc] init];
  (*mpc).contentURL = url;
  (*mpc).view.frame = CGRectMake(0, 0, 160, 140);

  (*mpc).shouldAutoplay = NO;
  (*mpc).repeatMode = MPMovieRepeatModeOne;
  [(*mpc) prepareToPlay];

  [(*mpc) pause];

  return *mpc;
}

-(void) dealloc{
}
@end
