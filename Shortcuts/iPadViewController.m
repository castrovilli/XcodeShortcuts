//
//  iPadViewController.m
//  Shortcuts
//
//  Created by Ray Wenderlich on 9/25/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "iPadViewController.h"
#import "ShortcutsDatabase.h"
#import "DictionaryViewController.h"
#import "SearchableShortcutsViewController.h"
#import "FavoritesViewController.h"
#import "SettingsViewController.h"

@interface iPadViewController ()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation iPadViewController {
  UINavigationController * _navControllerLeft;
  UINavigationController * _navControllerMiddle;
  SearchableShortcutsViewController * _allShortcuts;
  FavoritesViewController * _favorites;
  SettingsViewController * _settings;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_200.png"]];
  
  _navControllerLeft = [self.storyboard instantiateViewControllerWithIdentifier:@"ShortcutsNav"];
  DictionaryViewController * shortcutsByKey = _navControllerLeft.viewControllers[0];
  shortcutsByKey.navigationItem.title = @"Keys";
  shortcutsByKey.dict = [ShortcutsDatabase sharedDatabase].shortcutsByKey;
  _navControllerLeft.view.frame = self.leftView.bounds;
  [self.leftView addSubview:_navControllerLeft.view];
  
  _navControllerMiddle = [self.storyboard instantiateViewControllerWithIdentifier:@"ShortcutsNav"];
  DictionaryViewController * shortcutsByMenu = _navControllerMiddle.viewControllers[0];
  shortcutsByMenu.navigationItem.title = @"Keys";
  shortcutsByMenu.dict = [ShortcutsDatabase sharedDatabase].shortcutsByMenu;
  _navControllerMiddle.view.frame = self.leftView.bounds;
  [self.middleView addSubview:_navControllerMiddle.view];
  
  _allShortcuts = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchableShortcuts"];
  _allShortcuts.navigationItem.title = @"All Shortcuts";
  _allShortcuts.shortcutsDict = [ShortcutsDatabase sharedDatabase].shortcutsByKey;
  _allShortcuts.view.frame = self.rightView.bounds;
  [self.rightView addSubview:_allShortcuts.view];
  
  _favorites = [self.storyboard instantiateViewControllerWithIdentifier:@"Favorites"];
  _favorites.view.frame = self.bottomView.bounds;
  _favorites.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.bottomView addSubview:_favorites.view];
  
  _settings = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
  
}

- (IBAction)favoritesButtonTapped:(id)sender
{
  [[ShortcutsDatabase sharedDatabase] playClick];
  [UIView transitionWithView:self.bottomView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
    [_settings.view removeFromSuperview];
    _favorites.view.frame = self.bottomView.bounds;
    [self.bottomView addSubview:_favorites.view];
  } completion:NULL];
}

- (IBAction)settingsButtonTapped:(id)sender
{
  [[ShortcutsDatabase sharedDatabase] playClick];
  [UIView transitionWithView:self.bottomView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
    [_favorites.view removeFromSuperview];
    _settings.view.frame = self.bottomView.bounds;
    [self.bottomView addSubview:_settings.view];
  } completion:NULL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
}

@end
