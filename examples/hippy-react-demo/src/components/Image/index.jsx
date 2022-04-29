import React from 'react';
import {
  ScrollView,
  Image,
  StyleSheet,
} from '@hippy/react';

// Import the image to base64 for defaultSource props.
import defaultSource from './defaultSource.jpg';
// import HippyLogoImg from './hippyLogoWhite.png';

// const imageUrl = 'https://user-images.githubusercontent.com/12878546/148736102-7cd9525b-aceb-41c6-a905-d3156219ef16.png';
const avif1 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/21.gif?useavif=1&ci-style=avif&imageMogr2/';
const avif2 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/20.gif?useavif=1&ci-style=avif&imageMogr2/';
const avif3 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/22.gif?useavif=1&ci-style=avif&imageMogr2/';
const avif4 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/32.gif?useavif=1&ci-style=avif&imageMogr2/';
const avif5 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/33.gif?useavif=1&ci-style=avif&imageMogr2/';
const avif6 = 'https://static-gamecenter-1251316161.cos.ap-guangzhou.myqcloud.com/test/34.gif?useavif=1&ci-style=avif&imageMogr2/';

const styles = StyleSheet.create({
  container_style: {
    alignItems: 'center',
  },
  image_style: {
    width: 300,
    height: 180,
    margin: 16,
    borderColor: '#4c9afa',
    borderWidth: 1,
    borderRadius: 4,
  },
  info_style: {
    marginTop: 15,
    marginLeft: 16,
    fontSize: 16,
    color: '#4c9afa',
  },
});

export default function ImageExpo() {
  return (
    <ScrollView style={styles.container_style}>
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: 'https://user-images.githubusercontent.com/12878546/148736255-7193f89e-9caf-49c0-86b0-548209506bd6.gif' }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />


      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif1 }}
      />
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif2 }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif3 }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif4 }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif5 }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />
      <Image
        style={[styles.image_style]}
        resizeMode={Image.resizeMode.cover}
        defaultSource={defaultSource}
        source={{ uri: avif6 }}
        onLoadEnd={() => {
          console.log('gif onLoadEnd');
        }}
      />
    </ScrollView>
  );
}
