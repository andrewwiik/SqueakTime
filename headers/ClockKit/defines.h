#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLKComplicationFamily) {
    CLKComplicationFamilyModularSmall,
    CLKComplicationFamilyModularLarge,
    CLKComplicationFamilyUtilitarianSmall,
    CLKComplicationFamilyUtilitarianLarge,
    CLKComplicationFamilyCircularSmall,
};

typedef NS_OPTIONS(NSUInteger, CLKComplicationTimeTravelDirections) {
    CLKComplicationTimeTravelDirectionNone      = 0,
    CLKComplicationTimeTravelDirectionForward   = 1 << 0,
    CLKComplicationTimeTravelDirectionBackward  = 1 << 1,
};

typedef NS_ENUM(NSUInteger, CLKComplicationPrivacyBehavior) {
    CLKComplicationPrivacyBehaviorShowOnLockScreen,
    CLKComplicationPrivacyBehaviorHideOnLockScreen,
};

typedef NS_ENUM(NSInteger, CLKComplicationColumnAlignment)  {
    CLKComplicationColumnAlignmentLeft,
    CLKComplicationColumnAlignmentRight,
};

typedef NS_ENUM(NSInteger, CLKComplicationRingStyle)  {
    CLKComplicationRingStyleClosed,
    CLKComplicationRingStyleOpen,
};
