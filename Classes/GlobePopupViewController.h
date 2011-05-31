//
//  PopupViewController.h
//  globe
//
//  Created by isaac silva on 5/30/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
@class CustomMoviePlayerViewController;
@class PopupViewController;


@interface GlobePopupViewController : UIViewController {
    
    IBOutlet UIImageView *currentScreenView;
	IBOutlet UIView * backgroundView;
	IBOutlet UIButton * closeButton;
    int currentScreen;
    CustomMoviePlayerViewController *moviePlayer;
	UIView *movieView;
    MPMoviePlayerController *player;

}

@property (nonatomic, assign) MPMoviePlayerController *player;

@property (nonatomic, assign) int currentScreen;
@property(nonatomic, assign) CustomMoviePlayerViewController *moviePlayer;
@property (nonatomic, retain)IBOutlet UIView *movieView;

-(IBAction) dismiss;
-(IBAction) nextScreen;
- (void)addMovie;

@end

