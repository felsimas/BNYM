//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>

@class TwitterAuthController;



@interface TwitterAuthController : UIViewController  {

	//UIWebView *webView;
	
	
	IBOutlet UIView * backgroundView;
	IBOutlet UIButton * closeButton;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;

-(IBAction) dismiss;


@end
