#import "NTKFaceView.h"
#import "NTKCharacterTimeView.h"

@interface NTKCharacterFaceView : NTKFaceView {
	NTKCharacterTimeView* _characterTimeView;
	UIView* _circleView;
	UIView* _handsView;
}
-(BOOL)_usesCustomZoom;
-(void)_applyDataMode;
-(void)_scrubToDate:(NSDate *)date animated:(BOOL)animated;
@end