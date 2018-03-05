//
//  EditeAddressCellView.h
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditeAddressMapView.h"

@class EditeAddressCellView;
@protocol EditeAddressCellViewDelegate
@optional
- (void)editeAddressCellView:(EditeAddressCellView *)cell clickMapView:(EditeAddressMapView *)mapView;
@end

@interface EditeAddressCellView : UIView

//** minWidth */
@property (nonatomic,assign) CGFloat             minWidth;
//** textField */
@property (nonatomic,strong) UITextField         * mTextField;
//** label */
@property (nonatomic,strong) EditeAddressMapView * mMapView;
//** nameText */
@property (nonatomic,copy) NSString * nameText;
@property (nonatomic,weak) id <EditeAddressCellViewDelegate> delegate;
@end

