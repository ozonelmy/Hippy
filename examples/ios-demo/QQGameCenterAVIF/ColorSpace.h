//
//  ColorSpace.h
//  SDWebImageAVIFCoder
//
//  Created by Ryo Hirafuji on 2020/03/15.
//

#import "avif.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

extern CGColorSpaceRef _Nullable SDAVIFCreateColorSpaceMono(avifColorPrimaries const colorPrimaries, avifTransferCharacteristics const transferCharacteristics) __attribute__((visibility("hidden")));
extern CGColorSpaceRef _Nullable SDAVIFCreateColorSpaceRGB(avifColorPrimaries const colorPrimaries, avifTransferCharacteristics const transferCharacteristics) __attribute__((visibility("hidden")));

void SDAVIFCalcColorSpaceMono(avifImage * _Nonnull avif, CGColorSpaceRef _Nullable * _Nonnull ref, BOOL* _Nonnull shouldRelease);
void SDAVIFCalcColorSpaceRGB(avifImage * _Nonnull avif, CGColorSpaceRef _Nullable * _Nonnull ref, BOOL* _Nonnull shouldRelease);
