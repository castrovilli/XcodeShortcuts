//
//  SettingsViewController.m
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

#import "SettingsViewController.h"
#import "ShortcutsDatabase.h"
#import "SettingsViewController.h"
#import "UserData.h"

@implementation SettingsViewController

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

- (IBAction)fontSizeValueChanged:(id)sender
{
  int truncSize = (int) self.fontSizeSlider.value;
  self.fontSizeLabel.text = [NSString stringWithFormat:@"Font Size: %d", truncSize];
  if ([ShortcutsDatabase sharedDatabase].userData.favoritesFontSize != truncSize) {
    [[ShortcutsDatabase sharedDatabase] playClick];
    [[ShortcutsDatabase sharedDatabase] setFavoritesFontSize:truncSize];
  }
}

- (IBAction)buttonTapped:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.raywenderlich.com/store"]];
}

@end
