@interface SBIconScrollView : UIScrollView // Forward touches to new scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (BOOL)isTweakEnabled;
@end

@interface SBIconListPageControl : UIPageControl // Get pages count for new scrollview width
- (BOOL)isTweakEnabled;
@end

@interface SBFStaticWallpaperView : UIView // Add scrollview
- (BOOL)isTweakEnabled;
@end

// handle dock blur <- by setting it after each scroll or other way