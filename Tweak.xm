#import <Foundation/Foundation.h>
#import <Foundation/NSDistributedNotificationCenter.h>
#import <NanoTimeKitCompanion/NTKFaceView.h>
#import <NanoTimeKitCompanion/NTKCompanionFaceViewController.h>
#import <NanoTimeKitCompanion/NTKCGalleryCollection.h>
#import <NanoTimeKitCompanion/NTKCharacterRenderer.h>
#import "SQTMouseFaceViewController.h"
#import <NanoTimeKitCompanion/NTKComplicationDataSource.h>
#import <ClockKit/CLKSimpleTextProvider.h>
#import <ClockKit/CLKComplicationTemplateUtilitarianLargeFlat.h>
#import <MediaRemote/MediaRemote+Private.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <SpriteKit/SpriteKit.h>
#import <NanoTimeKitCompanion/NTKCharacterTimeView.h>
#import <notify.h>
#ifdef __cplusplus
extern "C" {
#endif

CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

#ifdef __cplusplus
}
#endif



static NSString *nsDomainString = @"com.atwiiks.squeaktime";

@interface NSUserDefaults (SqeuakTime)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end
@interface FBSystemService : NSObject
+ (id)sharedInstance;
- (void)exitAndRelaunch:(BOOL)arg1;
@end
@interface SpringBoard : NSObject
- (void)_relaunchSpringBoardNow;
+ (id)sharedInstance;
- (id)_accessibilityFrontMostApplication;
- (void)clearMenuButtonTimer;
@end

static BOOL tweakIsEnabled = TRUE;

%group FaceFixHooks
%hook NTKDate
+ (id)faceDate {
	return [NSDate date];
}
%end

%hook CLKDate
+ (id)unmodifiedDate {
	return [NSDate date];
}
+ (id)date {
	return [NSDate date];
}
+ (id)complicationDate {
	return [NSDate date];
}
%end

@interface NTKCharacterRenderer (Priv)
- (id)_overrideDateWatch;
- (BOOL)sayCheeseWatch;
- (BOOL)isApplyingTimeWarp;
@end

%hook NTKCharacterRenderer 
- (void)scrubToDate:(NSDate *)date {
	[self forceUpdateTimeVariables];
}

- (void)render {
	MSHookIvar<id>(self,"_overrideDate") = nil;
	MSHookIvar<BOOL>(self,"_animatingIntoOrb") = FALSE;
	MSHookIvar<BOOL>(self,"_sayCheese") = FALSE;
	MSHookIvar<BOOL>(self,"_applyInstantTimeWarp") = FALSE;
	%orig;
}

%new
- (id)_overrideDateWatch {
	return MSHookIvar<id>(self,"_overrideDate");
}

%new
- (BOOL)sayCheeseWatch {
	return MSHookIvar<BOOL>(self,"_sayCheese");
}

%new
- (BOOL)isApplyingTimeWarp {
	return MSHookIvar<BOOL>(self,"_applyInstantTimeWarp");
}
%end

@interface NTKCharacterRendererMickey : NTKCharacterRenderer
@end

%hook NTKCharacterRendererMickey
%new
- (id)_overrideDateWatch1 {
	return [self _overrideDateWatch];
}

%new
- (BOOL)sayCheeseWatch1 {
	return [self sayCheeseWatch];
}

%new
- (BOOL)isApplyingTimeWarp1 {
	return [self isApplyingTimeWarp];
}
%end

extern "C" BOOL NTKFaceStyleIsAvailable(int);
%hookf(BOOL, NTKFaceStyleIsAvailable, int style){
	return YES;
}
%end



%group SpringBoard
 NTKCompanionFaceViewController *sharedFaceController;
%hook UIViewController

