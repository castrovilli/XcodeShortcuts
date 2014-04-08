//
//  Shortcut.m
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

#import "Shortcut.h"

@implementation Shortcut

- (id)initWithKey:(NSString *)key action:(NSString *)action modifierCommand:(BOOL)modifierCommand modifierOption:(BOOL)modifierOption modifierShift:(BOOL)modifierShift modifierControl:(BOOL)modifierControl
{
  if ((self = [super init])) {
    self.key = key;
    self.action = action;
    self.modifierCommand = modifierCommand;
    self.modifierOption = modifierOption;
    self.modifierShift = modifierShift;
    self.modifierControl = modifierControl;
    
    // Format keystroke for display
    NSMutableArray * parts = [NSMutableArray array];
    if (self.modifierControl) {
      [parts addObject:@"⌃"];
    }
    if (self.modifierOption) {
      [parts addObject:@"⌥"];
    }
    if (self.modifierShift) {
      [parts addObject:@"⇧"];
    }
    if (self.modifierCommand) {
      [parts addObject:@"⌘"];
    }
    [parts addObject:self.key];
    self.keystroke = [parts componentsJoinedByString:@""];    
  }
  return self;
}

- (id)initWithKeystroke:(NSString *)keystroke action:(NSString *)action
{
  NSArray * splitKeystroke = [keystroke componentsSeparatedByString:@"-"];
  NSAssert(splitKeystroke.count > 0, @"Invalid keystroke");

  NSString * key = splitKeystroke[0];
  BOOL modifierCommand = NO;
  BOOL modifierOption = NO;
  BOOL modifierShift = NO;
  BOOL modifierControl = NO;
  for (int i = 1; i < splitKeystroke.count; ++i) {
    NSString * component = splitKeystroke[i];
    if ([component compare:@"command" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      modifierCommand = YES;
    } else if ([component compare:@"option" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      modifierOption = YES;
    } else if ([component compare:@"shift" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      modifierShift = YES;
    } else if ([component compare:@"control" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      modifierControl = YES;
    }
  }
  
  return [self initWithKey:key action:action modifierCommand:modifierCommand modifierOption:modifierOption modifierShift:modifierShift modifierControl:modifierControl];  
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@: %@", self.action, self.keystroke];
}

- (NSComparisonResult)compare:(Shortcut *)other
{
  return [self.action compare:other.action];
}

- (BOOL)isEqual:(id)object
{
  if ([object isKindOfClass:[self class]]) {
    Shortcut * other = (Shortcut *) object;
    return [other.key compare:self.key] == NSOrderedSame && other.modifierCommand == self.modifierCommand && other.modifierShift == self.modifierShift && other.modifierOption == self.modifierOption && other.modifierControl == self.modifierControl && [other.action compare:self.action] == NSOrderedSame;
  }
  return FALSE;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:self.key forKey:@"key"];
  [aCoder encodeObject:self.action forKey:@"action"];
  [aCoder encodeBool:self.modifierCommand forKey:@"modifierCommand"];
  [aCoder encodeBool:self.modifierOption forKey:@"modifierOption"];
  [aCoder encodeBool:self.modifierShift forKey:@"modifierShift"];
  [aCoder encodeBool:self.modifierControl forKey:@"modifierControl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  NSString * key = [aDecoder decodeObjectForKey:@"key"];
  NSString * action = [aDecoder decodeObjectForKey:@"action"];
  BOOL modifierCommand = [aDecoder decodeBoolForKey:@"modifierCommand"];
  BOOL modifierOption = [aDecoder decodeBoolForKey:@"modifierOption"];
  BOOL modifierShift = [aDecoder decodeBoolForKey:@"modifierShift"];
  BOOL modifierControl = [aDecoder decodeBoolForKey:@"modifierControl"];
  return [self initWithKey:key action:action modifierCommand:modifierCommand modifierOption:modifierOption modifierShift:modifierShift modifierControl:modifierControl];
}

@end
