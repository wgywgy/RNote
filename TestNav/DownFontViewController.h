
#import <UIKit/UIKit.h>

@interface DownFontViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *fontNames;
@property (strong, nonatomic) NSArray *fontSamples;
@property (weak, nonatomic) IBOutlet UITableView *fTableView;
@property (weak, nonatomic) IBOutlet UITextView *fTextView;
@property (weak, nonatomic) IBOutlet UIProgressView *fProgressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fActivityIndicatorView;

@end
