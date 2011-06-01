//
//  PopupViewController.h
//  globe
//
//  Created by isaac silva on 5/30/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "GlobePopupViewController.h"
#import "PdfViewController.h"

@class CustomMoviePlayerViewController;
@class PopupViewController;

@protocol PopUpViewPDFDelegate <NSObject>

- (void)popPdf;

@end

@interface GlobePopupViewController : UIViewController {
    
    IBOutlet UIImageView *currentScreenView;
	IBOutlet UIView * backgroundView;
	IBOutlet UIButton * closeButton;
    int currentScreen;
    CustomMoviePlayerViewController *moviePlayer;
	UIView *movieView;
    MPMoviePlayerController *player;
	PdfViewController *pdfView;
    id<PopUpViewPDFDelegate> *delegate;
}

@property (nonatomic, assign) id<PopUpViewPDFDelegate> *delegate;
@property (nonatomic, assign) PdfViewController *pdfView;
@property (nonatomic, assign) MPMoviePlayerController *player;

@property (nonatomic, assign) int currentScreen;
@property(nonatomic, assign) CustomMoviePlayerViewController *moviePlayer;
@property (nonatomic, retain)IBOutlet UIView *movieView;

-(IBAction) dismiss;
-(IBAction) nextScreen;
-(IBAction) popPdf;
- (void)addMovie;

@end

