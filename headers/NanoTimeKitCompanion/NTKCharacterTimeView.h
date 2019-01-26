#import "NTKTimeView-Protocol.h"
#import <QuartzCore/QuartzCore.h>

@interface NTKCharacterTimeView : UIView <NTKTimeView>
@property (assign,getter=isFrozen,nonatomic) BOOL frozen; 
- (void)_didEnterBackground;
- (void)_willEnterForeground;
- (void)setOverrideDate:(NSDate *)date;
- (void)scrubToDate:(NSDate *)date;
- (void)setClothingColor:(UIColor *)clothingColor andDesaturation:(CGFloat)desaturation;
// - (CAEAGLLayer *)layer;
- (void)setTimeOffset:(CGFloat)offset;
- (BOOL)isFrozen;
- (void)setFrozen:(BOOL)frozen;
- (void)setOverrideDate:(NSDate *)date duration:(CGFloat)duration;
@end
