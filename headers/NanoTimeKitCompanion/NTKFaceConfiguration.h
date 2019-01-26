@interface NTKFaceConfiguration : NSObject {
	NSMutableDictionary *_editModeConfigurations;
}
@property (nonatomic,copy) NSString *name;
- (void)_enumerateEditModeConfigurationsWithBlock:(/*^block*/id)block;
@end