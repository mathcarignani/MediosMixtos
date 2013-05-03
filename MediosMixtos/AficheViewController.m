//
//  AficheViewController.m
//  MediosMixtos
//
//  Created by Mathias on 15/04/13.
//  Copyright (c) 2013 shoock. All rights reserved.
//

#import "AficheViewController.h"

@interface AficheViewController ()

@property (nonatomic) bool mostrar;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *boton;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

- (void)scrollViewOneFingerTapped:(UITapGestureRecognizer*)recognizer;

- (IBAction)cerrar:(id)sender;

@end

@implementation AficheViewController


@synthesize scrollView = _scrollView;

@synthesize imageView = _imageView;

- (void)centerScrollViewContents {
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {

    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (void)scrollViewOneFingerTapped:(UITapGestureRecognizer*)recognizer
{
    if ([self mostrar])
    {
        self.mostrar = NO;
        //[self.boton setHidden:YES];
        [UIView animateWithDuration:0.4 animations:^{
            self.boton.alpha = 0;
        } completion: ^(BOOL finished) {
            self.boton.hidden = YES;
        }];
    }
    else
    {
        self.mostrar = YES;
        //[self.boton setHidden:NO];
        self.boton.alpha = 0;
        self.boton.hidden = NO;
        [UIView animateWithDuration:0.4 animations:^{
            self.boton.alpha = 1;
        }];
    }

}

- (IBAction)cerrar:(id)sender {
    [self mostrarBarraNavegacion];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ocultarBarraNavegacion];
    
    //Oculto boton de cerrar
    self.mostrar = NO;
    [self.boton setHidden:YES];
    
    // Set up the image we want to scroll & zoom and add it to the scroll view
    // La imagen depende del numero de proyecto
    UIImage *image;
    switch (self.numeroProyecto) {
        case 1:
            image = [UIImage imageNamed:@"afiche1@2x.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"afiche2@2x.png"];
            break;
        case 3:
            image = [UIImage imageNamed:@"afiche3@2x.png"];
            break;
        case 4:
            image = [UIImage imageNamed:@"afiche4@2x.png"];
            break;
        case 5:
            image = [UIImage imageNamed:@"afiche5@2x.png"];
            break;
        case 10:
            image = [UIImage imageNamed:@"afiche5_1@2x.png"];
            break;
        default:
            break;
    }
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = image.size;
    
    // Agrego los reconocimientos de gestos
    // Toque simple
    UITapGestureRecognizer *oneFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewOneFingerTapped:)];
    oneFingerTapRecognizer.numberOfTapsRequired = 1;
    oneFingerTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:oneFingerTapRecognizer];
    // Doble toque
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    // En principio comento el doble toque porque complica
    /*
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    */
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

- (void)ocultarBarraNavegacion
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    // Obtengo el tamano para ver de que dispositivo es
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.height == 480) {
        [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 480); //full screen.
    } else if (screenRect.size.height == 568) {
        [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 568); //full screen.
    }
}

- (void)mostrarBarraNavegacion
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    // Obtengo el tamano para ver de que dispositivo es
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.height == 480) {
        [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 460); //move down 20px.
    } else if (screenRect.size.height == 568) {
        [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 548); //move down 20px.
    }
}

@end