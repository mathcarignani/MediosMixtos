//
//  PagedScrollViewController.m
//  ScrollViews
//
//  Created by Matt Galloway on 01/03/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//

#import "ProcesoViewController.h"

@interface ProcesoViewController ()
@property (nonatomic, strong) NSMutableArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;


@property (nonatomic) bool mostrar;
@property (weak, nonatomic) IBOutlet UIButton *boton;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

- (void)scrollViewOneFingerTapped:(UITapGestureRecognizer*)recognizer;
- (IBAction)cerrar:(id)sender;
@end

@implementation ProcesoViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;

#pragma mark -

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ocultarBarraNavegacion];
    
    // Oculto boton
    self.mostrar = NO;
    [self.boton setHidden:YES];
    
    // Agrego los reconocimientos de gestos
    // Toque simple
    UITapGestureRecognizer *oneFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewOneFingerTapped:)];
    oneFingerTapRecognizer.numberOfTapsRequired = 1;
    oneFingerTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:oneFingerTapRecognizer];
    
    // Cargar lista de imagenes
    [self setListaDeImagenes];
    
    NSInteger pageCount = self.pageImages.count;
    
    // Set up the page control
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    // Set up the array to hold the views for each page
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.pageControl = nil;
    self.pageImages = nil;
    self.pageViews = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    [self loadVisiblePages];
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

#pragma mark Propios
- (void)setListaDeImagenes
{
    int cantidadImagenes = 0;
    // Segun el proyecto seteo la cantidad de imagenes que tiene el proceso
    switch (self.numeroProyecto) {
        case 1:
            cantidadImagenes = 5;
            break;
        case 2:
            cantidadImagenes = 9;
            break;
        case 3:
            cantidadImagenes = 4;
            break;
        case 4:
            cantidadImagenes = 7;
            break;
        case 5:
            cantidadImagenes = 5;
            break;
        default:
            break;
    }
    // Elimino los datos de la variable por las dudas
    self.pageImages = [[NSMutableArray alloc]init];
    // Recorro la cantidad de imagenes del proyecto y agrego al arreglo
    for (int i = 1; i <= cantidadImagenes; i++) {
        // Agrego la imagen que corresponde
        [self.pageImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"proceso%iimagenpagina%i",self.numeroProyecto,i]]];

    }
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
