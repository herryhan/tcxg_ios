//
//  CitySendBannerView.h
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySendBannerView : UIView

//** loadWeight */
@property (nonatomic,copy) NSString * mLoadWeight;
//** threeHigh */
@property (nonatomic,copy) NSString * mThreeHigh;
//** volume */
@property (nonatomic,copy) NSString * mVolume;
//** imageName */
@property (nonatomic,copy) NSString * mImageName;
//** title */
@property (nonatomic,copy) NSString * mTitle;
//** noThreeHigh */
@property (nonatomic,assign) BOOL  mHaveThreeHigh;

@end
