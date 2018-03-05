//
//  ViewModelClass.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/15.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ViewModelClass : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;


// 传入交互的Block块
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

@end
