//
//  IFSStatusLinkViewController.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusLinkViewController.h"

@interface IFSStatusLinkViewController () <UIWebViewDelegate>

@end

@implementation IFSStatusLinkViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [SVProgressHUD show];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [SVProgressHUD dismiss];
//}


@end