%new
- (void)addWatchViewFromPath:(NSString *)path {
	if (NSClassFromString(@"NTKCompanionFaceViewController")) {
		SQTMouseFaceViewController *faceController = [SQTMouseFaceViewController initWithFilePath:path];
		[self.view addSubview:faceController.view];
		faceController.view.frame = CGRectMake(0,0,136,170);
		[self addChildViewController:faceController];
		[faceController didMoveToParentViewController:self];
		// [NSClassFromString(@"NTKFace") defaultFaceOfStyle:10]

		// sharedFaceController = [[NSClassFromString(@"NTKCompanionFaceViewController") alloc] initWithFace:[[NSClassFromString(@"NTKCGalleryCollection") _zeusFaces] faceAtIndex:0] forEditing:false];
		// 				UIView *clipView = [[UIView alloc] initWithFrame:CGRectMake(0,0,136,136)];
		// 				[self.view addSubview:clipView];
		// 				clipView.clipsToBounds = YES;

		// 				[clipView addSubview:sharedFaceController.view];
		// 		[self addChildViewController:sharedFaceController];
		// 		[sharedFaceController didMoveToParentViewController:self];
		// 		// [sharedFaceController unfreeze]; 
		// 		sharedFaceController.view.frame = CGRectMake(0, -17, 136,170);
				// return sharedFaceController;
	}
}
%new
- (id)addWatchView {
	// NSString *fullPath = [NSString stringWithFormat:@"/System/Library/PrivateFrameworks/NanoTimeKitCompanion.framework"];
	// NSBundle *bundle = [NSBundle bundleWithPath:fullPath];
	// if (!bundle.loaded) {
	// 	[bundle load];
	// }
	if (NSClassFromString(@"NTKCompanionFaceViewController")) {
		SQTMouseFaceViewController *faceController = [[SQTMouseFaceViewController alloc] initWithMouseType:0];
		[self.view addSubview:faceController.view];
		faceController.view.frame = CGRectMake(0,0,136,170);
		[self addChildViewController:faceController];
		[faceController didMoveToParentViewController:self];
		return faceController;
		// [NSClassFromString(@"NTKFace") defaultFaceOfStyle:10]

		// sharedFaceController = [[NSClassFromString(@"NTKCompanionFaceViewController") alloc] initWithFace:[[NSClassFromString(@"NTKCGalleryCollection") _zeusFaces] faceAtIndex:0] forEditing:false];
		// 				UIView *clipView = [[UIView alloc] initWithFrame:CGRectMake(0,0,136,136)];
		// 				[self.view addSubview:clipView];
		// 				clipView.clipsToBounds = YES;

		// 				[clipView addSubview:sharedFaceController.view];
		// 		[self addChildViewController:sharedFaceController];
		// 		[sharedFaceController didMoveToParentViewController:self];
		// 		// [sharedFaceController unfreeze]; 
		// 		sharedFaceController.view.frame = CGRectMake(0, -17, 136,170);
				// return sharedFaceController;
	}
	return nil;
	// if (NSClassFromString(@"NTKUtilitarianNumbersFaceView")) {
	// 	UIView *faceView = [[NSClassFromString(@"NTKUtilitarianNumbersFaceView") alloc] initWithFace:[NSClassFromString(@"NTKFace") defaultFaceOfStyle:3] forEditing:false];

	// }
}

%new
- (void)addWatchViewDelayed {
	[self performSelector:@selector(addWatchView) withObject:nil afterDelay:10.0];
}

// %new
// - (void)setRightDateOnWatchFace {
// 	if (sharedFaceController) {
// 		[sharedFaceController unfreeze];
// 		[[[sharedFaceController faceView] timeView] setOverrideDate:[NSDate date] duration:10.0];
// 		[[[sharedFaceController faceView] timeView] setOverrideDate:[NSDate date]];
// 	}
// }

// %new
// - (void)watchScrubToCurrentDate {
// 	if (sharedFaceController) {
// 		//[[sharedFaceController faceView] scrubToDate:[NSDate date] animated:NO];
// 	}
// }
%end

// %hook NTKFaceView
// -(void)setOverrideDate:(NSDate *)date duration:(CGFloat)duration {
// 	%orig([NSDate date], duration);
// }
// %end

