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
@property NSMutableArray *guessedWords;
@end

@implementation WTViewController2
@synthesize userText;
@synthesize wordFromDict;
@synthesize userFeedback;


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
    _guessedWords =[[NSMutableArray alloc] init];
    userText.delegate = self;
	// Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"wordlist" ofType:@"txt"];
    if (filePath) {
        _dictArray = [[NSString stringWithContentsOfFile:filePath encoding: NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
        int rand = arc4random() % 10001;
        _dictWord = [_dictArray objectAtIndex: rand];
        self.wordFromDict.text = (@"%@", _dictWord);
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    _userWord = userText.text;
    NSMutableString *mutableString = [NSMutableString stringWithString: _dictWord];
    if ([_guessedWords containsObject: _userWord])
    {
        self.userFeedback.text = (@"You already tried that word, dummy!");
        return;
    }
    for (NSUInteger i = 0; i < [_userWord length]; i++)
    {
        NSString *curLetter = [_userWord substringWithRange: NSMakeRange(i, 1)];
        NSRange range = [mutableString rangeOfString:curLetter];
        if (range.location != NSNotFound)
        {
            [mutableString replaceCharactersInRange: range withString: @" "];
        }
        else
        {
            self.userFeedback.text = (@"One of those letters isn't in the word!");
            return;
        }
    }
    if ([_dictArray containsObject:_userWord] )
    {
        _score += [_userWord length];
        NSString *scoreString = [NSString stringWithFormat:@"%i", _score];
        self.scoreBox.text = scoreString;
        self.userFeedback.text = (@"Nice!");
        [_guessedWords addObject: _userWord];
    }
    else
    {
        self.userFeedback.text = (@"Not a valid word in our dictionary");
    }
}

- (IBAction)onButtonClick:(id)sender {
    int rand = arc4random() % 10001;
    _dictWord = [_dictArray objectAtIndex: rand];
    self.userFeedback.text = (@"Enter a word into the text field below");
    self.wordFromDict.text = (@"%@", _dictWord);
}

- (IBAction)unwindToMainMenu:(UIStoryboardSegue *)unwindSegue
{
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.userText resignFirstResponder];
    [self.userText becomeFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
