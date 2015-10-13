//
//  KGMapView.m
//  agrBankWallet
//
//  Created by guowenrui on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGMapView.h"

@interface KGMapView ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation KGMapView

- (void)goBack
{
    _mapView.delegate = nil;
    _mapView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [_targetObject objectForKey:@"ActivityName"];
    _mapView.delegate = self;
    
    NSArray *_array = [_targetObject objectForKey:@"location"];
    NSMutableArray *_locations = [NSMutableArray array];
    for (NSString *_info in _array) {
        NSArray *_infoArray = [_info componentsSeparatedByString:@","];
        if (_infoArray.count > 2) {
            CLLocationCoordinate2D _location = CLLocationCoordinate2DMake([_infoArray[1] floatValue], [_infoArray[0] floatValue]);
            MKPointAnnotation *loctionOne = [[MKPointAnnotation alloc] init];
            loctionOne.coordinate = _location;
            loctionOne.title = _infoArray[2];
            [_locations addObject:loctionOne];
        }
    }
    
    [_mapView addAnnotations:_locations];
    if (_locations.count > 0) {
        MKPointAnnotation *_firstLocation = _locations[0];
        _mapView.region = MKCoordinateRegionMake(_firstLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1));
        [_mapView selectAnnotation:_firstLocation animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *newAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"location"];
    newAnnotationView.image = [UIImage imageNamed:@"otherLocation"];
    newAnnotationView.canShowCallout = YES;
    return newAnnotationView;
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
