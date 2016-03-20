//
//  IFSStatus.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatus.h"
#import "IFSUser.h"
#import "IFSEmotionManager.h"
#import "IFSEmotionTextAttachment.h"

@implementation IFSStatus

- (NSArray *)picUrls {
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *pic_url_dict in self.pic_urls) {
        NSString *pic_url = [pic_url_dict objectForKey:@"thumbnail_pic"];
        NSURL *picUrl = [NSURL URLWithString:[pic_url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
        [arrM addObject:picUrl];
    }
    return arrM;
}

- (NSString *)createdAt {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MM dd HH:mm:ss z yyyy";
    NSDate *date = [formatter dateFromString:_created_at];
    
    if ([calendar isDateInToday:date]) {
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:date];
        if (timeInterval < 60) {
            return @"刚刚";
        } else if (timeInterval < 3600) {
            return [NSString stringWithFormat:@"%ld分钟前", (NSInteger)timeInterval / 60];
        } else {
            return [NSString stringWithFormat:@"%ld小时前", (NSInteger)timeInterval / 3600];
        }
    } else if ([calendar isDateInYesterday:date]) {
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:date]];
    } else {
        NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:date toDate:[NSDate date] options:0];
        if (component.year == 0) {
            formatter.dateFormat = @"MM-dd";
            return [formatter stringFromDate:date];
        } else {
            formatter.dateFormat = @"yyyy-MM-dd";
            return [formatter stringFromDate:date];
        }
    }
}

- (NSString *)sourceStr {
    NSString *pattern = @"<a.*?>(.*?)</a>";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *results = [expression matchesInString:_source options:0 range:NSMakeRange(0, _source.length)];
    NSTextCheckingResult *result = results.firstObject;
    NSRange range = [result rangeAtIndex:1];
    return [_source substringWithRange:range];
}

- (NSString *)sourceHref {
    NSString *pattern = @"<a href=\"(.*?)\".*?>.*?</a>";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *results = [expression matchesInString:_source options:0 range:NSMakeRange(0, _source.length)];
    NSTextCheckingResult *result = results.firstObject;
    NSRange range = [result rangeAtIndex:1];
    return [_source substringWithRange:range];
}

- (NSAttributedString *)attributedText {
    NSString *pattern = @"\\[.*?\\]";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *results = [expression matchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];

    NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithString:self.text];
    for (NSInteger i = results.count - 1; i >= 0; i--) {
        NSTextCheckingResult *result = results[i];
        NSRange range = [result rangeAtIndex:0];
        NSString *name = [self.text substringWithRange:range];
        IFSEmotionManager *manager = [IFSEmotionManager sharedManager];
        IFSEmotion *emotion = [manager getEmotionWithName:name];
        if (emotion) {
            IFSEmotionTextAttachment *attachment = [[IFSEmotionTextAttachment alloc] init];
            [aStrM replaceCharactersInRange:range withAttributedString:[attachment attributedStringWithEmotion:emotion font:[UIFont systemFontOfSize:14]]];
        }
    }
    [aStrM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, aStrM.length)];
    [aStrM addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, aStrM.length)];
    
    return aStrM;
}

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    IFSStatus *status = [[self alloc] init];
    [status setValuesForKeysWithDictionary:dict];
    return status;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idstr = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"user"]) {
        self.user = [IFSUser userWithDict:value];
        return;
    }
    
    if ([key isEqualToString:@"retweeted_status"]) {
        self.retweeted_status = [IFSStatus statusWithDict:value];
        return;
    }
    
    [super setValue:value forKey:key];
}

@end