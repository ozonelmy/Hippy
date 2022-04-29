//
//  GCAVIFDecoder.m
//  QQGameCenterAVIF
//
//  Created by ericbbpeng(彭博斌) on 2021/9/13.
//

#import "GCAVIFDecoder.h"
#import "Conversion.h"

@interface GCAVIFDecoder () {
    avifDecoder *_decoder;
    NSData *_imageData;
//    NSLock *_lock;
}

@property (nonatomic, readwrite) NSUInteger loopCount;
@property (nonatomic, readwrite) NSUInteger frameCount;

@end

@implementation GCAVIFDecoder

#pragma mark - Static Image

+ (BOOL)isAVIFFormatForData:(NSData *)data{
    if (!data) {
        return NO;
    }
    if (data.length >= 12) {
        //....ftypavif ....ftypavis
        NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
        if ([testString isEqualToString:@"ftypavif"]
            || [testString isEqualToString:@"ftypavis"]) {
            return YES;
        }
    }
    return NO;
}

- (UIImage *)decodedImageWithData:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    // Decode it
    avifDecoder * decoder = avifDecoderCreate();
    avifDecoderSetIOMemory(decoder, data.bytes, data.length);
    // Disable strict mode to keep some AVIF image compatible
    decoder->strictFlags = AVIF_STRICT_DISABLED;
    avifResult decodeResult = avifDecoderParse(decoder);
    if (decodeResult != AVIF_RESULT_OK) {
        NSLog(@"Failed to decode image: %s", avifResultToString(decodeResult));
        avifDecoderDestroy(decoder);
        return nil;
    }
    
    // Static image
    if (decoder->imageCount <= 1) {
        avifResult nextImageResult = avifDecoderNextImage(decoder);
        if (nextImageResult != AVIF_RESULT_OK) {
            NSLog(@"Failed to decode image: %s", avifResultToString(nextImageResult));
            avifDecoderDestroy(decoder);
            return nil;
        }
        CGImageRef imageRef = SDCreateCGImageFromAVIF(decoder->image);
        if (!imageRef) {
            avifDecoderDestroy(decoder);
            return nil;
        }

        UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
        CGImageRelease(imageRef);
        avifDecoderDestroy(decoder);
        return image;
    }
    else {
        
    }
    return nil;
}

#pragma mark - Animated Image

+ (BOOL)isAnimatedImageForData:(NSData *)data{
    avifDecoder *decoder = avifDecoderCreate();
    avifDecoderSetIOMemory(decoder, data.bytes, data.length);
    decoder->strictFlags = AVIF_STRICT_DISABLED;
    avifResult decodeResult = avifDecoderParse(decoder);
    if (decodeResult != AVIF_RESULT_OK) {
        avifDecoderDestroy(decoder);
        NSLog(@"Failed to decode image: %s", avifResultToString(decodeResult));
        return NO;
    }
    NSUInteger frameCount = decoder->imageCount;
    avifDecoderDestroy(decoder);
    return frameCount > 1;
}

- (instancetype)initWithAnimatedImageData:(NSData *)data{
    self = [super init];
    if (self) {
        avifDecoder *decoder = avifDecoderCreate();
        avifDecoderSetIOMemory(decoder, data.bytes, data.length);
        // Disable strict mode to keep some AVIF image compatible
        decoder->strictFlags = AVIF_STRICT_DISABLED;
        avifResult decodeResult = avifDecoderParse(decoder);
        if (decodeResult != AVIF_RESULT_OK) {
            avifDecoderDestroy(decoder);
            NSLog(@"Failed to decode image: %s", avifResultToString(decodeResult));
            return nil;
        }
        _frameCount = decoder->imageCount;
        _loopCount = 0;
        _decoder = decoder;
        _imageData = data;
//        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)dealloc {
    if (_decoder) {
        avifDecoderDestroy(_decoder);
    }
}


- (NSTimeInterval)animatedImageDurationAtIndex:(NSUInteger)index {
    if (index >= _frameCount) {
        return 0;
    }
    if (_frameCount <= 1) {
        return 0;
    }
//    [_lock lock];
    avifImageTiming timing;
    avifResult decodeResult = avifDecoderNthImageTiming(_decoder, (uint32_t)index, &timing);
//    [_lock unlock];
    if (decodeResult != AVIF_RESULT_OK) {
        return 0;
    }
    return timing.duration;
}

- (UIImage *)animatedImageFrameAtIndex:(NSUInteger)index {
    if (index >= _frameCount) {
        return nil;
    }
//    [_lock lock];
    avifResult decodeResult = avifDecoderNthImage(_decoder, (uint32_t)index);
    if (decodeResult != AVIF_RESULT_OK) {
        return nil;
    }
    CGImageRef imageRef = SDCreateCGImageFromAVIF(_decoder->image);
//    [_lock unlock];
    if (!imageRef) {
        return nil;
    }

    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return image;
}

@end
