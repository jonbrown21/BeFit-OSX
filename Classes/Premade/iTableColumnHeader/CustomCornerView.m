
#import "CustomCornerView.h"
#import "iTableColumnHeaderCell.h"

@implementation CustomCornerView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	[iTableColumnHeaderCell drawBackgroundInRect:self.bounds
								 hilighted:NO];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
