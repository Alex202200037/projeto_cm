class MainNavigationController {
  static final MainNavigationController _instance = MainNavigationController._internal();
  factory MainNavigationController() => _instance;
  MainNavigationController._internal();

  void Function(int)? changeTab;
}

class ManagementPageController {
  static final ManagementPageController _instance = ManagementPageController._internal();
  factory ManagementPageController() => _instance;
  ManagementPageController._internal();

  void Function(int)? changeSection;
} 