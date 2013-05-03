//
//  DescripcionViewController.m
//  MediosMixtos
//
//  Created by Mathias on 15/04/13.
//  Copyright (c) 2013 shoock. All rights reserved.
//

#import "DescripcionViewController.h"
#import "ProcesoViewController.h"
#import "AficheViewController.h"

@interface DescripcionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *DescripcionLabel;
@property (weak, nonatomic) IBOutlet UITextView *texto;
@property (weak, nonatomic) IBOutlet UIButton *Botton1;
@property (weak, nonatomic) IBOutlet UIButton *Boton2;

- (IBAction)mostrarAfiche2:(id)sender;

@end

@implementation DescripcionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.DescripcionLabel.text = [self proyectoCorrespondienteA:self.numeroProyecto];
    [self cargarTexto];
    // Si es el 5to proyecto no oculto el boton 2 y cambio el boton 1
    if (self.numeroProyecto == 5)
    {
        [self.Botton1 setImage:[UIImage imageNamed:@"botonafiche1@2x.png"] forState:UIControlStateNormal];
        [self.Boton2 setHidden:NO];
    }
    else
        [self.Boton2 setHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)proyectoCorrespondienteA:(int)numero
{
    switch (numero) {
        case 1:
            return @"Diáspora.";
            break;
        case 2:
            return @"Caja de los pecados.";
            break;
        case 3:
            return @"Sistemas de impresión.";
            break;
        case 4:
            return @"Afiche PNUMA.";
            break;
        case 5:
            return @"Raport.";
            break;
        default:
            return @"";
            break;
    }
}

- (void)cargarTexto
{
    /*NSString *nombreArchivo = [NSString stringWithFormat:@"texto%i", self.numeroProyecto];
    NSString *direccionArchivo = [[NSBundle mainBundle] pathForResource:@"texto1"
                                                                 ofType:@"txt"];
    if (direccionArchivo) {
        NSString *textoDesdeArchivo = [NSString stringWithContentsOfFile:direccionArchivo
                                                                encoding:NSUTF8StringEncoding
                                                                   error:nil];
        self.texto.text = textoDesdeArchivo;
    }
     */
    
switch (self.numeroProyecto) {
    case 1:
        self.texto.text = @"Para este proyecto se comenzó a trabajar con el papel como materia para el diseño de un afiche.\nEl objetivo de esta pieza es el de comunicar la muestra de la \"Diáspora\" en el \"Museo de las Migraciones\".\nEsta experiencia trata de comenzar a integrar lo que se verá a lo largo de este portfolio, que es, la mezcla de medios, partiendo de la materia para arrivar a lo digital.\nPara el afiche en cuestión, se recurre al papel para empezar a investigar ciertas manipulaciones que se pueden hacer para lograr comunicar el concepto de diáspora.\nUna vez que lo material fue resuelto, se pasó a digitalizar por medio de escaneo la materia, obteniendo de esta forma ciertas sombras y elementos que la digitalización brinda.\nUna vez convertido a un archivo digital se realizaron modificaciones de tonos, exposición y recorte, entre otros para lograr el producto final.";
        break;
        
    case 2:
        self.texto.text = @"En en segundo proyecto fue otorgado un pecado capital. En este caso la \"Gula\".\nInmediatamente se construyó una caja de cartón (ver proceso) en a cual en su interior y con matera, hubo que recrear una escena que hiciera referencia del pecado en cuestión.\nEn este caso se recurrieron a elementos comestibles colocados dentro de la caja de manera desordenada y grotesca.\nUn orificio en una de las caras permitía ver al interior, y otras perforaciones al fondo regulaban la entrada de luz.\nEn la segunda parte de este proyecto se fotografió el interior. Obteniendo de esta manera una imagen de la caja por dentro, la cual se modificó para, ahora, editar digitalmente y tratar de representar otro segundo pecado otorgado. El cuál fué, en este caso la \"Ira\".";
        break;
    case 3:
        self.texto.text = @"En el siguiente proyecto se seleccionó un tema general para trabajar, el cuál fue \"La violencia\".\nSe trata de crear afiches que sigan integrando la mezcla de medios, pero esta vez aplicando técnicas de impresión.\nLas mismas fueron la Xilografía, Stencil, y el Gofrado.\nSe parte de una imagen propia para comenzar a trabajar, seguido de un retoque digital a la misma. Una vez realizados estos pasos, y con la nueva imagen, se comienza a realizar una serie de afiches con estas diversas técnicas, mezclándolas si se cree necesario para llegar a un producto final.";
        break;
        
    case 4:
        self.texto.text = @"El Programa de Naciones Unidas para el Medio Ambiente trata temas ambientales diversos.\nEn la propuesta de este proyecto se creó un afiche de \"PNUMA\". En este caso haciendo referencia a un tema que tratan que es el deshielo.\nLa premisa dejaba en claro que la gráfica debía ser obtenida por medio de una imagen fotográfica a una proyección en elgúna superficie.\nEn este caso se proyectó sobre un vaso de agua la silueta de una ciudad, la cual por medio de edición digital fue concluída como un producto publicitario.";
        break;
        
    case 5:
        self.texto.text = @"A partir de una fotografía algún elemento cualquiera se realiza una edición de la imagen alterando los niveles de ésta. De esta manera logramos diseñar un módulo que sea capaz de repetirse, creando así una textura.\nUna vez diseñado éste modulo se buscaron lugares para intervenir, los cuales fueron previamente relevados, midiendo cada espacio y calculando la cantidad de impresiones necesarias.\nAsí también se aplicó la textura a libros y lapiceras, realizando también el proceso de revelamiento.";
        break;
    default:
        self.texto.text = @"";
        break;
    }
    
}


#pragma mark Transiciones
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"DescripcionAProceso"])
    {
        ProcesoViewController *dest = (ProcesoViewController *)segue.destinationViewController;
        dest.numeroProyecto = self.numeroProyecto;
    }
    else if ([segue.identifier isEqual:@"DescripcionAAfiche"])
    {
        AficheViewController *dest = (AficheViewController *)segue.destinationViewController;
        if ([sender tag] == 14)
            dest.numeroProyecto = 10;
        else
            dest.numeroProyecto = self.numeroProyecto;
    }
}

- (IBAction)mostrarAfiche2:(id)sender
{
    [self performSegueWithIdentifier:@"DescripcionAAfiche" sender:sender];
}

@end
