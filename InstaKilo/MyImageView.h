//
//  myImageView.h
//  InstaKilo
//
//  Created by Aaron Johnson on 2017-10-18.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView
@property NSString *subject;
@property NSString *location;
-(instancetype)initWithImage:(UIImage *)image Subject:(NSString *)subject andLocation:(NSString *)location;
@end
