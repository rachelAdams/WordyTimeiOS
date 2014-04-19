//
//  WTViewController2.m
//  WordyTime
//
//  Created by Lab User on 4/17/14.
//
//

#import "WTViewController2.h"

@interface WTViewController2()
@property NSArray *dictArray;
@property NSString *dictWord;
@property NSString *userWord;
@property int score;
@end

@implementation WTViewController2
@synthesize userText;
@synthesize wordFromDict;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.restorationIdentifier = @"resumeGame";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userText.delegate = self;
	// Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"wordlist" ofType:@"txt"];
    if (filePath) {
        NSLog(@"%@",filePath);
        _dictArray = [[NSString stringWithContentsOfFile:filePath encoding: NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
        int rand = arc4random() % 10001;
        _dictWord = [_dictArray objectAtIndex: rand];
        self.wordFromDict.text = (@"%@", _dictWord);
    }
}


-(void) textFieldDidEndEditing:(UITextField *)textField
{
    _userWord = userText.text;
    if ([_dictArray containsObject:_userWord] )
    {
        _score += [_userWord length];
        
        NSString *scoreString = [NSString stringWithFormat:@"%i", _score];
        self.scoreBox.text = scoreString;
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    

    [self.userText resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
