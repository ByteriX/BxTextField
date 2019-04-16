//
//  UIView+ShakeAnimation.h
//  BxTextField
//
//  Created by Sergey Balalaev on 16/04/2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ShakeAnimation)

- (void)shakeXWithOffset: (CGFloat) offset
             breakFactor: (CGFloat) breakFactor
                duration: (CGFloat) duration
               maxShakes: (NSInteger) maxShakes;

@end


NS_ASSUME_NONNULL_END
