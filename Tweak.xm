#import "PanoramaPapers.h"
// NSString *text = [NSString stringWithFormat:@"%@",  @(myNumber)];

static UIScrollView *panoramaScrollview = nil;

static SBIconScrollView *iconScrollview = nil;
static SBIconListPageControl *pageControl = nil;
static SBFStaticWallpaperView *wallpaper =nil;
static NSInteger numberOfPages = 3;

static CGSize screenSize = [UIScreen mainScreen].bounds.size;
// static int kObservingNumberOfPagesChangesContext;

// - (void)startObservingNumberOfPageChangesInPageControl:(SBIconListPageControl *)pageControl 
// {
//     [pageControl addObserver:self forKeyPath:@"numberOfPages" options:0 context:&kObservingNumberOfPagesChangesContext];
// }

// - (void)stopObservingContentSizeChangesInWebView:(SBIconListPageControl *)pageControl 
// {
//     [pageControl removeObserver:self forKeyPath:@"contentSize" context:&kObservingContentSizeChangesContext];
// }

// - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
// {
//     if (context == &kObservingNumberOfPagesChangesContext) 
//     {
//         SBIconListPageControl *pageControl = object;
//         NSLog(@"%@ numberOfPages changed to %@", pageControl, pageControl.numberOfPages);
//     } 
//     else 
//     {
//         [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//     }
// }

%group iOS10

%hook SBRootFolderController

- (id)initWithFolder:(id)arg1 orientation:(long long)arg2 viewMap:(id)arg3
{
    if(wallpaper != NULL && panoramaScrollview == NULL)
    {
        numberOfPages = pageControl.numberOfPages; // is zero
        panoramaScrollview = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, screenSize.width, screenSize.height)];
        panoramaScrollview.contentSize = CGSizeMake(screenSize.width * numberOfPages, screenSize.height);  
        [panoramaScrollview setContentOffset:CGPointMake(screenSize.width, 0)]; 
        for(int i = 0; i < numberOfPages; i++) 
        { 
            CGFloat x = i * screenSize.width;  
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, screenSize.width, screenSize.height)];       
            if(i == 0) view.backgroundColor = [UIColor greenColor];  
            if(i == 1) view.backgroundColor = [UIColor blueColor];  
            if(i == 2) view.backgroundColor = [UIColor redColor];  
            [panoramaScrollview addSubview:view];  
        }    
        [wallpaper addSubview: panoramaScrollview];
    }
    return %orig;
}

%end

%hook SBIconScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    SBIconScrollView *icv = %orig;
    if(!iconScrollview) iconScrollview = icv;
    return icv;
}

%end

%hook SBIconListPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    SBIconListPageControl *pc = %orig;
    if(!pageControl) pageControl = pc;
    return pc;
}

%end

%hook SBFStaticWallpaperView

- (id)initWithFrame:(struct CGRect)arg1 wallpaperImage:(id)arg2 cacheGroup:(id)arg3 variant:(long long)arg4 options:(unsigned long long)arg5
{
    SBFStaticWallpaperView *w = %orig;
    if(!wallpaper) wallpaper = w;
    return w;
}

%end

%hook SBRootFolderView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    %orig;
    if(iconScrollview != NULL && panoramaScrollview != NULL)
    {
        CGPoint offset = panoramaScrollview.contentOffset;
        offset.x = iconScrollview.contentOffset.x;
        [panoramaScrollview setContentOffset:offset];
    }
}

%end

%end

%ctor 
{
    if(kCFCoreFoundationVersionNumber >= 1300) // iOS 10
    {
        %init(iOS10);
    }
}