//
//  GCAVIFDecoder.h
//  QQGameCenterAVIF
//
//  Created by ericbbpeng(彭博斌) on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCAVIFDecoder : NSObject

#pragma mark - Static Image

+ (BOOL)isAVIFFormatForData:(NSData *)data;
- (UIImage *)decodedImageWithData:(NSData *)data;

#pragma mark - Animated Image

@property (nonatomic, readonly) NSUInteger loopCount;
@property (nonatomic, readonly) NSUInteger frameCount;

+ (BOOL)isAnimatedImageForData:(NSData *)data;
- (instancetype)initWithAnimatedImageData:(NSData *)data;
- (NSTimeInterval)animatedImageDurationAtIndex:(NSUInteger)index;
- (UIImage *)animatedImageFrameAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
