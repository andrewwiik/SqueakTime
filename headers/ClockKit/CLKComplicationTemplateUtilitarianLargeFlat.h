#import "CLKTextProvider.h"
#import "CLKImageProvider.h"
#import "CLKComplicationTemplate.h"

@interface CLKComplicationTemplateUtilitarianLargeFlat : CLKComplicationTemplate
@property (nonatomic,copy) CLKTextProvider * textProvider;                //@synthesize textProvider=_textProvider - In the implementation block
@property (nonatomic,copy) CLKImageProvider * imageProvider; 
@end