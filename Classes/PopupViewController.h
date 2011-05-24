//  Copyright 2011 Logic Diner. All rights reserved.

#import <UIKit/UIKit.h>

//need to declare class
@class PopupViewController;

@protocol DismissPopDelegate <NSObject>

-(void)dismissPop;

@end


@interface PopupViewController : UIViewController {

	IBOutlet UILabel *label;
	id<DismissPopDelegate> *_delegate;
	
}

@property(nonatomic, retain) IBOutlet UILabel *label;
@property(nonatomic, assign) id<DismissPopDelegate> *_delegate;




@end
