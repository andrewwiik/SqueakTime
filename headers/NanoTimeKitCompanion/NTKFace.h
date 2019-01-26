#import "NTKFaceConfiguration.h"

@interface NTKFace : NSObject
+ (instancetype)faceWithJSONObjectRepresentation:(id)representation;
+ (instancetype)sampleFaceOfStyle:(NSInteger)style differentFromFaces:(NSArray<NTKFace *> *)faces;
+ (instancetype)_sampleFaceDifferentFromFaces:(NSArray<NTKFace *> *)faces;
+ (instancetype)defaultFaceOfStyle:(NSInteger)style;
@property (nonatomic, readonly) NSInteger faceStyle;
@property (nonatomic, copy) NSString *name;
@property (assign, nonatomic) BOOL isLibraryFace;
@property (nonatomic,readonly) NTKFaceConfiguration *configuration;
- (NSMutableDictionary *)JSONObjectRepresentation;
@end