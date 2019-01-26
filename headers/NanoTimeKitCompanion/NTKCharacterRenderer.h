@interface NTKCharacterRenderer : NSObject
@property (readonly) UIColor *clothingColor;
- (void)deactivate;
- (BOOL)active;
- (void)render;
- (void)prepareToZoom;
- (void)cleanupAfterZoom;
- (void)scrubToDate:(NSDate *)date;
- (void)_updateTimeVariables;
- (void)_resetTimeVariable;
- (void)setClothingColor:(UIColor *)clothingColor andDesaturation:(CGFloat)desaturation;
- (void)forceUpdateTimeVariables;
- (void)setBackgroundBrightness:(CGFloat)brightness;
- (void)_applyClothingColor;
@end