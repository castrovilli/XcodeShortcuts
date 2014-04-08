//
//  DictionaryViewController.m
//  Shortcuts
//
//  Created by Ray Wenderlich on 9/23/11.
//  Copyright 2011 Razeware LLC. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DictionaryViewController.h"
#import "ShortcutsViewController.h"
#import "ShortcutsDatabase.h"

@implementation DictionaryViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageView.image = [[UIImage imageNamed:@"tv_stretch"] resizableImageWithCapInsets:UIEdgeInsetsMake(53, 12, 53, 12)];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(handleBack:)];
}

- (void) handleBack:(id)sender
{
    [[ShortcutsDatabase sharedDatabase] playClick];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@ - viewWillAppear", self.navigationItem.title);
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_keys == nil) {
        _keys = [[_dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    [self.tableView reloadData];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[ShortcutsDatabase sharedDatabase] playClick];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@ - willRotateToInterfaceOrientation", self.navigationItem.title);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSString * entry = [_keys objectAtIndex:indexPath.row];
    cell.textLabel.text = entry;    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Shortcuts"]) {
        [[ShortcutsDatabase sharedDatabase] playClick];
        NSString * entry = [_keys objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        ShortcutsViewController * shortcutsViewController = segue.destinationViewController;
        shortcutsViewController.navigationItem.title = entry;
        shortcutsViewController.shortcuts = _dict[entry];
    }
}

@end
