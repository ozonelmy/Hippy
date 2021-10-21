//
//  HippyDevWebSocketClient.m
//  HippyDemo
//
//  Created by mengyanluo on 2021/10/20.
//  Copyright © 2021 tencent. All rights reserved.
//

#import "HippyDevWebSocketClient.h"
#import "HippySRWebSocket.h"
#import "HippyAssert.h"

static NSString *generateRandomUUID() {
    static char alpha[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static uint32_t length = 16;
    char buffer[length + 1];
    for (NSInteger i = 0; i < length; i++) {
        uint32_t index = arc4random_uniform(length);
        buffer[i] = alpha[index];
    }
    buffer[length] = '\0';
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

@interface HippyDevWebSocketClient ()<HippySRWebSocketDelegate> {
    NSURL *_devURL;
    dispatch_queue_t _devQueue;
    HippySRWebSocket *_devWebSocket;
}

@end

@implementation HippyDevWebSocketClient

#pragma mark initialization methods

- (instancetype)initWithDevIPAddress:(NSString *)ipAddress port:(NSString *)port {
    //ws://127.0.0.1:38989/debugger-proxy?clientId=123145124&platform=1&role=ios_client
    HippyAssertParam(ipAddress);
    self = [super init];
    if (self) {
        NSString *uuid = generateRandomUUID();
        NSString *devAddress = [NSString stringWithFormat:@"ws://%@:%@/debugger-proxy?clientId=%@&platform=1&role=ios_client", ipAddress, port?:@"38989", uuid];
        _devURL = [NSURL URLWithString:devAddress];
        [self setup];
    }
    return self;
}

- (void)setup {
    _devQueue = dispatch_queue_create("com.tencent.hippy.devQueue", DISPATCH_QUEUE_SERIAL);
    _devWebSocket = [[HippySRWebSocket alloc] initWithURL:_devURL];
    _devWebSocket.delegate = self;
    [_devWebSocket setDelegateDispatchQueue:_devQueue];
    
    [_devWebSocket open];
}

#pragma mark property setter/getter
- (NSURL *)devURL {
    return _devURL;
}

#pragma mark dev websocket delegate methods
- (void)webSocket:(HippySRWebSocket *)webSocket didReceiveMessage:(id)message {
    if ([_delegate respondsToSelector:@selector(devClient:didReceiveMessage:)]) {
        [_delegate devClient:self didReceiveMessage:message];
    }
}

- (void)webSocketDidOpen:(HippySRWebSocket *)webSocket {
    if ([_delegate respondsToSelector:@selector(devClientDidConnect:)]) {
        [_delegate devClientDidConnect:self];
    }
}

- (void)webSocket:(HippySRWebSocket *)webSocket didFailWithError:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(devClient:didFailWithError:)]) {
        [_delegate devClient:self didFailWithError:error];
    }
}

- (void)webSocket:(HippySRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    if ([_delegate respondsToSelector:@selector(devClientDidClose:)]) {
        [_delegate devClientDidClose:self];
    }
}

- (void)webSocket:(HippySRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    
}

@end
