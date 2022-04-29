//
//  Conversion.h
//  SDWebImageAVIFCoder
//
//  Created by Ryo Hirafuji on 2020/03/15.
//

#import "avif.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

extern CGImageRef _Nullable SDCreateCGImageFromAVIF(avifImage * _Nonnull avif) __attribute__((visibility("hidden")));
