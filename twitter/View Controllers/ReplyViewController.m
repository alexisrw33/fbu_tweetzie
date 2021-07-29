//
//  ReplyViewController.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/17/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textCount;

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    self.textView.delegate = self;
    // Do any additional setup after loading the view.
    self.textView.text = @"@";
    
    self.textView.text = [self.textView.text stringByAppendingString:((void)(@"%@"), self.replyTweet.user.screenName)];
}

- (void)replyToTweet {
    [[APIManager shared]replyStatusWithText:self.textView.text replyStatusWithID:self.replyTweet.idStr completion:^(Tweet *, NSError *) {
        if (self) {
            NSLog(@"😎😎😎 Successfully posted the tweet");
        } else {
            NSLog(@"😫😫😫 Error posting tweet");
        }
    }];
    
}
- (IBAction)onTweet:(id)sender {
    [self replyToTweet];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
   // Allow or disallow the new text
    // Set the max character limit
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update Character Count Label

    // The new text should be allowed? True/False
    if (newText.length < characterLimit) {
        NSInteger charactersLeft = ((self.replyTweet.user.screenName.length + 141) - newText.length);
        self.textCount.text = [NSString stringWithFormat:@"%ld", (long)charactersLeft];
        return true;
    } else {
        return false;
    }
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
