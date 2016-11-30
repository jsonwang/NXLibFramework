/*
 File: Reachability.m
 Abstract: Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 Version: 3.0

 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.

 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.

 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.

 Copyright (C) 2013 Apple Inc. All Rights Reserved.

 */

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>

#import <CoreFoundation/CoreFoundation.h>

#import "NXReachability.h"



NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";

#pragma mark - Supporting functions

#define kShouldPrintReachabilityFlags 0

static void PrintReachabilityFlags(SCNetworkReachabilityFlags flags, const char *comment)
{
#if kShouldPrintReachabilityFlags

    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
          (flags & kSCNetworkReachabilityFlagsIsWWAN) ? 'W' : '-',
          (flags & kSCNetworkReachabilityFlagsReachable) ? 'R' : '-',

          (flags & kSCNetworkReachabilityFlagsTransientConnection) ? 't' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionRequired) ? 'c' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) ? 'C' : '-',
          (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) ? 'D' : '-',
          (flags & kSCNetworkReachabilityFlagsIsLocalAddress) ? 'l' : '-',
          (flags & kSCNetworkReachabilityFlagsIsDirect) ? 'd' : '-', comment);
#endif
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
#pragma unused(target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject *)info isKindOfClass:[NXReachability class]],
              @"info was wrong class in ReachabilityCallback");

    NXReachability *noteObject = (__bridge NXReachability *)info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:noteObject];
}

@interface NXReachability ()
{
 
}

@end

#pragma mark - NXReachability implementation

@implementation NXReachability

{
    BOOL _alwaysReturnLocalWiFiStatus;  // default is NO
    SCNetworkReachabilityRef _reachabilityRef;
}
@synthesize telephonyNetworkInfo;
- (id)init
{
    if (self = [super init])
    {
        telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    }

    return self;
}

+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    NXReachability *returnValue = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability != NULL)
    {
        returnValue = [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
            returnValue->_alwaysReturnLocalWiFiStatus = NO;
        }
    }
    return returnValue;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in6 *)hostAddress
{
    SCNetworkReachabilityRef reachability =
        SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)hostAddress);

    NXReachability *returnValue = NULL;

    if (reachability != NULL)
    {
        returnValue = [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
            returnValue->_alwaysReturnLocalWiFiStatus = NO;
        }
    }
    return returnValue;
}

+ (instancetype)reachabilityForInternetConnection
{
    struct sockaddr_in6 zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin6_len = sizeof(zeroAddress);
    zeroAddress.sin6_family = AF_INET6;

    return [self reachabilityWithAddress:&zeroAddress];
}

#pragma mark - Start and stop notifier

- (BOOL)startNotifier
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};

    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }

    return returnValue;
}

- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    [self stopNotifier];
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}

#pragma mark - Network Flag Handling

- (NetworkStatus)nx_localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "localWiFiStatusForFlags");
    NetworkStatus returnValue = NotReachable;

    if ((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
    {
        returnValue = ReachableViaWiFi;
    }

    return returnValue;
}

- (NetworkStatus)nx_networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        // The target host is not reachable.
        return NotReachable;
    }

    NetworkStatus returnValue = NotReachable;

    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        /*
         If the target host is reachable and no connection is required then we'll assume (for now) that you're on
         Wi-Fi...
         */
        returnValue = ReachableViaWiFi;
    }

    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        /*
         ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or
         higher APIs...
         */

        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            /*
             ... and no [user] intervention is needed...
             */
            returnValue = ReachableViaWiFi;
        }
    }

    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        /*
         ... but WWAN connections are OK if the calling application is using the CFNetwork APIs. mdf by ak return 3G 2G
         */

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            // kvo key
            // CTRadioAccessTechnologyDidChangeNotification
            /*tips
             Now there’s absolutely no documentation around currentRadioAccessTechnology, so it took some trial and
             error to make this work. Once you have the current value, you should register for the
             CTRadioAccessTechnologyDidChangeNotification instead of polling the property. To actually get iOS to emit
             those notifications, you need to carry an instance of CTTelephonyNetworkInfo around. Don’t try to create a
             new instance ofCTTelephonyNetworkInfo inside the notification, or it’ll crash.
             */
            NSString *currentRadioAccessTechnology = telephonyNetworkInfo.currentRadioAccessTechnology;

            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    return ReachableVia4G;
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] ||
                         [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    return ReachableVia2G;
                }
                else
                {
                    return ReachableVia3G;
                }
            }
        }

        returnValue = ReachableVia3G;
        if ((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
        {
            if ((flags & kSCNetworkReachabilityFlagsTransientConnection) ==
                kSCNetworkReachabilityFlagsTransientConnection)
            {
                returnValue = ReachableVia3G;
                if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) ==
                    kSCNetworkReachabilityFlagsConnectionRequired)
                {
                    returnValue = ReachableVia2G;
                }
            }
        }
    }

    return returnValue;
}

- (BOOL)connectionRequired
{
    NSAssert(_reachabilityRef != NULL, @"connectionRequired called with NULL _reachabilityRef");
    SCNetworkReachabilityFlags flags;

    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    }

    return NO;
}

- (NSString *)currentReachabilityString
{
    NetworkStatus temp = [self currentReachabilityStatus];

    switch (temp)
    {
        case NotReachable:
        {
            return NSLocalizedString(@"没有网", @"");
            break;
        }
        case ReachableViaWiFi:
        {
            return NSLocalizedString(@"wifi网", @"");
            break;
        }
        case ReachableVia4G:
        {
            return NSLocalizedString(@"4G网", @"");
            break;
        }
        case ReachableVia3G:
        {
            return NSLocalizedString(@"3G网", @"");
            break;
        }
        case ReachableVia2G:
        {
            return NSLocalizedString(@"2G网", @"");
            break;
        }
        default:
            break;
    }

    return NSLocalizedString(@"No Connection", @"");
}

- (NetworkStatus)currentReachabilityStatus
{
    NSAssert(_reachabilityRef != NULL, @"currentNetworkStatus called with NULL _reachabilityRef");
    NetworkStatus returnValue = NotReachable;
    SCNetworkReachabilityFlags flags;

    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        if (_alwaysReturnLocalWiFiStatus)
        {
            returnValue = [self nx_localWiFiStatusForFlags:flags];
        }
        else
        {
            returnValue = [self nx_networkStatusForFlags:flags];
        }
    }

    return returnValue;
}

- (BOOL)isCurrentNetworkActive { return [self currentReachabilityStatus] && ![self connectionRequired]; }
@end
