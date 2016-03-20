//
//  IFSComposeViewController.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSComposeViewController.h"
#import "IFSComposePictureView.h"
#import "IFSEmotionTextView.h"
#import "IFSEmotionView.h"
#import "IFSEmotion.h"
#import "IFSComposeViewModel.h"

@interface IFSComposeViewController () 

@property (weak, nonatomic) IBOutlet IFSEmotionTextView *textView;
@property (weak, nonatomic) IBOutlet IFSComposePictureView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *tintLabel;
@property (nonatomic, strong) IFSEmotionView *emotionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation IFSComposeViewController

- (IFSEmotionView *)emotionView {
    if (_emotionView == nil) {
        _emotionView = [[[NSBundle mainBundle] loadNibNamed:@"IFSEmotionView" owner:nil options:nil] firstObject];
        
        __weak typeof(self) weakSelf = self;
        _emotionView.insertEmotion = ^(IFSEmotion *emotion) {
            [weakSelf.textView insertEmotion:emotion];
        };
    }
    return _emotionView;
}

- (IBAction)photoClick:(id)sender {
    [self.textView resignFirstResponder];
    [self.pictureView addImage];
}

- (IBAction)emotionClick:(id)sender {
    [self.textView resignFirstResponder];
    self.textView.inputView = (self.textView.inputView == nil ?self.emotionView : nil);
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextChange) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    [SVProgressHUD show];
     [IFSComposeViewModel sendStatus:[self.textView fullText] images:self.pictureView.images responseHandler:^(BOOL success) {
         if (success) {
             [SVProgressHUD showSuccessWithStatus:@"发表成功"];
         } else {
             [SVProgressHUD showErrorWithStatus:@"发表失败"];
         }
         [self cancel];
     }];
}

- (void)onTextChange {
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length > 0);
    self.tintLabel.hidden = (self.textView.text.length > 0);
}

- (void)onKeyboardFrameChange:(NSNotification *)noti {
    CGFloat duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.bottomConstraint.constant = ScreenH - rect.origin.y;
        [self.view layoutIfNeeded];
    }];
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
