//
//  ViewController.m
//  Movie_GPUImage
//
//  Created by Simon Lucey on 9/24/15.
//  Copyright (c) 2015 CMU_16432. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController (){
    // Setup the view (this time using GPUImageView)
    GPUImageView *videoView_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Setup GPUImageView (not we are not using UIImageView here).........
    videoView_ = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    // Important: add as a subview
    [self.view addSubview:videoView_];
    
    // Set the movie file to read
    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"simon" withExtension:@"mov"];
    
    GPUImageMovie *movieFile = [[GPUImageMovie alloc] initWithURL:sampleURL];
    movieFile.runBenchmark = NO;
    movieFile.playAtActualSpeed = YES;
    
    // Initialize filters
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    
    // Daisy chain the filters together (you can add as many filters as you like)
    [movieFile addTarget:sepiaFilter];
    [sepiaFilter addTarget:videoView_];
    
    // Rotates the video right so it displays properly
    [sepiaFilter setInputRotation:kGPUImageRotateRight atIndex:0];
    
    // Process the movie
    [movieFile startProcessing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
