//
//  AppDelegate+Trial.h
//
//  Created by Tim Schröder on 04.04.11.
//

#import "BeFit_AppDelegate.h"

@interface BeFit_AppDelegate (Trial)

-(BOOL)checkIfAppStoreVersionIsInstalled;
-(BOOL)checkIfExpired;
-(int)remainingTrialPeriod;
-(void)showExpiredMessage;
-(void)showRemainingTrialMessage;
-(void)openAppStore;

@end
