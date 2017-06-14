//
//  AEWebViewContainer.h
//  wesg
//
//  Created by Altair on 9/22/16.
//  Copyright © 2016 AliSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef enum {
    AEWebViewContainTypeWKWebView = 0,
    AEWebViewContainTypeUIWebView
}AEWebViewContainType;

typedef enum {
    AEWebViewNavigationTypeLinkClicked,
    AEWebViewNavigationTypeFormSubmitted,
    AEWebViewNavigationTypeBackForward,
    AEWebViewNavigationTypeReload,
    AEWebViewNavigationTypeFormResubmitted,
    AEWebViewNavigationTypeOther
}AEWebViewNavigationType;

@class AEWebViewContainer;

@protocol AEWebviewContainerDelegate <NSObject>

@optional

- (BOOL)webViewContainer:(AEWebViewContainer *)container shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(AEWebViewNavigationType)navigationType webViewType:(AEWebViewContainType)webViewType;

- (void)webViewContainerDidStartLoad:(AEWebViewContainer *)container webViewType:(AEWebViewContainType)webViewType;

- (void)webViewContainerDidFinishLoad:(AEWebViewContainer *)container webViewType:(AEWebViewContainType)webViewType;

- (void)webViewContainer:(AEWebViewContainer *)container didFailLoadWithError:(NSError *)error webViewType:(AEWebViewContainType)webViewType;

@end

@interface AEWebViewContainer : UIView

@property (nonatomic, strong, readonly) UIWebView *uiWebView;

@property (nonatomic, strong, readonly) WKWebView *wkWebView;   //默认

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) AEWebViewContainType webViewType;

@property (nonatomic, weak) id<AEWebviewContainerDelegate> delegate;

//webview methods
@property (nonatomic, strong, readonly) NSURL *originalUrl;
@property (nonatomic, strong, readonly) NSURL *currentUrl;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)loadRequest:(NSURLRequest *)request;

- (void)reload;

- (void)reloadFromOrigin;

- (void)stopLoading;

- (void)goBack;

- (void)goForward;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id completion, NSError * error))completionHandler;

- (void)clearWebCache:(void(^)())finished;

- (void)setupCustomUserAgent:(NSString *)cUA completionHandler:(void(^)(NSString *userAgent))completionHandler;

@end