// @interface NTKCharacterRenderer : NSObject
// - (void)forceUpdateTimeVariables;
// - (void)scrubToDate:(NSDate *)date;
// - (void)render;
// @end


%hook NTKCompanionFaceViewController
- (void)freeze {
	return [self unfreeze];
}

// // - (void)setDataMode:(NSInteger)mode {
// // 	[self unfreeze];
// // 	%orig(1);
// // }

// // - (NSInteger)dataMode {
// // 	return 1;
// // } z

// // _NTKFaceStyleIsAvailable
%end

@interface NRDevice : NSObject <NSSecureCoding>
-(id)initWithCoder:(id)arg1 ;
-(void)encodeWithCoder:(id)arg1 ;
+ (NRDevice *)loadDeviceFromFile;
- (void)writeToFile;
@end

@interface NRFrameworkDevice : NRDevice
-(id)initWithDevice:(id)arg1 deviceID:(id)arg2 queue:(id)arg3 ;
@end

%hook NRDevice
%new
- (void)writeToFile {
	NSMutableData *pData = [[NSMutableData alloc]init];

    NSString *path = @"/var/mobile/Library/Preferences/SqueakTimeWatchData.plist";

    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:pData];
    [self encodeWithCoder:archiver];
    [archiver finishEncoding];
    [pData writeToFile:path atomically:YES];
}

%new
+ (id)loadDeviceFromFile {
	NSString* path = @"/var/mobile/Library/Preferences/SqueakTimeWatchData.plist";
    //NSLog(path);
    NSMutableData *pData = [[NSMutableData alloc]initWithContentsOfFile:path];

    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:pData];
   	NRDevice *data = [[NSClassFromString(@"NRDevice") alloc]initWithCoder:unArchiver];
    //NSLog(@"%@",data.firstName);
    [unArchiver finishDecoding];
    return data;
}
%end


// %sublcass SQTMessagesComplicationDataSource : NTKComplicationDataSource

// - (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
//     handler(CLKComplicationTimeTravelDirectionNone);
//     return;
// }

// -(void)getCurrentTimelineEntryWithHandler:(void (^)(CLKComplicationTimelineEntry *))handler {
// 	handler(nil);
// }

// // %ho
%end


%group DataSources
@interface NTKWorkoutComplicationDataSource : NSObject
+ (id)_unknownTemplateForFamily:(NSInteger)arg2;
@end

@interface SQTMessagesComplicationDataSource : NTKComplicationDataSource
- (void)_invalidate;
@end

%hook NTKComplicationDataSource
- (void)getSupportedTimeTravelDirectionsWithHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionNone);
}
-(void)getCurrentTimelineEntryWithHandler:(void (^)(CLKComplicationTimelineEntry *))handler {
	handler(nil);
}
%end

%subclass SQTMessagesComplicationDataSource : NTKComplicationDataSource


- (SQTMessagesComplicationDataSource *)initWithComplication:(id)arg1 family:(NSInteger)arg2 {
	SQTMessagesComplicationDataSource *source = %orig;
	// [NSTimer scheduledTimerWithTimeInterval:5.0f 
	// target:self selector:@selector(_invalidate) userInfo:nil repeats:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(_invalidate)
    name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification
    object:nil];
	return source;
}
- (void)getSupportedTimeTravelDirectionsWithHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionNone);
    return;
}

-(void)getCurrentTimelineEntryWithHandler:(void (^)(CLKComplicationTimelineEntry *))handler {

	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
      NSDictionary *dict=(__bridge NSDictionary *)(information);
      NSString *titleText = @"---";

      if(dict != NULL && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle]!= NULL ){
          if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] != nil) {
                      titleText = [[NSString alloc] initWithString:[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle]];
                     // self.titleLabel.text = titleText;
          }
      }

      CLKComplicationTemplateUtilitarianLargeFlat *template1 = [[NSClassFromString(@"CLKComplicationTemplateUtilitarianLargeFlat") alloc] init];
	
	template1.textProvider = [NSClassFromString(@"CLKSimpleTextProvider") textProviderWithText:titleText];
	CLKComplicationTimelineEntry *entry = [NSClassFromString(@"CLKComplicationTimelineEntry") entryWithDate:[NSDate date] complicationTemplate:template1];
	handler(entry);
  });
}

