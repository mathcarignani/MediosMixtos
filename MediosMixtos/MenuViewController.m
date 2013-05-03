//
//  MenuViewController.m
//  MediosMixtos
//
//  Created by Mathias on 14/04/13.
//  Copyright (c) 2013 shoock. All rights reserved.
//

#import "MenuViewController.h"
#import "DescripcionViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface MenuViewController ()
- (IBAction)irAInicio;
- (IBAction)irATwitter;
- (IBAction)irABehance:(id)sender;
- (IBAction)irAShoock:(id)sender forEvent:(UIEvent *)event;
- (IBAction)irAProyecto:(UIButton *)sender;

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Agregar imagen a fondo de tabla
    UIImage *image = [UIImage imageNamed:@"menubackground.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    // Add image view on top of table view
    [self.tableView addSubview:imageView];
    // Set the background view of the table view
    self.tableView.backgroundView = imageView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - Table view delegate

- (IBAction)irAInicio {
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"Inicio"]];
}

- (IBAction)irATwitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/jesponda24"]];
}

- (IBAction)irABehance:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.behance.net/joaquinesponda"]];
}

- (IBAction)irAShoock:(id)sender forEvent:(UIEvent *)event {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.shoock.uy"]];
}

- (IBAction)irAProyecto:(UIButton *)sender {
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"Descripcion"]];
    DescripcionViewController *descripcionDestino = (DescripcionViewController *)self.sidePanelController.centerPanel;
    descripcionDestino.numeroProyecto = sender.tag;
}

@end
