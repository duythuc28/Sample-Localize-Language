//
//  ViewController.m
//  PracticeLocalizeLanguage
//
//  Created by IOSDev on 12/10/15.
//  Copyright © 2015 IOSDev. All rights reserved.
//

#import "ViewController.h"
#import "Language/LocalizeHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel            * mLocalizeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl * mSeletedLanguageControl;
@end

typedef enum {
    SeletedLanguageEnglish,
    SeletedLanguageFrench,
    SeletedLanguageVietNam
}SeletedLanguage;

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mSeletedLanguageControl addTarget:self
                                     action:@selector(didSeletedLanguage:)
                           forControlEvents:UIControlEventValueChanged ];
    BOOL tIsNotFirstTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"kNotFirstTime"] boolValue];
    if (!tIsNotFirstTime) {
        [self setLanguage:@"en"];
        tIsNotFirstTime = YES;
        [[NSUserDefaults standardUserDefaults]setBool:tIsNotFirstTime
                                               forKey:@"kNotFirstTime"];
    }
    [self setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:@"kAppLanguage"]];
    [self loadCurrentUI];
}

- (void)didSeletedLanguage:(UISegmentedControl *)sender {
    NSString * tLanguageCode;
    switch (sender.selectedSegmentIndex) {
        case SeletedLanguageEnglish:
            tLanguageCode = @"en";
            break;
        case SeletedLanguageFrench:
            tLanguageCode = @"fr";
            break;
        case SeletedLanguageVietNam:
            tLanguageCode = @"vi";
            break;
        default:
            break;
    }
    [self setLanguage:tLanguageCode];
    [self loadCurrentUI];
}

- (void)setLanguage:(NSString *)sLanguageCode {
    [[NSUserDefaults standardUserDefaults ] setObject:sLanguageCode forKey:@"kAppLanguage"];
    [[LocalizeHelper sharedLocalSystem] setLanguage:sLanguageCode];
    if ([sLanguageCode isEqualToString:@"en"]) {
        self.mSeletedLanguageControl.selectedSegmentIndex = SeletedLanguageEnglish;
    } else if ([sLanguageCode isEqualToString:@"fr"]) {
        self.mSeletedLanguageControl.selectedSegmentIndex = SeletedLanguageFrench;
    } else {
        self.mSeletedLanguageControl.selectedSegmentIndex = SeletedLanguageVietNam;
    }
}

- (void)loadCurrentUI {
    self.mLocalizeLabel.text = LocalizedString(@"home.label");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
