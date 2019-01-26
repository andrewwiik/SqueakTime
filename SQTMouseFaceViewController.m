#import "SQTMouseFaceViewController.h"
@implementation SQTMouseFaceViewController

+ (instancetype)initWithFilePath:(NSString *)path {
	NSDictionary *faceData = [NSDictionary dictionaryWithContentsOfFile:path];
	NTKFace *face = [NSClassFromString(@"NTKFace") faceWithJSONObjectRepresentation:faceData];
	SQTMouseFaceViewController *controller = [[SQTMouseFaceViewController alloc] init];
	controller.faceController = [[NSClassFromString(@"NTKCompanionFaceViewController") alloc] initWithFace:face forEditing:false];
	return controller;
}

- (id)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (id)initWithMouseType:(NSInteger)mouseType {
	self = [self init];
	if (self) {
		NTKFace *face;
		if (mouseType == 0) { // Mickey
			//face = [[NSClassFromString(@"NTKCGalleryCollection") _mickeyAndMinnieFaces] faceAtIndex:0];
			face = [NSClassFromString(@"NTKFace") defaultFaceOfStyle:10];
		} else {
			face = [[NSClassFromString(@"NTKCGalleryCollection") _mickeyAndMinnieFaces] faceAtIndex:1];
		}


		self.faceController = [[NSClassFromString(@"NTKCompanionFaceViewController") alloc] initWithFace:face forEditing:false];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if (self.faceController) {
		self.clipView = [[UIView alloc] initWithFrame:self.view.bounds];
		[self.view addSubview:self.clipView];
		[self.clipView addSubview:self.faceController.view];
		[self addChildViewController:self.faceController];
		[self.faceController didMoveToParentViewController:self];
		CGRect origFaceFrame = self.faceController.view.frame;
		origFaceFrame.origin = CGPointMake(0,0);
		self.faceController.view.frame = origFaceFrame;
		@try {
			[self.faceController _setDataMode:1 becomeLiveOnUnfreeze:TRUE];
		} @catch (NSException *e) {

		}

		@try {
			[self.faceController _setDataMode:1 becomeLiveOnUnfreeze:TRUE];
		} @catch (NSException *e){

		}

		@try {
			[self setRightDateOnWatchFace];
		} @catch (NSException *e) {

		}

		@try {
			[self.faceController unfreeze];
		} @catch (NSException *e) {

		}
	}

}

- (void)setRightDateOnWatchFace {
	if (self.faceController) {
		//[self.faceController unfreeze];
		//[[[self.faceController faceView] timeView] setOverrideDate:[NSDate date] duration:10.0];
		[(NTKCharacterTimeView *)[[self.faceController faceView] timeView] setOverrideDate:[NSDate date]];
	}
}

- (void)watchScrubToCurrentDate {
	if (self.faceController) {
		[[self.faceController faceView] scrubToDate:[NSDate date] animated:NO];
	}
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
}

- (void)writeToFile:(NSString *)path {
	NTKFace *face = self.faceController.face;
	NSMutableDictionary *faceJSON = [face JSONObjectRepresentation];
	[faceJSON setObject:[NSMutableDictionary new] forKey:@"complications"];
	[faceJSON writeToFile:path atomically:YES];
	// if ([faceJSON objectForKey:@"complications"]) {
	// 	NSMutableDictionary *complications = [faceJSON objectForKey:@"complications"];
	// 	[complications removeAllObjects];
	// }


}
@end