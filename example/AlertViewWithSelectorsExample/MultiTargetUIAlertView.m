//
//  MethodRelatedUIAlertView.m
//  NetworkingIsFun
//
//  Created by Néstor Adrián Gómez Elfi on 5/25/13.
//  Copyright (c) 2013 Néstor Adrián Gómez Elfi. All rights reserved.
//

#import "MultiTargetUIAlertView.h"

@interface Pair : NSObject

@property (nonatomic, strong) NSObject *first;
@property (nonatomic, assign) SEL second;

-(id) initWithFirst:(id) first andSecond:(SEL) second;
@end

@implementation Pair


-(id) initWithFirst:(id)first andSecond:(SEL)second
{
    self = [super init];
    if(self)
    {
        _first = first;
        _second = second;
    }
    return self;
    
}

@end

@implementation MultiTargetUIAlertView
{
    NSMutableDictionary *_selectorMap;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectorMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if(self)
    {
        va_list btnTitleList;
        va_start(btnTitleList, otherButtonTitles);
        _selectorMap = [[NSMutableDictionary alloc] init];

        for (NSString *btnTitle = otherButtonTitles; btnTitle != nil; btnTitle = va_arg(btnTitleList, NSString*))
        {
            Pair *targetSelectorEmptyPair = [[Pair alloc] initWithFirst:nil andSecond:nil];
            [_selectorMap setObject:targetSelectorEmptyPair forKey:btnTitle];
            [self addButtonWithTitle:btnTitle];
        }
        Pair *cancelBtnPair = [[Pair alloc] initWithFirst:nil andSecond:nil];
        [_selectorMap setObject:cancelBtnPair forKey:cancelButtonTitle];
        va_end(btnTitleList);
    }

    return self;
}

-(void) storeTarget:(id) target andSelector:(SEL) selector forTitle:(NSString *) title
{
    Pair *pair = [_selectorMap objectForKey:title];
    if(pair)
    {
        pair.first = target;
        pair.second = selector;
    }
    else
    {
        pair = [[Pair alloc] initWithFirst:target andSecond:selector];
    }
    [_selectorMap setObject:pair forKey:title];

}

-(BOOL) addTarget:(id) target andSelector:(SEL) selector forButtonIndex:(NSInteger) index
{
    BOOL result = NO;
    
    if(index >=0 && index < [self numberOfButtons] && [target respondsToSelector:selector])
    {
        NSString *title = nil;
        result = YES;
        if(index == [self cancelButtonIndex])
        {   title = [self buttonTitleAtIndex:[self cancelButtonIndex]];
            [self storeTarget:target andSelector:selector forTitle:title];
        }
        else
        {
            title = [self buttonTitleAtIndex:index];
            [self storeTarget:target andSelector:selector forTitle:title];
        }
    }
    else
    {
        result = NO;
    }
    return result;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    Pair *targetSelector = [_selectorMap objectForKey:[self buttonTitleAtIndex:buttonIndex]];
    id target = targetSelector.first;
    SEL selector = targetSelector.second;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [target performSelector:selector];
#pragma clang diagnostic pop

    
    
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    NSInteger index = [super addButtonWithTitle:title];
    Pair *emptyTargetSelectorPair = [[Pair alloc] initWithFirst:nil andSecond:nil];
    [_selectorMap setObject:emptyTargetSelectorPair forKey:title];
    return index;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
