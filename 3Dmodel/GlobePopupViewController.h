//
//  PopupViewController.h
//  globe
//
//  Created by isaac silva on 5/30/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GlobePopupViewController : UIViewController {
    
	
	IBOutlet UIView * backgroundView;
	IBOutlet UIButton * closeButton;
}


-(IBAction) dismiss;

@end

