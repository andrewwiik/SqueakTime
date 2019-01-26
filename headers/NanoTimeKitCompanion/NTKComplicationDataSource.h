#import "NTKComplication.h"
#import <ClockKit/defines.h>
#import <ClockKit/CLKComplicationTimelineEntry.h>
#import "NTKComplicationDataSourceDelegate-Protocol.h"

@interface NTKComplicationDataSource : NSObject
- (NTKComplication *)complication;
@property (nonatomic,readonly) NSInteger family;    
- (void)getSupportedTimeTravelDirectionsWithHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler;
- (void)getTimelineStartDateWithHandler:(/*^block*/id)arg1 ;
- (void)getTimelineEndDateWithHandler:(/*^block*/id)arg1 ;
- (void)getCurrentTimelineEntryWithHandler:(void (^)(CLKComplicationTimelineEntry *))handler;
- (void)getTimelineEntriesBeforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(/*^block*/id)arg3 ;
- (void)getTimelineEntriesAfterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(/*^block*/id)arg3 ;
+ (BOOL)acceptsComplicationFamily:(CLKComplicationFamily)family;
+ (BOOL)acceptsComplicationType:(NSUInteger)type;
-(id<NTKComplicationDataSourceDelegate>)delegate;
- (void)pause;
- (void)resume;
@end