- (id)currentSwitcherTemplate {
	return [NSClassFromString(@"NTKWorkoutComplicationDataSource") _unknownTemplateForFamily:[self family]];
}

- (id)lockedTemplate {
	return [NSClassFromString(@"NTKWorkoutComplicationDataSource") _unknownTemplateForFamily:[self family]];
}

%new
-(void)_invalidate {
	if ([self delegate]) {
    	[[self delegate] invalidateEntries];
    }
    return;
}

- (void)resume {
	[self _invalidate];
}

- (void)pause {

}

- (void)_deactivate {
	%orig;
	[[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(_invalidate)
    name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification
    object:nil];
}


// %ho
%end

// %hook NTKComplicationDataSource
// +(Class)dataSourceClassForComplicationType:(unsigned long long)type family:(long long)family {
// 	if (type == 8 && family == 3) {
// 		return NSClassFromString(@"SQTMessagesComplicationDataSource");
// 	}
// 	return %orig;
// }
// %end

%hook NTKCompanionFaceViewController
%new
- (void)saveToPath:(NSString *)path {
	NTKFace *face = self.face;
	NSMutableDictionary *faceJSON = [face JSONObjectRepresentation];
	[faceJSON setObject:[NSMutableDictionary new] forKey:@"complications"];
	[faceJSON writeToFile:path atomically:YES];
}
%end
%end

%group JustForSpringBoard

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber* enabledOpt = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"isEnabled" inDomain:nsDomainString];

	tweakIsEnabled = (enabledOpt) ? [enabledOpt boolValue] : YES;
	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"com.atwiiks.squeaktime/settingschanged"]
                                                    object:nil
                                                  userInfo:nil];
}

@interface NTKAnalogFaceView : UIView
@property (nonatomic, retain) UIView *contentView;
@end

%hook NTKAnalogFaceView
- (void)layoutSubviews {
	if (self.contentView) {
		[self.contentView setBackgroundColor:[UIColor clearColor]];
	}
	%orig;
}
%end

@interface NTKAnalogScene : SKScene
- (void)setBackgroundColor:(UIColor *)color;
- (void)_updateTickColors;
@property (nonatomic, retain) SKNode *background;
@end


%hook NTKAnalogScene

// - (UIColor *)faceColor {
// 	return [UIColor clearColor];
// }

- (UIColor *)backgroundColor {
	return [UIColor clearColor];
}
// - (void)setFaceColor:(UIColor *)color {
// 	%orig([UIColor clearColor]);
// 	//[self _updateTickColors];
// }

- (void)setBackgroundColor:(UIColor *)color {
	%orig([UIColor clearColor]);
	//[self _updateTickColors];

}
%end

%hook SKView
- (void)setBackgroundColor:(UIColor *)color {
	if (self.scene && [self.scene isKindOfClass:NSClassFromString(@"NTKAnalogScene")]) {
		color = [UIColor clearColor];
		self.allowsTransparency = YES;
	}
	%orig(color);
}

- (void)layoutSubviews {
	if (self.scene && [self.scene isKindOfClass:NSClassFromString(@"NTKAnalogScene")]) {
		[self setBackgroundColor:[UIColor clearColor]];
		self.allowsTransparency = YES;
		NTKAnalogScene *scene = (NTKAnalogScene *)self.scene;
		[scene _updateTickColors];
		if (self.frame.size.height != self.frame.size.width && [self superview]) {
			CGRect frame= self.frame;
			frame.size.height = frame.size.width;
			frame.origin.y = ([self superview].frame.size.height - frame.size.height)/2;
			self.frame = frame;
		}
		//scene.background.fillColor = [UIColor clearColor];
	}
	%orig;
}

