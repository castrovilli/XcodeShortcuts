//
//  MainMenuViewController.m
//  Shortcuts
//
//  Created by Ray Wenderlich on 9/25/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ShortcutsDatabase.h"
#import "DictionaryViewController.h"
#import "SearchableShortcutsViewController.h"

@implementation MainMenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"text_mainmenu"]];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = imageView;
  self.navigationItem.backBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"Back"
                   style:UIBarButtonItemStyleBordered
                  target:self
                  action:@selector(handleBack:)];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"ShortcutsByKey"]) {
    [[ShortcutsDatabase sharedDatabase] playClick];
    DictionaryViewController * dictionaryViewController = (DictionaryViewController *) segue.destinationViewController;
    dictionaryViewController.navigationController.title = @"Keys";
    dictionaryViewController.dict = [ShortcutsDatabase sharedDatabase].shortcutsByKey;
  } else if ([segue.identifier isEqualToString:@"ShortcutsByMenu"]) {
    [[ShortcutsDatabase sharedDatabase] playClick];
    DictionaryViewController * dictionaryViewController = (DictionaryViewController *) segue.destinationViewController;
    dictionaryViewController.navigationController.title = @"Menus";
    dictionaryViewController.dict = [ShortcutsDatabase sharedDatabase].shortcutsByMenu;
  } else if ([segue.identifier isEqualToString:@"AllShortcuts"]) {
    [[ShortcutsDatabase sharedDatabase] playClick];
    SearchableShortcutsViewController * shortcutsViewController = (SearchableShortcutsViewController *) segue.destinationViewController;
    shortcutsViewController.navigationItem.title = @"All Shortcuts";
    shortcutsViewController.shortcutsDict = [ShortcutsDatabase sharedDatabase].shortcutsByKey;
  }
}

@end
