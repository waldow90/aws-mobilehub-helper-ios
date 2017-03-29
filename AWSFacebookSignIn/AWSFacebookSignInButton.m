//
//  AWSFacebookSignInButton.m
//  AWSFacebookSignIn
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to
// copy, distribute and modify it.
//

#import "AWSFacebookSignInButton.h"
#import "AWSFacebookSignInProvider.h"

typedef void (^AWSSignInManagerCompletionBlock)(id result, AWSAuthState authState, NSError *error);

static NSString *facebookLogoImageKey = @"fb-no-text";
static NSString *facebookTextImageKey = @"fb-text";

#define LOGO_IMAGE_HEIGHT 45
#define LOGO_IMAGE_WIDTH 98

#define TEXT_IMAGE_HEIGHT 60
#define TEXT_IMAGE_WIDTH 338

@interface AWSFacebookSignInButton()

@property (nonatomic, strong) id<AWSSignInProvider> signInProvider;

@property (nonatomic, strong) UIImageView *signInButton;

@end

@implementation AWSFacebookSignInButton

@synthesize delegate;
@synthesize buttonStyle;
UIButton *facebookButton;

- (id)initWithCoder:(NSCoder*)aDecoder
{

    if (self = [super initWithCoder:aDecoder]) {
        _signInProvider = [AWSFacebookSignInProvider sharedInstance];
    }
    
    [self initFacebookButton];
    [self addSubview:facebookButton];

    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // property set
    if ([keyPath isEqualToString:@"buttonStyle"]) {
        if (buttonStyle == AWSSignInButtonStyleTextLogo) {
            [self setupFacebookTextButton];
        } else {
            [self setupFacebookLogoButton];
        }
        // refresh views
        [facebookButton setNeedsDisplay];
        [self setNeedsDisplay];
    }
}

- (void)initFacebookButton {
    facebookButton = [[UIButton alloc] init];
    [self addObserver:self forKeyPath:@"buttonStyle" options:0 context:nil];
    self.buttonStyle = AWSSignInButtonStyleLogo;
    self.clipsToBounds = YES;
    [facebookButton addTarget:self
                       action:@selector(logInWithProvider:)
             forControlEvents:UIControlEventTouchDown];
}

- (void)setupFacebookLogoButton {
    CGRect buttonFrame = facebookButton.frame;
    buttonFrame.size = CGSizeMake(LOGO_IMAGE_WIDTH, LOGO_IMAGE_HEIGHT);
    facebookButton.frame = buttonFrame;
    UIImage *providerImage = [UIImage imageNamed:facebookLogoImageKey];
    [facebookButton setImage:providerImage forState:UIControlStateNormal];
}

- (void)setupFacebookTextButton {
    CGRect buttonFrame = facebookButton.frame;
    buttonFrame.size = CGSizeMake(TEXT_IMAGE_WIDTH, TEXT_IMAGE_HEIGHT);
    facebookButton.frame = buttonFrame;
    UIImage *providerImage = [UIImage imageNamed:facebookTextImageKey];
    [facebookButton setImage:providerImage forState:UIControlStateNormal];
}

- (void)setSignInProvider:(id<AWSSignInProvider>)signInProvider {
    self.signInProvider = signInProvider;
}

- (void)logInWithProvider:(id)sender {

    [[AWSSignInManager sharedInstance] loginWithSignInProviderKey:[self.signInProvider identityProviderName]
                                                completionHandler:^(id result, AWSAuthState authState, NSError *error) {
        [self.delegate onLoginWithSignInProvider:self.signInProvider
                                          result:result
                                       authState:authState
                                           error:error];
    }];
}

@end
