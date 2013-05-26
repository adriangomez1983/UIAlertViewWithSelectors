//
//  MethodRelatedUIAlertView.h
//  NetworkingIsFun
//
//  Created by Néstor Adrián Gómez Elfi on 5/25/13.
//  Copyright (c) 2013 Néstor Adrián Gómez Elfi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiTargetUIAlertView : UIAlertView


-(BOOL) addTarget:(id) target andSelector:(SEL) selector forButtonIndex:(NSInteger) index;
@end
