//
// Copyright (c) 2016 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SelectUsersCell2.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SelectUsersCell2()

@property (strong, nonatomic) IBOutlet UIImageView *imageGroup;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelMembers;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation SelectUsersCell2

@synthesize imageGroup, labelName, labelMembers;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)bindData:(DBGroup *)dbgroup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	labelName.text = dbgroup.name;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSArray *members = [dbgroup.members componentsSeparatedByString:@","];
	labelMembers.text = [NSString stringWithFormat:@"%ld members", (long) [members count]];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadImage:(DBGroup *)dbgroup tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *path = [DownloadManager pathImage:dbgroup.picture];
	if (path == nil)
	{
		imageGroup.image = [UIImage imageNamed:@"selectusers_blank"];
		[self downloadImage:dbgroup tableView:tableView indexPath:indexPath];
	}
	else imageGroup.image = [[UIImage alloc] initWithContentsOfFile:path];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)downloadImage:(DBGroup *)dbgroup tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[DownloadManager image:dbgroup.picture completion:^(NSString *path, NSError *error, BOOL network)
	{
		if ((error == nil) && ([tableView.indexPathsForVisibleRows containsObject:indexPath]))
		{
			SelectUsersCell2 *cell = [tableView cellForRowAtIndexPath:indexPath];
			cell.imageGroup.image = [[UIImage alloc] initWithContentsOfFile:path];
		}
	}];
}

@end
