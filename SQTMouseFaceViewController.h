#import <NanoTimeKitCompanion/NTKFaceView.h>
#import <NanoTimeKitCompanion/NTKCompanionFaceViewController.h>
#import <NanoTimeKitCompanion/NTKCGalleryCollection.h>
#import <NanoTimeKitCompanion/NTKCharacterRenderer.h>
#import <NanoTimeKitCompanion/NTKCharacterTimeView.h>

@interface SQTMouseFaceViewController : UIViewController
@property (nonatomic, retain) UIView *clipView;
@property (nonatomic, retain) NTKCompanionFaceViewController *faceController;
+ (instancetype)initWithFilePath:(NSString *)path;
- (id)init;
- (id)initWithMouseType:(NSInteger)mouseType;
- (void)viewWillLayoutSubviews;
- (void)viewDidLoad;
@end