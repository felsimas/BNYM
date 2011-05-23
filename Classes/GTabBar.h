//	GTabBar.h
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
#import "GTabTabItem.h"

@protocol GTabBarViewDelegate;
@interface GTabBar : UIViewController <GTabTabItemDelegate> {
	UIView *tabBarHolder;
	NSMutableArray *tabViewControllers;
	NSMutableArray *tabItemsArray;
	id <GTabBarViewDelegate> delegate;
	int initTab;
}
//properties
@property int initTab;
@property (nonatomic, retain) UIView *tabBarHolder;
@property (nonatomic, assign) id <GTabBarViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *tabViewControllers;
@property (nonatomic, retain) NSMutableArray *tabItemsArray;
//actions
- (id)initWithTabViewControllers:(NSMutableArray *)tbControllers tabItems:(NSMutableArray *)tbItems initialTab:(int)iTab;
-(void)initialTab:(int)tabIndex;
-(void)activateController:(int)index;
-(void)activateTabItem:(int)index;
@end

//protocol
@protocol GTabBarViewDelegate
- (void)addController:(id)controller;
@end
