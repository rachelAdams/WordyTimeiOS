//
//  WTViewController2.h
//  WordyTime
//
//  Created by Lab User on 4/17/14.
//
//

#import <UIKit/UIKit.h>

@interface WTViewController2: UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *gameScreen;
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UILabel *wordFromDict;
@property (weak, nonatomic) IBOutlet UIButton *nextWordButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreBox;


@end

