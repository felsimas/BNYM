//	GTabBarItam.h
//	Custom UITabBar with Images
//  Created by Daniel Hollis on 27/09/2010
//  Copyright Daniel Hollis 2010. All rights reserved.
//	Author's Personal Email vibrazy@hotmail.com
//	Author's Work Email dhollis@guerrilla.co.uk
//	Company Guerrilla Digital Media
//	Company's website: http://www.guerrillawebsitedesign.co.uk
//
//  You may use this code within your own projects.  If
//  you provide credit somewhere in your project to myself and Guerrilla Digital Media 
//  You may not use it in any tutorials, books wikis etc without asking me first.


#import <UIKit/UIKit.h>
@protocol GTabTabItemDelegate;


@interface GTabTabItem : UIButton {
	BOOL _on;
	id <GTabTabItemDelegate> delegate;
}
@property (nonatomic, assign) id <GTabTabItemDelegate> delegate;
@property (nonatomic) BOOL _on;
- (id)initWithFrame:(CGRect)frame normalState:(NSString*)n toggledState:(NSString *)t;              // This class enforces a size appropriate for the control. The frame size is ignored.
-(BOOL)isOn;
-(void)toggleOn:(BOOL)state;
@end

@protocol GTabTabItemDelegate
- (void)selectedItem:(GTabTabItem *)button;
@end
