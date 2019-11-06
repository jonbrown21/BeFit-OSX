//
//  AppDelegate+Trial.h
//
//  Created by Tim Schröder on 04.04.11.
//

@class BeFit_AppDelegate;

@interface BeFit_AppDelegate (Trial)

-(BOOL)checkIfAppStoreVersionIsInstalled;
-(BOOL)checkIfExpired;
-(int)remainingTrialPeriod;
-(void)showExpiredMessage;
-(void)showRemainingTrialMessage;
-(void)openAppStore;

@end
