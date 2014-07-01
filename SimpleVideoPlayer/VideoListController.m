//
//  ViewController.m
//  PointOUT
//
//  Created by ACS Xerox on 6/4/13.
//  Copyright (c) 2013 Kimberly-Clark. All rights reserved.
//

#import "VideoListController.h"
#import "VideoTableCell.h"
#import "Video.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface VideoListController () {
  NSString *mMoviePath;
}

@end

@implementation VideoListController

@synthesize dataModel=_dataModel;
@synthesize videosTableView;

-(id) initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.dataModel = [[DataModel alloc]init];
    self.dataModel.delegate=self;
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
  self.videosTableView.backgroundColor = [UIColor clearColor];
  UIEdgeInsets inset = UIEdgeInsetsMake(10, 0, 0, 0);
  self.videosTableView.contentInset = inset;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.dataModel.videoIDs count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 166;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"VideoTableCell";
  VideoTableCell *cell = (VideoTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if (cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VideoTableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }

  Video *theVideo = [self.dataModel.videoIDs objectAtIndex:[indexPath row]];

  [cell.videoView setFrame:theVideo.multiVideoPlayer.view.frame];
  [cell.videoView addSubview:theVideo.multiVideoPlayer.view];

  cell.videoNameLabel.text = theVideo.videoTitle;
  cell.videoTimeLabel.text = [[NSDate date] description];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Video *theVideo = [self.dataModel.videoIDs objectAtIndex:[indexPath row]];
  if([theVideo.multiVideoPlayer isPlaying]) {
    [theVideo.multiVideoPlayer pause];
  }
  else {
    [theVideo.multiVideoPlayer play];
  }
}


- (void) dataModelDataChanged:(DataModel *)dataModel
{
  [self.videosTableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  NSLog(@"Entered: %@ - %d", [[alertView textFieldAtIndex:0] text], buttonIndex);

  NSError *error = nil;
  NSFileManager *fileManager = [NSFileManager defaultManager];

  if(buttonIndex == 0) {
    NSString *sVideoWithExtn = [NSString stringWithFormat:@"%@.MOV", [[alertView textFieldAtIndex:0] text]];
    NSLog(@"Jaganlal name of the video is %@", sVideoWithExtn);

    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mMoviePath) &&
        [fileManager fileExistsAtPath:mMoviePath])
    {
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *documentsDirectory = [paths objectAtIndex:0];
      NSString *resourcePath = [documentsDirectory stringByAppendingPathComponent:sVideoWithExtn];

      [fileManager moveItemAtPath:mMoviePath toPath:resourcePath error:&error];
        NSLog(@"JAGANLAL MOVIE PATH SRC - %@ & DEST - %@", mMoviePath, resourcePath);

    [self.dataModel loadDummyVideoIDs];
      //UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
    } // if condition to check movie path comp
  } // if button index is 0
  else {
    [fileManager removeItemAtPath:mMoviePath error:&error];
  }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];

  [self dismissViewControllerAnimated:YES completion:^{
    if (![mediaType isEqualToString:(NSString*)kUTTypeMovie])
      return;

    //NSString *moviePath = [[NSString alloc]initWithString:[documentsDirectory stringByAppendingPathComponent:@"videos"]];

    mMoviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Name the video!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];

    /*NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
    NSLog(@"JAGANLAL MOVIE PATH IS %@", moviePath);

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath) &&
        [fileManager fileExistsAtPath:moviePath])
    {
      NSError *error = nil;
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *documentsDirectory = [paths objectAtIndex:0];
      NSString *resourcePath = [documentsDirectory stringByAppendingPathComponent:@"videos1.mov"];

      [fileManager moveItemAtPath:moviePath toPath:resourcePath error:&error];
    //UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
    }*/
  }];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (IBAction)recordVideo {
  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    return;
  }

  UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
  cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
  cameraUI.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeMovie, nil];
  cameraUI.videoQuality = UIImagePickerControllerQualityTypeHigh;

  cameraUI.allowsEditing = NO;
  cameraUI.delegate = self;

  [self presentModalViewController:cameraUI animated:YES];
}

@end
