@interface NTKComplication : NSObject
+ (instancetype)anyComplicationOfType:(NSUInteger)arg1 ;
+ (instancetype)nullComplication;
+ (instancetype)allComplicationsOfType:(NSUInteger)arg1 ;
+ (Class)_complicationClassForType:(NSUInteger)arg1 ;
+ (id)_allComplicationConfigurationsWithType:(NSUInteger)arg1 ;
+ (instancetype)complicationWithJSONObjectRepresentation:(id)arg1 ;
@property (nonatomic,readonly) NSUInteger complicationType;
@end