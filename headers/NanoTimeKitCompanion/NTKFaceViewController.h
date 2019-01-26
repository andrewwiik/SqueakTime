#import "NTKFace.h"
#import "NTKFaceView.h"

@interface NTKFaceViewController : UIViewController
@property (assign,nonatomic) BOOL shouldShowSnapshot;
@property (assign,nonatomic) BOOL supressesNonSnapshotUI;
@property (assign,nonatomic) NSInteger dataMode;
@property (nonatomic,retain) NSDate * pauseDate;
@property (assign,nonatomic) BOOL showsCanonicalContent;
@property (assign,nonatomic) BOOL showContentForUnadornedSnapshot;
@property (assign,nonatomic) BOOL showsLockedUI;
@property (nonatomic,readonly) NTKFace * face;
@property (nonatomic,readonly) NTKFaceView * faceView;
- (void)freeze;
- (void)unfreeze;
- (void)_ensureNotLive;
- (void)_setDataMode:(NSInteger)dataMode becomeLiveOnUnfreeze:(BOOL)becomeLive;
- (void)_ensurePauseDate;
- (void)freezeAfterDelay:(CGFloat)delay;
- (void)setDataMode:(NSInteger)dataMode;
- (void)enableSlowMode;
- (void)disableSlowMode;
@end