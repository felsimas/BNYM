//	GTabBarItem.m
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

#import "GTabTabItem.h"


@implementation GTabTabItem
@synthesize _on;
@synthesize delegate;

#pragma mark -
-(BOOL)isOn {
	return _on;
}	
- (id)initWithFrame:(CGRect)frame normalState:(NSString*)n toggledState:(NSString *)t;   
{
	if (self = [super initWithFrame:frame]) 
	{
		[self setBackgroundImage:[UIImage imageNamed:n] forState:UIControlStateNormal];
		[self setBackgroundImage:[UIImage imageNamed:t] forState:UIControlStateSelected];
		_on = NO;
		[self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}
-(void)toggleOn:(BOOL)state {
	_on = state;
	[self setSelected:_on];
}

-(void)toggle {
	[self setSelected:_on];
}
- (void)buttonPressed:(id)target
{
	//send notification of the button that was currently pressed
	[self.delegate selectedItem:target];
}
- (void)dealloc {
    [super dealloc];
}


@end
