//
//  NSString+Add.m
//
//
//  Created by guoyaoyuan on 13-4-3.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import "LFNSString+Add.h"
#import "LFNSData+Add.h"
#import "LFNSNumber+Add.h"
#import "LFNSCharacterSet+Add.h"
#import "LFCategoryMacro.h"

static BOOL g_allowedCharacters = NO;
static BOOL g_stringByRemovingPercentEncoding = NO;

@implementation NSString (LFAdditions)

- (NSString *)lf_md5 {
    return [self lf_md5String];
}

- (NSString *)lf_md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_md2String];
}

- (NSString *)lf_md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_md4String];
}

- (NSString *)lf_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_md5String];
}

- (NSString *)lf_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_sha1String];
}

- (NSString *)lf_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_sha224String];
}

- (NSString *)lf_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_sha256String];
}

- (NSString *)lf_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_sha384String];
}

- (NSString *)lf_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lf_crc32String];
}

- (NSString *)lf_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacMD5StringWithKey:key];
}

- (NSString *)lf_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacSHA1StringWithKey:key];
}

- (NSString *)lf_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacSHA224StringWithKey:key];
}

- (NSString *)lf_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacSHA256StringWithKey:key];
}

- (NSString *)lf_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacSHA384StringWithKey:key];
}

- (NSString *)lf_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            lf_hmacSHA512StringWithKey:key];
}

- (NSString *)lf_stringByURLEncode {
    return [self lf_stringByURLEncode:NSUTF8StringEncoding];
}

- (NSString *)lf_stringByURLDecode {
    return [self lf_stringByURLDecode:NSUTF8StringEncoding];
}

- (NSString *)lf_stringByURLEncode:(NSStringEncoding)encoding {
    
    static NSString * const  allowedCharacters = @"!*'();:@&=+$,/?%#[]";
    g_allowedCharacters = [NSString instancesRespondToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)];
    if (g_allowedCharacters) {
        static NSCharacterSet * characterSet = nil;
        if (characterSet == nil) {
            characterSet = [NSCharacterSet characterSetWithCharactersInString:allowedCharacters];
        }
        return  [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    } else {
        CFStringRef escaped = NULL;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        escaped = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                          (CFStringRef)self,
                                                          NULL,
                                                          (CFStringRef)allowedCharacters,
                                                          (CFStringEncoding)encoding);
#pragma clang diagnostic pop
        
#if defined(__has_feature) && __has_feature(objc_arc)
        return CFBridgingRelease(escaped);
#else
        return [(NSString *)escaped autorelease];
#endif
    }
}

- (NSString *)lf_stringByURLDecode:(NSStringEncoding)encoding {
    
    g_stringByRemovingPercentEncoding = [NSString instancesRespondToSelector:@selector(stringByRemovingPercentEncoding)];
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    
    
    if (g_stringByRemovingPercentEncoding) {
        return resultString.stringByRemovingPercentEncoding;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [resultString stringByReplacingPercentEscapesUsingEncoding:encoding];
#pragma clang diagnostic pop
    }
}

- (NSString *)lf_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)lf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = @{}.mutableCopy;
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return CGSizeCeil(result);
}

- (CGFloat)lf_widthForFont:(UIFont *)font {
    CGSize size = [self lf_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self lf_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGFloat)heightForString:(NSString *)str font:(UIFont *)font width:(CGFloat)width {
    CGFloat height;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{ NSFontAttributeName: font } context:nil];
        height = rect.size.height;
        height += 1;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        height = size.height;
    }
    return height;
}

- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width line:(NSInteger)line {
    NSMutableString *test = NSMutableString.new;
    for (int i=0; i<line; i++) {
        [test appendString:@"字"];
    }
    CGFloat maxHeight = [self heightForString:test font:font width:1];
    CGFloat height = [self heightForString:self font:font width:width];
    return height > maxHeight ? maxHeight : height;
}

- (BOOL)lf_matchesRegex:(NSString *)regex {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+LFAdd create regex error: %@", error);
        return NO;
    }
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)lf_enumerateRegexMatches:(NSString *)regex usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray *matches = [pattern matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    if (matches.count > 0) {
        [matches enumerateObjectsUsingBlock: ^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
            block([self substringWithRange:result.range], idx, result.range, stop);
        }];
    }
}