- (void)renderContent {
	if (self.scene && [self.scene isKindOfClass:NSClassFromString(@"NTKAnalogScene")]) {
		[self setBackgroundColor:[UIColor clearColor]];
		self.allowsTransparency = YES;
		NTKAnalogScene *scene = (NTKAnalogScene *)self.scene;
		[scene _updateTickColors];
	}
	%orig;
}

- (UIColor *)backgroundColor {
	if (self.scene && [self.scene isKindOfClass:NSClassFromString(@"NTKAnalogScene")]) {
		return [UIColor clearColor];
	}
	return %orig;
}

%new
- (void)attributeFromBG {
	NTKAnalogScene *scene = (NTKAnalogScene *)self.scene;
	scene.background.alpha = 0.5;
	[scene.background removeAllChildren];
	// return scene.background.
	// return [scene.background attributeValues];
}

// %new
// - (void)performSelectorOnBG:(NSString *)selector {
// 	NTKAnalogScene *scene = (NTKAnalogScene *)self.scene;
// 	SuppressPerformSelectorLeakWarning(
// 		[scene.background performSelector:NSSelectorFromString(selector) withObject:nil];
// 	);

// 	// scene.background.alpha = 0.5;
// }
%end

%hook NTKCharacterTimeView
- (void)layoutSubviews {
	self.opaque = NO;
	self.layer.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
	self.layer.backgroundColor = [[UIColor clearColor] CGColor];
	%orig;
}
%end

@interface NTKContainerView : UIView
@end

// %hook NTKContainerView
// - (void)layoutSubviews {
// 	self.hidden = YES;
// 	self.alpha = 0;
// 	%orig;
// }
// %end
// %hook NTKComplicationDataSource
// +(Class)dataSourceClassForComplicationType:(unsigned long long)type family:(long long)family {
// 	if (type == 8 && family == 3) {
// 		return NSClassFromString(@"SQTMessagesComplicationDataSource");
// 	}
// 	return %orig;
// }
// %end

%hook NTKLocalTimelineComplicationController
- (void)_activate {
	if (MSHookIvar<id>(self,"_dataSource")) {
		NSObject *datasource = MSHookIvar<id>(self,"_dataSource");
		if ([datasource respondsToSelector:@selector(getSupportedTimeTravelDirectionsWithHandler:)]) {
			MSHookIvar<BOOL>(self,"_hasBeenLive") = YES;
			return;
		}
	}
	%orig;
	return;
}
%end


@interface SBFLockScreenDateView : UIView
@property (nonatomic, retain) UIView *watchFace;
@end

static BOOL isListeningForNotif = NO;

%hook SBFLockScreenDateView
%property (nonatomic, retain) UIView *watchFace;

-(id)initWithFrame:(CGRect)arg1 {
	id orig = %orig;
	if (isListeningForNotif == NO) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
                                    NULL,
                                    settingsChanged,
                                    (__bridge CFStringRef)[NSString stringWithFormat:@"com.atwiiks.squeaktime/settingschanged"],
                                    NULL,  
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

	isListeningForNotif = YES;
}

		[[NSNotificationCenter defaultCenter] addObserver:orig
	                                             selector:@selector(reloadWatchFace)
	                                             	 name:[NSString stringWithFormat:@"com.atwiiks.squeaktime/settingschanged"]
	                                           	   object:nil];
		return orig;
}

