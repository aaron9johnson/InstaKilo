//
//  myImageView.m
//  InstaKilo
//
//  Created by Aaron Johnson on 2017-10-18.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "myImageView.h"

@implementation MyImageView
-(instancetype)initWithImage:(UIImage *)image Subject:(NSString *)subject andLocation:(NSString *)location{
    self = [super init];
    if (self) {
        self.image = image;
        _subject = subject;
        _location = location;
    }
    return self;
}

@end