- (void)lf_enumerateRegexMatches:(NSString *)regex caseInsensitive:(BOOL)caseIns usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block {
    NSRegularExpressionOptions op = NSRegularExpressionAnchorsMatchLines;
    if (caseIns) {
        op |= NSRegularExpressionCaseInsensitive;
    }
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:op error:nil];
    NSArray *matches = [pattern matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    if (matches.count > 0) {
        [matches enumerateObjectsUsingBlock: ^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
            block([self substringWithRange:result.range], idx, result.range, stop);
        }];
    }
}

- (NSString *)lf_stringByReplacingRegex:(NSString *)regex withString:(NSString *)replacement {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+LFAdd create regex error: %@", error);
        return nil;
    }
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

- (BOOL)lf_containsEmoji {
    return [self lf_containsCharacterSet:[NSCharacterSet lf_emojiCharacterSet]];
}

+ (NSString *)lf_allEmoji {
    static NSMutableString *str = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        str = @"".mutableCopy;
        NSArray *keys = @[@"people", @"nature", @"object", @"places", @"symbols"];
        for (NSString *key in keys) {
            [str appendString:[self lf_allEmojiByGroup:key]];
        }
    });
    return str;
}

+ (NSString *)lf_allEmojiByGroup:(NSString *)group {
    static NSDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                @"people" : @"😄😃😀😊☺️😉😍😘😚😗😙😜😝😛😳😁😔😌😒😞😣😢😂😭😪😥😰😅😓😩😫😨😱😠😡😤😖😆😋😷😎😴😵😲😟😦😧😈👿😮😬😐😕😯😶😇😏😑👲👳👮👷💂👶👦👧👨👩👴👵👱👼👸😺😸😻😽😼🙀😿😹😾👹👺🙈🙉🙊💀👽💩🔥✨🌟💫💥💢💦💧💤💨👂👀👃👅👄👍👎👌👊✊✌️👋✋👐👆👇👉👈🙌🙏☝️👏💪🚶🏃💃👫👪👬👭💏💑👯🙆🙅💁🙋💆💇💅👰🙎🙍🙇🎩👑👒👟👞👡👠👢👕👔👚👗🎽👖👘👙💼👜👝👛👓🎀🌂💄💛💙💜💚❤️💔💗💓💕💖💞💘💌💋💍💎👤👥💬👣💭",
                @"nature": @"🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐽🐮🐗🐵🐒🐴🐑🐘🐼🐧🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩🐾💐🌸🌷🍀🌹🌻🌺🍁🍃🍂🌿🌾🍄🌵🌴🌲🌳🌰🌱🌼🌐🌞🌝🌚🌑🌒🌓🌔🌕🌖🌗🌘🌜🌛🌙🌍🌎🌏🌋🌌🌠⭐️☀️⛅️☁️⚡️☔️❄️⛄️🌀🌁🌈🌊",
                @"object" : @"🎍💝🎎🎒🎓🎏🎆🎇🎐🎑🎃👻🎅🎄🎁🎋🎉🎊🎈🎌🔮🎥📷📹📼💿📀💽💾💻📱☎️📞📟📠📡📺📻🔊🔉🔈🔇🔔🔕📢📣⏳⌛️⏰⌚️🔓🔒🔏🔐🔑🔎💡🔦🔆🔅🔌🔋🔍🛁🛀🚿🚽🔧🔩🔨🚪🚬💣🔫🔪💊💉💰💴💵💷💶💳💸📲📧📥📤✉️📩📨📯📫📪📬📭📮📦📝📄📃📑📊📈📉📜📋📅📆📇📁📂✂️📌📎✒️✏️📏📐📕📗📘📙📓📔📒📚📖🔖📛🔬🔭📰🎨🎬🎤🎧🎼🎵🎶🎹🎻🎺🎷🎸👾🎮🃏🎴🀄️🎲🎯🏈🏀⚽️⚾️🎾🎱🏉🎳⛳️🚵🚴🏁🏇🏆🎿🏂🏊🏄🎣☕️🍵🍶🍼🍺🍻🍸🍹🍷🍴🍕🍔🍟🍗🍖🍝🍛🍤🍱🍣🍥🍙🍘🍚🍜🍲🍢🍡🍳🍞🍩🍮🍦🍨🍧🎂🍰🍪🍫🍬🍭🍯🍎🍏🍊🍋🍒🍇🍉🍓🍑🍈🍌🍐🍍🍠🍆🍅🌽",
                @"places" : @"🏠🏡🏫🏢🏣🏥🏦🏪🏩🏨💒⛪🏬🏤🌇🌆🏯🏰⛺🏭🗼🗾🗻🌄🌅🌃🗽🌉🎠🎡⛲🎢🚢⛵🚤🚣⚓🚀✈💺🚁🚂🚊🚉🚞🚆🚄🚅🚈🚇🚝🚋🚃🚎🚌🚍🚙🚘🚗🚕🚖🚛🚚🚨🚓🚔🚒🚑🚐🚲🚡🚟🚠🚜💈🚏🎫🚦🚥⚠🚧🔰⛽🏮🎰♨🗿🎪🎭📍🚩🇯🇵🇰🇷🇩🇪🇨🇳🇺🇸🇫🇷🇪🇸🇮🇹🇷🇺🇬🇧",
                @"symbols":@"1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣0️⃣🔟🔢🔣⬆⬇⬅➡🔠🔡🔤↗️↖️↘️↙️↔️↕️🔄◀▶🔼🔽↩↪ℹ⏪⏩⏫⏬⤵⤴🆗🔀🔁🔂🆕🆙🆒🆓🆖📶🎦🈁🈯🈳🈵🈴🈲🉐🈹🈺🈶🈚🚻🚹🚺🚼🚾🚰🚮🅿♿🚭🈷🈸🈂Ⓜ🛂🛄🛅🛃🉑㊙㊗🆑🆘🆔🚫🔞📵🚯🚱🚳🚷🚸⛔✳❇❎✅✴💟🆚📳📴🅰🅱🆎🅾💠➿♻♈♉♊♋♌♍♎♏♐♑♒♓⛎🔯🏧💹💲💱©®™❌‼️⁉️❗❓❕❔⭕🔝🔚🔙🔛🔜🔃🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦✖️➕➖➗♠️♥️♣️♦️💮💯✔️☑️🔘🔗➰〰〽️🔱◼️◻️◾️◽️▪️▫️🔺🔲🔳⚫️⚪️🔴🔵🔻⬜️⬛️🔶🔷🔸🔹"
                };
    });
    return group ? dic[group] : nil;
}