%new
- (void)reloadWatchFace {
	NSNumber* enabledOpt = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"isEnabled" inDomain:nsDomainString];

	tweakIsEnabled = (enabledOpt) ? [enabledOpt boolValue] : YES;
	if (self.watchFace) {
		[self.watchFace removeFromSuperview];
	}
	self.watchFace = nil;
	[self layoutSubviews];
}
- (void)layoutSubviews {

	NSString *watchFacePath = @"/var/mobile/Library/Preferences/SqueakTimeDefaultWatch.plist";
	if (tweakIsEnabled && [[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/SqueakTimeCurrentWatch.plist"]) {
		watchFacePath = @"/var/mobile/Library/Preferences/SqueakTimeCurrentWatch.plist";
	}
	if (tweakIsEnabled == YES && !self.watchFace && [[NSFileManager defaultManager] fileExistsAtPath:watchFacePath]) {
		SQTMouseFaceViewController *faceController = [SQTMouseFaceViewController initWithFilePath:watchFacePath];
		self.watchFace = faceController.view;

		[self addSubview:self.watchFace];
		//self.watchFace.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
		// self.watchFace.frame 
		self.watchFace.frame = CGRectMake(0,0,136,170);
		CGAffineTransform transform = CGAffineTransformMakeScale(0.85, 0.85);
		self.watchFace.transform = transform;
		// [self addChildViewController:faceController];
		// [faceController didMoveToParentViewController:self];
	}

	if (tweakIsEnabled == NO && self.watchFace) {
		[self.watchFace removeFromSuperview];
		self.watchFace = nil;
	}
	NSArray<UIView *> *subviews = [self subviews];

	if (self.watchFace) {

		self.watchFace.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 12);

		//NSArray<UIView *> *subviews = [self subviews];
		for (UIView *view in subviews) {
			if (view != self.watchFace) {
				view.hidden = YES;
				view.alpha = 0;
				//[view removeFromSuperview];
			}
		}
	} else {
		for (UIView *view in subviews) {
			view.alpha = 1;
			view.hidden = NO;
				//[view removeFromSuperview];
			//}
		}
	}
	%orig;
}
%end
%end

%group JustForWatchApp
@interface _NTKCDetailActionButton : UIButton
-(id)initWithFrame:(CGRect)arg1 ;
-(void)setHighlighted:(BOOL)arg1 ;
-(void)setEnabled:(BOOL)arg1 ;
-(void)setSelected:(BOOL)arg1 ;
-(BOOL)disabled;
-(void)_setTitle:(id)arg1 ;
-(void)setDisabled:(BOOL)arg1 forReason:(id)arg2 ;
-(NSString *)disabledReason;
-(void)_updateColor;
@end


@interface NTKCFaceDetailViewController : UIViewController
@property (nonatomic, retain) NTKFace *face;
@property (nonatomic, retain) _NTKCDetailActionButton *addButton;
@property (nonatomic, retain) _NTKCDetailActionButton *lockscreenButton;
@end

@interface HeaderViewThing : UIView
- (void)setInteractableSubviews:(NSArray *)thing;
@end



%hook NTKCFaceDetailViewController
%property (nonatomic, retain) _NTKCDetailActionButton *lockscreenButton;

- (void)viewDidLoad {
	%orig;
	if (self.addButton && !self.lockscreenButton) {
		self.lockscreenButton = [NSClassFromString(@"_NTKCDetailActionButton") new];
		[self.lockscreenButton _setTitle:@"Use on LockScreen"];
		[self.lockscreenButton setEnabled:TRUE];
		[self.lockscreenButton addTarget:self 
           action:@selector(useOnLockscreen)
 forControlEvents:UIControlEventTouchUpInside];
		// UIView *superview = [self.addButton superview];
		// [superview addSubview:self.lockscreenButton];
	}

	if (self.addButton && self.lockscreenButton) {
		CGRect lockscreenFrame = self.lockscreenButton.frame;
		CGRect frame = self.addButton.frame;
		lockscreenFrame.origin = frame.origin;
		lockscreenFrame.origin.y += frame.size.height + 15;
		self.lockscreenButton.frame = lockscreenFrame;
		[[self.addButton superview] addSubview:self.lockscreenButton];

	}

	if (self.addButton && self.lockscreenButton && [self.lockscreenButton superview] && [self.addButton superview]) {
		HeaderViewThing *headerView = MSHookIvar<HeaderViewThing *>(self,"_headerView");
		if (headerView) {
			[headerView setInteractableSubviews:[NSArray arrayWithObjects:self.addButton, self.lockscreenButton, nil]];
		}
		//[[self.addButton superview] addSubview:self.lockscreenButton];
	}
}

- (void)viewDidLayoutSubviews {
	%orig;
	if (self.addButton && self.lockscreenButton) {
		CGRect lockscreenFrame = self.lockscreenButton.frame;
		CGRect frame = self.addButton.frame;
		lockscreenFrame.origin = frame.origin;
		lockscreenFrame.origin.y += frame.size.height + 15;
		self.lockscreenButton.frame = lockscreenFrame;
		//[[self.addButton superview] addSubview:self.lockscreenButton];

	}
	//%orig;

}

%new
- (void)reactivateLockscreenButton {
	if (self.lockscreenButton) {
		[self.lockscreenButton setDisabled:FALSE forReason:nil];
		[self.lockscreenButton setEnabled:TRUE];
		//[self setDisabled:FALSE forReason:nil];
		[self.lockscreenButton _setTitle:@"Use on LockScreen"];
	}
}

%new
- (void)useOnLockscreen {
	NTKFace *face = self.face;
	NSMutableDictionary *faceJSON = [face JSONObjectRepresentation];
	[faceJSON setObject:[NSMutableDictionary new] forKey:@"complications"];
	[faceJSON writeToFile:@"/var/mobile/Library/Preferences/SqueakTimeCurrentWatch.plist" atomically:YES];
	notify_post([[NSString stringWithFormat:@"com.atwiiks.squeaktime/settingschanged"] UTF8String]);
	CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (__bridge CFStringRef)[NSString stringWithFormat:@"com.atwiiks.squeaktime/settingschanged"], nil, nil, true);
	if (self.lockscreenButton) {
		[self.lockscreenButton setEnabled:FALSE];
		[self.lockscreenButton setDisabled:TRUE forReason:@"Showing Done"];
		[self.lockscreenButton _setTitle:@"Done"];
		[NSTimer scheduledTimerWithTimeInterval:1.0f 
	target:self selector:@selector(reactivateLockscreenButton) userInfo:nil repeats:YES];

	}
}
%end
%end



