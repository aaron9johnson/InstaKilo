//
//  ViewController.m
//  InstaKilo
//
//  Created by Aaron Johnson on 2017-10-18.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionReusableView.h"
#import "MyImageView.h"

@interface ViewController ()
@property IBOutlet UICollectionView *myCollectionView;
@property NSMutableArray *myImages;
@property UICollectionViewFlowLayout *myLocationLayout;
@property UICollectionViewFlowLayout *mySubjectLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myImages = [NSMutableArray new];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_1385"] Subject:@"Aaron" andLocation:@"Mexico"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_1717"] Subject:@"Food" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_1733"] Subject:@"Rusty" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_1914"] Subject:@"Landscape" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2010"] Subject:@"Aaron" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2120"] Subject:@"Landscape" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2121"] Subject:@"Landscape" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2157"] Subject:@"Rusty" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2191"] Subject:@"Aaron" andLocation:@"Vancouver"]];
    [self.myImages addObject:[[MyImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2199"] Subject:@"Food" andLocation:@"Vancouver"]];
    
    self.myCollectionView.frame = self.view.frame;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
[self setupMyLocationLayout];
[self setupMySubjectLayout];


self.myCollectionView.collectionViewLayout = self.myLocationLayout;
}
- (IBAction)sortBy{
    UICollectionViewLayout *nextLayout;
    if (self.myCollectionView.collectionViewLayout == self.myLocationLayout) {
        nextLayout = self.mySubjectLayout;
    }
    else {
        nextLayout = self.myLocationLayout;
    }
    //[self.myCollectionView.collectionViewLayout invalidateLayout];
    [self.myCollectionView setCollectionViewLayout:nextLayout animated:NO];
    [self.myCollectionView reloadData];
}
-(NSArray *)getImages:(NSString *)input{
    NSMutableArray *temp = [NSMutableArray new];
    if([input isEqualToString:@"Subject"]){
        for(MyImageView *any in self.myImages){
            NSString *tempS = any.subject;
            bool inArray = false;
            for(NSString *all in temp){
                if([tempS isEqualToString:all]){
                    inArray = true;
                }
            }
            if(!inArray){
                [temp addObject:tempS];
            }
        }
    } else if([input isEqualToString:@"Location"]){
        for(MyImageView *any in self.myImages){
            NSString *tempS = any.location;
            bool inArray = false;
            for(NSString *all in temp){
                if([tempS isEqualToString:all]){
                    inArray = true;
                }
            }
            if(!inArray){
                [temp addObject:tempS];
            }
        }
    } else {
        for(MyImageView *any in self.myImages){
            if([any.subject isEqualToString:input] || [any.location isEqualToString:input]){
                [temp addObject:any];
            }
        }
    }
        return temp;
}

// MARK: - Internal methods
-(void)setupMySubjectLayout{
    _mySubjectLayout = [[UICollectionViewFlowLayout alloc] init];
    self.mySubjectLayout.itemSize = CGSizeMake(100, 100);
    self.mySubjectLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.mySubjectLayout.minimumInteritemSpacing = 15;
    self.mySubjectLayout.minimumLineSpacing = 10;
    self.mySubjectLayout.headerReferenceSize = CGSizeMake(self.myCollectionView.frame.size.width, 50);
    self.mySubjectLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}
- (void)setupMyLocationLayout{
    _myLocationLayout = [[UICollectionViewFlowLayout alloc] init];
    self.myLocationLayout.itemSize = CGSizeMake(100, 100);
    self.myLocationLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.myLocationLayout.minimumInteritemSpacing = 15;
    self.myLocationLayout.minimumLineSpacing = 10;
    self.myLocationLayout.headerReferenceSize = CGSizeMake(self.myCollectionView.frame.size.width, 50);
    self.myLocationLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.myCollectionView.collectionViewLayout == self.myLocationLayout) {
        return [self getImages:@"Location"].count;
    } else {
        return [self getImages:@"Subject"].count;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MyCollectionReusableView *headerView = [self.myCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"myHeader"
                                                                                  forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor cyanColor];
        NSString *temp;
        if (self.myCollectionView.collectionViewLayout == self.myLocationLayout) {
            NSArray *locations = [self getImages:@"Location"];
            temp = [NSString stringWithFormat:@"Location: %@", locations[indexPath.section]];
        } else {
            NSArray *subjects = [self getImages:@"Subject"];
            temp = [NSString stringWithFormat:@"Subject: %@", subjects[indexPath.section]];
        }
        headerView.myLabel.text = temp;
        return headerView;
    }
    return nil;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    MyImageView *temp;
    if (self.myCollectionView.collectionViewLayout == self.myLocationLayout) {
        NSArray *locations = [self getImages:@"Location"];
        NSArray *imagesAtLocation = [self getImages:locations[indexPath.section]];
        temp = imagesAtLocation[indexPath.row];
    } else {
        NSArray *subjects = [self getImages:@"Subject"];
        NSArray *imagesOfSubject = [self getImages:subjects[indexPath.section]];
        temp = imagesOfSubject[indexPath.row];
    }
    cell.myImageView.image = temp.image;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    if (self.myCollectionView.collectionViewLayout == self.myLocationLayout) {
        NSArray *locations = [self getImages:@"Location"];
        NSArray *imagesAtLocation = [self getImages:locations[section]];
        return imagesAtLocation.count;
    } else {
        NSArray *subjects = [self getImages:@"Subject"];
        NSArray *imagesOfSubjct = [self getImages:subjects[section]];
        return imagesOfSubjct.count;
    }
    return 0;
}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
