//
//  AWSSignInButtonView.h
//  AWSMobileHubHelper
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to
// copy, distribute and modify it.
//

#import <Foundation/Foundation.h>
#import "AWSSignInProvider.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWSSignInButtonStyle) {
    AWSSignInButtonStyleLogo,
    AWSSignInButtonStyleTextLogo
};

@protocol AWSSignInButtonView<NSObject>

@property (nonatomic, weak) id<AWSSignInDelegate> delegate;

@property (nonatomic) AWSSignInButtonStyle buttonStyle;

- (void)setSignInProvider:(id<AWSSignInProvider>)signInProvider;

@end

NS_ASSUME_NONNULL_END