#import "PanoramaPapers.h"
#define IMAGE_PATH @"/var/mobile/Documents/"
// NSString *text = [NSString stringWithFormat:@"%@",  @(myNumber)];

static UIScrollView *panoramaScrollview = nil;

static SBIconScrollView *iconScrollview = nil;
static SBIconListPageControl *pageControl = nil;
static SBFStaticWallpaperView *wallpaper =nil;
static NSInteger numberOfPages = 3;

static CGSize screenSize = [UIScreen mainScreen].bounds.size;

static void *kObservingNumberOfPagesChangesContext = &kObservingNumberOfPagesChangesContext;

%group iOS10

%hook SBIconScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    SBIconScrollView *icv = %orig;
    if(!iconScrollview) iconScrollview = icv;
    return icv;
}

%end

%hook SBIconListPageControl

- (void)setNumberOfPages:(NSInteger)pages 
{
    %orig;
    numberOfPages = pages; 
    if(wallpaper != NULL && panoramaScrollview == NULL)
    {
        panoramaScrollview = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, screenSize.width, screenSize.height)];
        [panoramaScrollview setPagingEnabled:YES];
        panoramaScrollview.contentSize = CGSizeMake(screenSize.width * numberOfPages, screenSize.height);  
        [panoramaScrollview setContentOffset:CGPointMake(screenSize.width, 0)]; 
        for(int i = 0; i < numberOfPages; i++) 
        { 
            CGFloat x = i * screenSize.width; 
            NSString *imagePath = [IMAGE_PATH stringByAppendingPathComponent: [NSString stringWithFormat:@"image%d.png", i+1]]; 
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, screenSize.width, screenSize.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageWithContentsOfFile: imagePath];

            if(imageView.image != NULL) [panoramaScrollview addSubview:imageView];  
        }    
        [wallpaper addSubview: panoramaScrollview];
    }
}

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

    if(iconScrollview != NULL && panoramaScrollview != NULL && iconScrollview.contentOffset.x > 0 && iconScrollview.contentOffset.x < screenSize.width * (numberOfPages - 1))
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