+ (NSArray *)lf_allEmojiArray {
    static NSMutableArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[].mutableCopy;
        NSArray *keys = @[@"people", @"nature", @"object", @"places", @"symbols"];
        for (NSString *key in keys) {
            NSArray *one = [self lf_allEmojiArrayByGroup:key];
            [arr addObjectsFromArray:one];
        }
    });
    return arr;
}

+ (NSArray *)lf_allEmojiArrayByGroup:(NSString *)group {
    static NSMutableDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{}.mutableCopy;
        NSArray *keys = @[@"people", @"nature", @"object", @"places", @"symbols"];
        for (NSString *key in keys) {
            NSMutableArray *arr = @[].mutableCopy;
            NSString *str = [self lf_allEmojiByGroup:key];
            [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                [arr addObject:substring];
            }];
            
            /* Flag emoji may be broken during enumerate, fix it.
             */
            if ([@"places" isEqualToString:key]) {
                for (int i = 0; i < 20; i++) {
                    [arr removeLastObject];
                }
                [arr addObject:@"🇯🇵"];
                [arr addObject:@"🇰🇷"];
                [arr addObject:@"🇩🇪"];
                [arr addObject:@"🇨🇳"];
                [arr addObject:@"🇺🇸"];
                [arr addObject:@"🇫🇷"];
                [arr addObject:@"🇪🇸"];
                [arr addObject:@"🇮🇹"];
                [arr addObject:@"🇷🇺"];
                [arr addObject:@"🇬🇧"];
            }
            dic[key] = arr;
        }
    });
    return group ? dic[group] : nil;
}

+ (NSString *)lf_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (NSString *)lf_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)lf_stringByAppendingNameScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)lf_stringByAppendingPathScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)lf_pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name lf_enumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$" usingBlock: ^(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

- (BOOL)lf_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)lf_containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)lf_containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)lf_numberValue {
    return [NSNumber lf_numberWithString:self];
}

- (NSData *)lf_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)lf_jsonValueDecoded {
    return [[self lf_dataValue] lf_jsonValueDecoded];
}

- (NSString *)lf_stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return str;
}

- (NSString *)lf_segmentString {
    NSMutableString *str = [NSMutableString stringWithString:self];
    NSInteger count = floorf((CGFloat)self.length / 3);
    if (self.length % 3 == 0) {
        count = floorf((CGFloat)self.length / 3) - 1;
    }
    for (int i = 0; i < count; i ++) {
        [str insertString:@"," atIndex: (str.length - (3*(i + 1) + i))];
    }
    
    return str;
}
@end
