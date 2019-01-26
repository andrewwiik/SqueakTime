#import "NTKFaceViewController.h"
#import "NTKFace.h"

@interface NTKCompanionFaceViewController : NTKFaceViewController
- (instancetype)initWithFace:(NTKFace *)face;
- (instancetype)initWithFace:(NTKFace *)face forEditing:(BOOL)editing;
@end