//
//  ViewController.m
//  BackgroundDownloading
//
//  Created by Anton Tolstov on 23.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIProgressView *progressView;
@property UILabel *progressLabel;
@property NSURLSessionDownloadTask *downloadTask;

@end

@implementation ViewController

static NSString * const kExampleURLString = @"https://speed.hetzner.de/100MB.bin";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)startNewDownloading {
    [self.downloadTask cancel];
    
    NSURL *url = [NSURL URLWithString:kExampleURLString];
    
    NSString *configurationIdentifier = [[NSUUID UUID] UUIDString];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration
                                                backgroundSessionConfigurationWithIdentifier:configurationIdentifier];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:self
                                                     delegateQueue:nil];
    self.downloadTask = [session downloadTaskWithURL:url];
    [self.downloadTask resume];
}

- (void)loadView {
    [super loadView];

    self.progressView = [[UIProgressView alloc] init];
    self.progressLabel = [[UILabel alloc] init];
    [self.progressLabel setText:@"0.00%"];
    
    UIButton *restartDownloadingButton = [[UIButton alloc] init];
    [restartDownloadingButton setTitle:@"Restart Downloading" forState:UIControlStateNormal];
    [restartDownloadingButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [restartDownloadingButton.layer setCornerRadius:15];
    [restartDownloadingButton.layer setBorderWidth:1];
    [restartDownloadingButton.layer setBorderColor:UIColor.blackColor.CGColor];
    [restartDownloadingButton addTarget:self
                                 action:@selector(startNewDownloading)
                       forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *verticalStack =
    [[UIStackView alloc] initWithArrangedSubviews:@[self.progressLabel,
                                                    self.progressView,
                                                    restartDownloadingButton]];
    [verticalStack setAxis: UILayoutConstraintAxisVertical];
    [verticalStack setSpacing:20.0];
    [self.view addSubview:verticalStack];

    [verticalStack setTranslatesAutoresizingMaskIntoConstraints:NO];
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:
     @[
         [verticalStack.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor],
         [verticalStack.centerYAnchor constraintEqualToAnchor:safeArea.centerYAnchor],
         [verticalStack.widthAnchor constraintEqualToConstant:200]
     ]];
}

// MARK: - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    NSLog(@"didBecomeInvalidWithError");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:1.0];
        [self.progressLabel setText:@"100%"];
        [self.progressLabel setTextColor:UIColor.greenColor];
    });
}

// MARK: - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    double fractionCompleted = downloadTask.progress.fractionCompleted;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:fractionCompleted];
        [self.progressLabel setText:[NSString stringWithFormat:@"%.2f%%",
                                     fractionCompleted * 100.0]];
    });
}

@end
