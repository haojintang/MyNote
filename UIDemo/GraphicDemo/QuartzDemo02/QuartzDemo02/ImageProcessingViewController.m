//
//  ImageProcessingViewController.m
//  QuartzDemo02
//
//  Created by haojin on 16/10/1.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ImageProcessingViewController.h"

#define SCREEN_RECT         [UIScreen mainScreen].bounds

@interface ImageProcessingViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imgPicker;//选图器
@property (nonatomic, strong) UIImageView *imageView;//图片显示控件
@property (nonatomic, strong) CIContext *context;//core image context
@property (nonatomic, strong) CIImage *image;//待处理的图片
@property (nonatomic, strong) CIImage *outputImage;//处理后的图片
@property (nonatomic, strong) CIFilter *colorFilter;//色彩滤镜
@end

@implementation ImageProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLayout
{
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
    
    //创建图片显示控件
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_RECT.size.width, 450)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    //导航栏
    self.navigationItem.title = @"Enhance";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openImage:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveImage:)];
    
    //下方控制器
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 550, 100, 30)];
    [label1 setText:@"饱和度"];
    [label1 setTextColor:[UIColor blackColor]];
    [self.view addSubview:label1];
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(150, 560, 200, 10)];
    [self.view addSubview:slider1];
    slider1.minimumValue = 0;
    slider1.maximumValue = 2;
    slider1.value = 1;
    [slider1 addTarget:self action:@selector(changeStaturation:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 600, 100, 30)];
    [label2 setText:@"亮度"];
    [label2 setTextColor:[UIColor blackColor]];
    [self.view addSubview:label2];
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(150, 610, 200, 10)];
    [self.view addSubview:slider2];
    slider2.minimumValue = -1;
    slider2.maximumValue = 1;
    slider2.value = 0;
    [slider2 addTarget:self action:@selector(changeLightness:) forControlEvents:UIControlEventValueChanged];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 650, 100, 30)];
    [label3 setText:@"对比度"];
    [label3 setTextColor:[UIColor blackColor]];
    [self.view addSubview:label3];
    UISlider *slider3 = [[UISlider alloc] initWithFrame:CGRectMake(150, 660, 200, 10)];
    [self.view addSubview:slider3];
    slider3.minimumValue = 0;
    slider3.maximumValue = 2;
    slider3.value = 1;
    [slider3 addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    
    //初始化CIContext
     self.context = [CIContext contextWithOptions:nil];
     //获取滤镜
     self.colorFilter = [CIFilter filterWithName:@"CIColorControls"];
}

-(void)setImage{
    CIImage *outputImage= [self.colorFilter outputImage];//取得输出图像
    CGImageRef temp=[self.context createCGImage:outputImage fromRect:[outputImage extent]];
    self.imageView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    CGImageRelease(temp);//释放CGImage对象
}

//对比度变化了
- (void)changeContrast:(UISlider *)slider
{
    [self.colorFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
}

//亮度变化了
- (void)changeLightness:(UISlider *)slider
{
    [self.colorFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
}

//饱和度变化了
- (void)changeStaturation:(UISlider *)slider
{
    [self.colorFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];
    [self setImage];
}

//打开选图器
- (void)openImage:(id)sender
{
    [self presentViewController:self.imgPicker animated:YES completion:nil];
}

//保存照片到相册
- (void)saveImage:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"System info" message:@"Save Success!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得选择图片
    UIImage *selectedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image=selectedImage;
    //初始化CIImage源图像
    self.image=[CIImage imageWithCGImage:selectedImage.CGImage];
    [self.colorFilter setValue:self.image forKey:@"inputImage"];//设置滤镜的输入图片
}

@end
