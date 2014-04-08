//
//  ShortcutsViewController.m
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

#import "ShortcutsViewController.h"
#import "Shortcut.h"
#import "ShortcutsDatabase.h"

@implementation ShortcutsViewController

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
  [super viewWillAppear:animated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
  [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [[ShortcutsDatabase sharedDatabase] playClick];
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
  return _shortcuts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  Shortcut * shortcut = [_shortcuts objectAtIndex:indexPath.row];
  cell.textLabel.text = shortcut.keystroke;
  cell.detailTextLabel.text = shortcut.action;
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  Shortcut * shortcut = [_shortcuts objectAtIndex:indexPath.row];
  [[ShortcutsDatabase sharedDatabase] addFavorite:shortcut];
}

@end
