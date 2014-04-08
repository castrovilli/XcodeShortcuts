//
//  ShortcutsDatabase.m
//  Shortcuts
//
//  Created by Ray Wenderlich on 9/21/11.
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

#import "ShortcutsDatabase.h"
#import "Shortcut.h"
#import "UserData.h"

@implementation ShortcutsDatabase {
  SystemSoundID _clickSound;
  SystemSoundID _paperSound;
  SystemSoundID _rustleSound;
}

+ (ShortcutsDatabase *) sharedDatabase {
  static dispatch_once_t once;
  static ShortcutsDatabase * sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (void)loadShortcuts
{
  
  // Read Shortcuts.plist
  NSString * path = [[NSBundle mainBundle] pathForResource:@"Shortcuts" ofType:@"plist"];
  NSDictionary * plistAsDict = [NSDictionary dictionaryWithContentsOfFile:path];
  NSAssert(plistAsDict != nil, @"Couldn't load Shortcuts.plist!");
  
  // Parse root keys
  self.menusArray = plistAsDict[@"Menus"];
  NSAssert(self.menusArray != nil, @"Couldn't load Menus entry!");
  NSArray * keysArray = plistAsDict[@"Keys"];
  NSAssert(keysArray != nil, @"Couldn't load Keys entry!");
  
  // Create shortcutsByMenu
  self.shortcutsByMenu = [NSMutableDictionary dictionary];
  for (NSString * menuName in self.menusArray) {
    NSMutableArray * menu = [NSMutableArray array];
    self.shortcutsByMenu[menuName] = menu;
  }
  
  // Create shortcutsByKey
  self.shortcutsByKey = [NSMutableDictionary dictionary];
  
  // Loop through all keys
  for (NSDictionary * keyDict in keysArray) {
    
    // Parse dictionary
    NSString * key = keyDict[@"key"];
    NSString * action = keyDict[@"action"];
    NSString * menuName = keyDict[@"menu"];
    NSAssert(key != nil, @"Missing key entry!");
    NSAssert(action != nil, @"Missing action entry!");
    
    // Create shortcut
    Shortcut * shortcut = [[Shortcut alloc] initWithKeystroke:key action:action];
    
    // Add to shortcutsByMenu
    if (menuName != nil && menuName.length > 0) {
      NSMutableArray * menu = self.shortcutsByMenu[menuName];
      NSAssert(menu != nil, @"Invalid menu name");      
      [menu addObject:shortcut];
    }
    
    // Add to shortcutsByKey
    NSMutableArray * keys = self.shortcutsByKey[shortcut.key];
    if (keys == nil) {
      keys = [NSMutableArray array];
      self.shortcutsByKey[shortcut.key] = keys;
    }
    [keys addObject:shortcut];
    
  }
  
}

- (NSString *)userDataPath
{
  NSArray * docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * docDir = [docDirs objectAtIndex:0];
  NSString * userDataPath = [docDir stringByAppendingPathComponent:@"userData.plist"];
  return userDataPath;
}

- (void)loadUserData
{
  
  NSString * userDataPath = [self userDataPath];
  if ([[NSFileManager defaultManager] fileExistsAtPath:userDataPath]) {
    NSData * userDataData = [NSData dataWithContentsOfFile:userDataPath];
    self.userData = [NSKeyedUnarchiver unarchiveObjectWithData:userDataData];
  } else {
    self.userData = [[UserData alloc] initWithFavorites:[NSMutableArray array] favoritesFontSize:16.0];
  }
  
}

- (void)loadSounds
{
  NSString *clickPath = [[NSBundle mainBundle] pathForResource:@"click10" ofType:@"wav"];
  NSURL *clickURL = [NSURL fileURLWithPath:clickPath];
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)clickURL, &_clickSound);
  
  NSString *paperPath = [[NSBundle mainBundle] pathForResource:@"paper4" ofType:@"wav"];
  NSURL *paperURL = [NSURL fileURLWithPath:paperPath];
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)paperURL, &_paperSound);
  
  NSString *rustlePath = [[NSBundle mainBundle] pathForResource:@"rustle4" ofType:@"wav"];
  NSURL *rustleURL = [NSURL fileURLWithPath:rustlePath];
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)rustleURL, &_rustleSound);
}

- (void)saveUserData
{
  NSString * userDataPath = [self userDataPath];
  NSData * userDataData = [NSKeyedArchiver archivedDataWithRootObject:self.userData];
  [userDataData writeToFile:userDataPath atomically:YES];
}

- (BOOL)addFavorite:(Shortcut *)favorite
{
  if (![self.userData.favorites containsObject:favorite]) {
    [self playPaper];
    [self.userData.favorites addObject:favorite];
    [self saveUserData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddFavorite" object:favorite];
    return TRUE;
  } else {
    [self playClick];
    return FALSE;
  }
}

- (void)removeFavorite:(Shortcut *)favorite
{
  [self.userData.favorites removeObject:favorite];
  [self saveUserData];
}

- (void)setFavoritesFontSize:(float)fontSize
{
  self.userData.favoritesFontSize = fontSize;
  [self saveUserData];
}

- (id)init
{
  if ((self = [super init])) {
    [self loadShortcuts];
    [self loadUserData];
    [self loadSounds];
  }
  return self;
}

- (void)playClick
{
  AudioServicesPlaySystemSound(_clickSound);
}

- (void)playPaper
{
  AudioServicesPlaySystemSound(_paperSound);
}

- (void)playRustle
{
  AudioServicesPlaySystemSound(_rustleSound);
}

@end
