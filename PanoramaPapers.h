@interface SBIconScrollView : UIScrollView // Forward touches to new scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface SBIconListPageControl : UIPageControl // Get pages count for new scrollview width
@end

@interface SBFStaticWallpaperView : UIView // Add scrollview
@end

@interface SBRootFolderController : UIViewController
- (void)viewDidAppear:(id)arg1;
- (void)viewDidDisappear:(id)arg1;
@end

@interface SBFolderView : UIView
@end

@interface SBRootFolderView : SBFolderView <UIScrollViewDelegate>
@end

// handle dock blur <- by setting it after each scroll or other way