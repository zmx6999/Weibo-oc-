//
//  IFSLoginViewController.m
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSLoginViewController.h"
#import "IFSAccountViewModel.h"
#import "IFSWelcomeViewController.h"

@interface IFSLoginViewController () <UIWebViewDelegate>

@end

@implementation IFSLoginViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStylePlain target:self action:@selector(autofill)];
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code", AppKey, RedirectUri]]]];
}

- (void)cancel {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)autofill {
    UIWebView *webView = (UIWebView *)self.view;
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('userId').value = '17092875286';document.getElementById('passwd').value='6593147000ddzg';"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr containsString:@"https://api.weibo.com/oauth2/authorize"]) {
        return YES;
    }
    
    if ([urlStr containsString:@"code="]) {
        NSRange range = [urlStr rangeOfString:@"code="];
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [IFSAccountViewModel fetchAccessTokenWithCode:code responseHandler:^(IFSAccount *account) {
            if (account == nil) {
                return;
            }
            
            [IFSAccountViewModel fetchUserInfoWithAccount:account responseHandler:^(BOOL success) {
                if (!success) {
                    return;
                }
                
                self.view.window.rootViewController = [[IFSWelcomeViewController alloc] init];
            }];
        }];
    }
    
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
