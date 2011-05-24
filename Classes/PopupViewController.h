//  Copyright 2011 Logic Diner. All rights reserved.

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>

//need to declare class
@class PopupViewController;
@class CustomMoviePlayerViewController;

@protocol DismissPopDelegate <NSObject>

-(void)dismissPop;

@end


@interface PopupViewController : UIViewController {
	IBOutlet UILabel *label;
	id<DismissPopDelegate> *_delegate;
	UIView *movieView;
    CustomMoviePlayerViewController *moviePlayer;

}
@property (nonatomic, retain)IBOutlet UIView *movieView;
@property(nonatomic, retain) IBOutlet UILabel *label;
@property(nonatomic, assign) id<DismissPopDelegate> *_delegate;
@property(nonatomic, assign) CustomMoviePlayerViewController *moviePlayer;




@end