static void respring() {
	SpringBoard *sb = (SpringBoard *)[UIApplication sharedApplication];
  	if ([sb respondsToSelector:@selector(_relaunchSpringBoardNow)]) {
    	[sb _relaunchSpringBoardNow];
  	} else if (%c(FBSystemService)) {
    	[[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
  	}
}


%ctor {
        @autoreleasepool {
        %init;
        if (NSClassFromString(@"SpringBoard") || NSClassFromString(@"COSPreferencesAppController")) {
        	NSString *fullPath = [NSString stringWithFormat:@"/System/Library/PrivateFrameworks/NanoTimeKitCompanion.framework"];
			NSBundle *bundle = [NSBundle bundleWithPath:fullPath];
			if (!bundle.loaded) {
				[bundle load];
			}
			%init(FaceFixHooks);
			// %init(SpringBoard);
			// %init(DataSources);
			if (NSClassFromString(@"SpringBoard")) {
			//	%init(JustForSpringBoard);
				NSNumber* enabledOpt = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"isEnabled" inDomain:nsDomainString];

				tweakIsEnabled = (enabledOpt) ? [enabledOpt boolValue] : YES;
				%init(SpringBoard);
				%init(JustForSpringBoard);
				CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)respring, CFSTR("com.atwiiks.squeaktime/respring"), NULL, 0);
				//%init(DataSources);
			}
			if (FALSE == TRUE) {
				%init(DataSources);
				//%init(JustForSpringBoard);
			}
			if (NSClassFromString(@"COSPreferencesAppController")) {
				%init(JustForWatchApp);
			}
        }
    }
}
