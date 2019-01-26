#include "SQTRootListController.h"
#import <notify.h>
#import <Preferences/PSSpecifier.h>
#import <notify.h>

#define kPrefsPath @"/var/mobile/Library/Preferences/"

@implementation SQTRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];
	NSString *path = [[kPrefsPath stringByAppendingString:specifier.properties[@"defaults"]] stringByAppendingString:@".plist"];

    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    
    if([defaults writeToFile:path atomically:YES])
    {
        //all good do nothing
    } else{
        //NSLog(@"FAILED WRITING SETTINGS");
    }
    
    CFStringRef toPost = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
    // [(__bridge NSString *)toPost UTF8String]
    notify_post([(__bridge NSString *)toPost UTF8String]);
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}


- (void)respring:(id)sender {
	notify_post("com.atwiiks.squeaktime/respring");
}
@end
