//
//  tableHeader.h
//  FoldableTable
//
//  Created by haojin on 16/9/4.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol tableHeaderDelegate<NSObject>
@optional
- (void)didTableHeaderClicked:(id)header;
@end

@interface tableHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame headerTitle:(NSString *)title;
@property (nonatomic, weak) id<tableHeaderDelegate>delegate;
@property (nonatomic, assign) NSInteger sectionIndex;
@end
