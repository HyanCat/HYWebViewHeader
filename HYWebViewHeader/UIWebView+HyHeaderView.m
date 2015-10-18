//
//  UIWebView+HyHeaderView.m
//
//  Created by HyanCat on 15/10/18.
//  Copyright © 2015年 HyanCat. All rights reserved.
//

#import "UIWebView+HyHeaderView.h"
#import <objc/runtime.h>

static void *hyHeaderViewKey = &hyHeaderViewKey;

@interface UIView (HySubviews)

- (NSArray <UIView *> *)subviewsWhichKindOfClass:(Class)viewClass;

@end

@implementation UIView (HySubviews)

- (NSArray <UIView *> *)subviewsWhichKindOfClass:(Class)viewClass
{
	NSMutableArray *subviews = [NSMutableArray array];
	for (UIView *v in self.subviews) {
		if ([v isKindOfClass:viewClass]) {
			[subviews addObject:v];
		}
	}
	
	return [subviews copy];
}

@end


@implementation UIWebView (HyHeaderView)

@dynamic hyHeaderView;

- (UIView *)hyHeaderView
{
	return objc_getAssociatedObject(self, hyHeaderViewKey);
}

- (void)setHyHeaderView:(UIView *)hyHeaderView
{
	if (nil == hyHeaderView) {
		[self.hyHeaderView removeFromSuperview];
	}
	objc_setAssociatedObject(self, hyHeaderViewKey, hyHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	if (self.hyHeaderView) {
		[self.scrollView addSubview:self.hyHeaderView];
		[self updateHyHeaderView];
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	if (self.hyHeaderView) {
		[self updateHyHeaderView];
	}
}

- (void)updateHyHeaderView
{
	CGFloat width = self.scrollView.frame.size.width;
	
	NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.hyHeaderView
																	   attribute:NSLayoutAttributeWidth
																	   relatedBy:NSLayoutRelationEqual
																		  toItem:nil
																	   attribute:NSLayoutAttributeNotAnAttribute
																	  multiplier:1.f
																		constant:width];
	[self.scrollView addConstraint:widthConstraint];
	CGFloat height = [self.hyHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	[self.scrollView removeConstraint:widthConstraint];
	
	self.hyHeaderView.frame = CGRectMake(0, 0, width, height);
	
	UIView *webBrowserView = [[self.scrollView subviewsWhichKindOfClass:NSClassFromString(@"UIWebBrowserView")] firstObject];
	CGRect frame = webBrowserView.frame;
	frame.origin.y = height;
	webBrowserView.frame = frame;
}


@end

