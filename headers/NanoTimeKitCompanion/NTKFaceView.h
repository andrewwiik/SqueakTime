#import "NTKTimeView-Protocol.h"

@interface NTKFaceView : UIView
@property (assign, nonatomic) BOOL shouldShowUnsnapshotableContent;
@property (assign, nonatomic) NSInteger dataMode;
@property (assign, nonatomic) BOOL showsCanonicalContent;
@property (assign, nonatomic) BOOL showContentForUnadornedSnapshot;
@property (assign, nonatomic) BOOL showsLockedUI;
@property (nonatomic,retain) UIView<NTKTimeView> *timeView;
- (void)endScrubbingAnimated:(BOOL)animated;
- (void)setOverrideDate:(NSDate *)date duration:(CGFloat)duration;
- (void)scrubToDate:(NSDate *)date animated:(BOOL)animated;
@end
