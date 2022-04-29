//
//  GCAVIFImageProvider.m
//  QQHippy
//
//  Created by ericbbpeng(彭博斌) on 2021/9/14.
//

#import "GCAVIFImageProvider.h"
#import "GCAVIFDecoder.h"

@interface GCAVIFImageProvider () {
    NSData *_data;
    UIImage *_image;
    GCAVIFDecoder *_decoder;
}

@end

@implementation GCAVIFImageProvider

HIPPY_EXPORT_MODULE(avifImageProvider)

+ (BOOL)canHandleData:(NSData *)data {
    BOOL canHandle = [GCAVIFDecoder isAVIFFormatForData:data];
    return canHandle;
}

+ (BOOL)isAnimatedImage:(NSData *)data {
    BOOL isAnimated = [GCAVIFDecoder isAnimatedImageForData:data];
    return isAnimated;
}

+ (NSUInteger)priorityForData:(NSData *)data {
    return 1;
}

+ (instancetype)imageProviderInstanceForData:(NSData *)data {
    return [[[self class] alloc] initWithData:data];
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        _data = data;
        _decoder = [[GCAVIFDecoder alloc] initWithAnimatedImageData:_data];
    }
    return self;
}

- (UIImage *)image {
    if (!_image) {
        GCAVIFDecoder *decoder = [[GCAVIFDecoder alloc] init];
        _image = [decoder decodedImageWithData:_data];
    }
    return _image;
}

/** return frame count for animated image
 */
- (NSUInteger)imageCount{
    return _decoder.frameCount;
}

/** return frame at index
 */
- (UIImage *)imageAtFrame:(NSUInteger)frame{
    NSLog(@"avif load time %f for frame %d for self %p", CACurrentMediaTime(), frame, self);
    return [_decoder animatedImageFrameAtIndex:frame];
}

/**return animated image loop count
 *  return 0 means loop forever
 */
- (NSUInteger)loopCount{
    return _decoder.loopCount;
}

/** delay time for frame at index
 */
- (NSTimeInterval)delayTimeAtFrame:(NSUInteger)frame{
    NSTimeInterval delayTime = [_decoder animatedImageDurationAtIndex:frame];
    return delayTime;
}

@end
