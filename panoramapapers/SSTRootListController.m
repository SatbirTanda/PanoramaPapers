#include "SSTRootListController.h"

#define ROOT @"/var/mobile/Documents/"
#define PATH1 @"/var/mobile/Documents/image1.png"
#define PATH2 @"/var/mobile/Documents/image2.png"
#define PATH3 @"/var/mobile/Documents/image3.png"
#define PATH4 @"/var/mobile/Documents/image4.png"
#define PATH5 @"/var/mobile/Documents/image5.png"
#define PATH6 @"/var/mobile/Documents/image6.png"
#define PATH7 @"/var/mobile/Documents/image7.png"

static NSString *imageName = @"image1.png";

@implementation SSTRootListController

- (NSArray *)specifiers 
{
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)respring 
{
    system("killall SpringBoard");
} 

- (void)linkToMyTwitter 
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/sst1337/"]];
} 

- (void)selectPhoto1
{
	imageName = @"image1.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto2
{
	imageName = @"image2.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto3
{
	imageName = @"image3.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto4
{
	imageName = @"image4.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto5
{
	imageName = @"image5.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto6
{
	imageName = @"image6.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto7
{
	imageName = @"image7.png";
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)selectPhoto 
{
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)previewImage1
{
	[self showPreviewImageWithPath:PATH1];
}

- (void)previewImage2
{
	[self showPreviewImageWithPath:PATH2];
}

- (void)previewImage3
{
	[self showPreviewImageWithPath:PATH3];
}

- (void)previewImage4
{
	[self showPreviewImageWithPath:PATH4];
}

- (void)previewImage5
{
	[self showPreviewImageWithPath:PATH5];
}

- (void)previewImage6
{
	[self showPreviewImageWithPath:PATH6];
}

- (void)previewImage7
{
	[self showPreviewImageWithPath:PATH7];
}

- (void)deleteImage1
{
    [self deleteImageWithPath: PATH1];
}

- (void)deleteImage2
{
    [self deleteImageWithPath: PATH2];
}

- (void)deleteImage3
{
    [self deleteImageWithPath: PATH3];
}

- (void)deleteImage4
{
    [self deleteImageWithPath: PATH4];
}

- (void)deleteImage5
{
    [self deleteImageWithPath: PATH5];
}

- (void)deleteImage6
{
    [self deleteImageWithPath: PATH6];
}

- (void)deleteImage7
{
    [self deleteImageWithPath: PATH7];
}

- (void)deleteImageWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    if (success) 
    {
        UIAlertView *removedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Image Deleted" message:@"Successfully removed" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [removedSuccessFullyAlert show];
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

- (void)showPreviewImageWithPath:(NSString *)path
{
	UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Preview Image" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 40, 40)];

	UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
	[image setImage:img];

	if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) 
	{
	   [Alert setValue:image forKey:@"accessoryView"];
	}
	else
	{
	   [Alert addSubview:image];
	}

	[Alert show];
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller

                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               
                                               UINavigationControllerDelegate>) delegate
{
    
    
    
    if (([UIImagePickerController isSourceTypeAvailable:
          
          UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        
        || (delegate == nil)
        
        || (controller == nil))
        
        return NO;
    
    
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    // Displays saved pictures and movies, if both are available, from the
    
    // Camera Roll album.
    
    mediaUI.mediaTypes =
    
    [UIImagePickerController availableMediaTypesForSourceType:
     
     UIImagePickerControllerSourceTypePhotoLibrary];
    
    
    
    // Hides the controls for moving & scaling pictures, or for
    
    // trimming movies. To instead show the controls, use YES.
    
    mediaUI.allowsEditing = NO;
    
    
    
    mediaUI.delegate = delegate;
    
    
    
    [controller presentViewController:mediaUI animated:YES completion:nil];
    
    return YES;
    
}

- (void) imagePickerController: (UIImagePickerController *) picker

 didFinishPickingMediaWithInfo: (NSDictionary *) info 

 {
    
    
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    UIImage *originalImage, *editedImage, *imageToUse;
    
    
    
    // Handle a still image picked from a photo album
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        
        == kCFCompareEqualTo) {
        
        
        
        editedImage = (UIImage *) [info objectForKey:
                                   
                                   UIImagePickerControllerEditedImage];
        
        originalImage = (UIImage *) [info objectForKey:
                                     
                                     UIImagePickerControllerOriginalImage];
        
        
        
        if (editedImage) {
            
            imageToUse = editedImage;


            
        } else {
            
            imageToUse = originalImage;
            
            
        }

        if (imageToUse != nil)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            if(paths != nil) {
                NSString *documentsDirectory = [paths objectAtIndex:0];
                if(documentsDirectory != nil) {
                    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                                      imageName ];
                    //NSLog(@"%@", path);
                    if(path != nil) {
                        NSData* data = UIImagePNGRepresentation(imageToUse);
                        if(data != nil) {
                            [data writeToFile:path atomically:YES];
                        }
                    }
                }
            }
        }
        
        // Do something with imageToUse
        
    }

    [self dismissViewControllerAnimated:YES completion:^{
        [picker release];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:[NSString stringWithFormat:@"%@ set!", imageName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];

    
}

@end
