#import <Flutter/Flutter.h>

@interface FlutterVlcPlayerPlugin : NSObject<FlutterPlugin>
@end

@interface FLTPlayerView : NSObject<FlutterPlatformView>
+(instancetype) initWithView : (UIView *)view;
@end

@interface FLTPlayerViewFactory : NSObject<FlutterPlatformViewFactory>
+ (instancetype)initWithRegistrar : (NSObject<FlutterPluginRegistrar>*)registrar : (UIView *) view;
@end
