//
//  PdfViewController.h
//  WebViewTutorial
//
//  Created by iPhone SDK Articles on 8/19/08.
//  Copyright 2008 www.iPhoneSDKArticles.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PdfViewController : UIViewController {
	
	IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) UIWebView *webView;

@end
