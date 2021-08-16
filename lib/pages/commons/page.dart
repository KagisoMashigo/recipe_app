// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
// import 'package:pom/plugins/responsive.dart';

/// [BasePage] is the base implementation of a page in the application. It has the light background asset
/// and is used on all pages with exception of the home page, where a different approach is desired.
///
/// [BasePage] do not have connectivity awareness. This must be wrapped on the desired page.
///
/// ## Example
///
/// ### Refresh Indicator
///
/// {@tool snippet}
/// ```dart
/// BasePage(
///   title: title,
///   child: RefreshIndicator(
///      onRefresh: () async => fn(),
///      child: SingleChildScrollView(
///        physics: AlwaysScrollableScrollPhysics(),
///        child: child,
///      ),
///   ),
/// );
/// ```
/// {@end-tool}
///
/// ### Single Child Scroll View
///
/// {@tool snippet}
/// ```dart
/// BasePage(
///   title: title,
///   child: SingleChildScrollView(
///       physics: AlwaysScrollableScrollPhysics(),
///       child: child,
///     ),
///   ),
/// );
/// ```
/// {@end-tool}
class BasePage extends StatelessWidget {
  const BasePage({
    Key key,
    @required this.title,
    @required this.child,
    this.fontSize,
    this.globalKey,
    this.actions = const [],
    this.horizontalPadding = 2.5,
    this.verticalPadding = 1.5,
    this.allowReturn = true,
    this.centeredTitle = false,
  }) : super(key: key);

  /// The title of the page
  final String title;

  /// Actions to be shown on the page bar, after [title]
  final List<Widget> actions;

  /// Any specific font size for the title
  final double fontSize;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  /// If the user is allowed to return to previosu page. Defaults to true.
  final bool allowReturn;

  /// If the title is desired to be on the center of the [AppBar]. Defaults to false
  final bool centeredTitle;

  /// The content of the page
  ///
  /// The child is not wrapped in any form of [SingleChildScrollView] or [RefreshIndicator].
  final Widget child;

  /// The Scaffold GlobalKey Nullable
  final GlobalKey<ScaffoldState> globalKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent swipe back action
      onWillPop: () async => allowReturn ? true : null,
      child: LightBackgroundContainer(
        child: Scaffold(
          key: globalKey,
          backgroundColor: Colors.transparent,
          appBar: title.isNotEmpty
              ? PageAppBar(
                  title: title,
                  fontSize: fontSize,
                  allowReturn: allowReturn,
                  actions: actions,
                  centeredTitle: centeredTitle,
                )
              : null,
          body: PaddedChild(
            left: horizontalPadding,
            right: horizontalPadding,
            top: verticalPadding,
            bottom: verticalPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// [TabedPage] is the base implementation of a page that has tabs to navigate in it's subpages.  It
/// has the light background asset and is used on the reports pages
///
/// [TabedPage] do not have connectivity awareness. This must be wrapped on the desired page.
/// [TabedPage] is stateless, but it's [children] most likely have a state and may use a provider
///
/// The ammount of widgets as [children] *MUST* match the same amount of [navigationTab] elements.
///
/// ## Example
///
/// {@tool snippet}
///
/// ```dart
///
/// TabedPage(
///   pageTitle: 'Test',
///   navigationTabs: <Widget>[...];,
///   children: <Widget>[...],
/// );
/// ```
/// {@end-tool}
class TabedPage extends StatelessWidget {
  const TabedPage({
    Key key,
    @required this.title,
    @required this.children,
    @required this.navigationTabs,
    this.actions = const [],
    this.initialIndex = 0,
    this.horizontalPadding = 2.5,
    this.verticalPadding = 1.5,
    this.fontSize,
    this.globalKey,
  }) : super(key: key);

  /// The title of the page
  final String title;

  /// The actual page that each tab display. The order of elements here also matches the order in
  /// [navigationTabs]. Also, it must have the same amount of items as [navigationTabs]
  ///
  /// The children are not wrapped in any form of [SingleChildScrollView] or [RefreshIndicator].
  final List<Widget> children;

  /// The navigation tabs at the bottom of the App bar. The order of elements here also matches the
  /// order in [children]. Also, it must have the same amount of items as [children]
  final List<Widget> navigationTabs;

  /// Actions to be shown on the page bar, after [title]
  final List<Widget> actions;

  /// Any specific font size for the title
  final double fontSize;

  /// The desired initial index. Default is 0.
  final int initialIndex;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  /// The Scaffold GlobalKey Nullable
  final GlobalKey<ScaffoldState> globalKey;

  /// Maps every [_children] into a layout that can be displayed in the tab view. Each child is wrapped
  /// in a [LayoutBuilder] inside a [SingleChildScrollView] with [AlwaysScrollableScrollPhysics] and return
  /// a List of all of them.
  List<Widget> _buildTabChildren() => children
      .map<Widget>(
        (Widget page) => LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: PaddedChild(
              child: page,
              left: horizontalPadding,
              right: horizontalPadding,
              top: verticalPadding,
              bottom: verticalPadding,
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LightBackgroundContainer(
      child: DefaultTabController(
        initialIndex: initialIndex,
        length: navigationTabs.length,
        child: Scaffold(
          key: globalKey,
          backgroundColor: Colors.transparent,
          appBar: PageAppBar(
            title: title,
            fontSize: fontSize,
            bottom: NavigationTab(
              tabValues: navigationTabs,
              indicatorColor: theme.primaryColor,
            ),
          ),
          body: TabBarView(
            children: _buildTabChildren(),
          ),
        ),
      ),
    );
  }
}

/// Implementation of the [BasePage] where the content, i.e., the child widget, is a [SingleChildScrollView]
class ScrollablePage extends StatelessWidget {
  const ScrollablePage({
    Key key,
    @required this.child,
    this.actions,
    this.globalKey,
    this.allowReturn = true,
    this.centeredTitle = false,
    this.horizontalPadding = 2.5,
    this.title = '',
    this.titleFontSize = 20,
    this.verticalPadding = 1.5,
  }) : super(key: key);

  /// Actions to be shown on the page bar, after [title]
  final List<Widget> actions;

  /// If we are providing a way to return to previous page. Defaults to true.
  final bool allowReturn;

  /// If the title is desired to be on the center of the [AppBar]. Defaults to false
  final bool centeredTitle;

  /// The content to be wrapped in the [ScrollablePaddedContent]
  final Widget child;

  /// The Scaffold GlobalKey Nullable
  final GlobalKey<ScaffoldState> globalKey;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The title of the page. Nullable
  final String title;

  /// The desired size of the title font
  final double titleFontSize;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      globalKey: globalKey,
      title: title,
      fontSize: titleFontSize,
      horizontalPadding: 0,
      verticalPadding: 0,
      actions: actions,
      allowReturn: allowReturn,
      centeredTitle: centeredTitle,
      child: ScrollablePaddedContent(
        child: child,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
      ),
    );
  }
}

class RefresheablePage extends StatelessWidget {
  const RefresheablePage({
    Key key,
    this.title,
    @required this.refreshAction,
    @required this.child,
    this.horizontalPadding = 2.5,
    this.verticalPadding = 1.5,
    this.titleFontSize = 20,
    this.globalKey,
    this.actions,
  }) : super(key: key);

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  /// The title of the page. Nullable
  final String title;

  /// The desired size of the title font
  final double titleFontSize;

  /// Actions to be shown on the page bar, after [title]
  final List<Widget> actions;

  /// The refresh action to be called by the [RefreshIndicator]
  final RefreshCallback refreshAction;

  /// The content to be wrapped in the [ScrollablePaddedContent]
  final Widget child;

  /// The Scaffold GlobalKey Nullable
  final GlobalKey<ScaffoldState> globalKey;
  @override
  Widget build(BuildContext context) {
    return BasePage(
      globalKey: globalKey,
      title: title ?? ' ',
      fontSize: titleFontSize,
      horizontalPadding: 0,
      verticalPadding: 0,
      actions: actions,
      child: RefresheablePaddedContent(
        child: child,
        onRefresh: refreshAction,
      ),
    );
  }
}

/// [Container] Widget that uses the light background asset with fit cover as a background
class LightBackgroundContainer extends Container {
  /// A [Container] that uses the light background asset with [BoxFit.cover] as background
  LightBackgroundContainer({
    Key key,
    @required Widget child,
  }) : super(
          key: key,
          child: child,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/light.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
}

/// PageAppBar extends [AppBar] widget and add the POM styling, including the use of actions and page tab.
///
/// Page tabs are controlled by the [bottom] while actions are kept on [actions].
/// The [title] is wrapped in a [Container], but mind to avoid long page titles (Recommended less
/// than 20 characters)
class PageAppBar extends AppBar {
  PageAppBar({
    Key key,
    @required String title,
    this.fontSize,
    this.actions,
    this.bottom,
    this.allowReturn = true,
    this.centeredTitle = false,
  }) : super(
          key: key,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: centeredTitle,
          automaticallyImplyLeading: allowReturn,
          title: Container(
            child: Text(
              title,
              overflow: TextOverflow.fade,
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize ?? 28,
              ),
            ),
          ),
          actions: actions,
          bottom: bottom,
        );

  /// The actions, if any. Null as optional. Usually is a single widget with a button, such as [IconButton]
  final List<Widget> actions;

  /// The navigation [NavigationTab]. It must be used only with [TabedPage]!
  final PreferredSizeWidget bottom;

  /// The font size in the title. It will be used a font size 28 if the size is omitted
  final double fontSize;

  /// If the title is centered or not in the [AppBar]. Defaults to false
  final bool centeredTitle;

  /// used in [AppBar.automaticallyImplyLeading]
  final bool allowReturn;
}

/// The [PageAppBar.bottom] part of an [PageAppBar] and in conjunction with a [TabBarView] page such as
/// the one used in [TabedPage]
class NavigationTab extends TabBar {
  /// Create a TabBar with the tab values (i.e. the identification of the page to the user) with the
  /// POM Styling and with the desired indicator color
  NavigationTab({
    Key key,
    @required this.tabValues,
    @required this.indicatorColor,
  }) : super(
          key: key,
          tabs: tabValues,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
          indicatorColor: indicatorColor,
          indicatorWeight: 3,
        );

  /// The name, wrapped in a widget, that holds the name/meaning of the desired navigation page
  final List<Widget> tabValues;

  /// The indicator Color. Normally, is the [ThemeData.primaryColor]
  final Color indicatorColor;
}

/// A symmetrical Padding for the child widget
class PaddedChild extends Padding {
  /// Provides a symmetrical padding with a factor of 2.5 the [Responsive.ratioHorizontal] and 1.5 the
  /// [Responsive.ratioVertical].
  ///
  /// It offers a finer grain to the factor of each one of the LRTB sides. Omitting any of the values
  /// will cause the use of the default of 2.5 for any omitted horizontal value or 1.5 for any omitted
  /// vertical value
  PaddedChild({
    Key key,
    @required Widget child,
    double left = 2.5,
    double right = 2.5,
    double top = 1.5,
    double bottom = 1.5,
  }) : super(
          key: key,
          child: child,
          padding: EdgeInsets.only(
            // TODO: make this responsive
            left: left * 4,
            right: right * 4,
            top: top * 4,
            bottom: bottom * 4,
          ),
        );
}

/// The content of a page that is wrapped in a [SingleChildScrollView] and with a [PaddedChild].
class ScrollablePaddedContent extends StatelessWidget {
  /// The [ScrollablePaddedContent] uses the parent widget constraints to build a [LayoutBuilder] that
  /// is Scrollable through a [SingleChildScrollView] that has a [ConstrainedBox] holding the
  /// [ScrollablePaddedContent.child] inside a [PaddedChild]
  const ScrollablePaddedContent({
    Key key,
    @required this.child,
    this.horizontalPadding = 2.5,
    this.verticalPadding = 1.5,
  }) : super(key: key);

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: PaddedChild(
              left: horizontalPadding,
              right: horizontalPadding,
              top: verticalPadding,
              bottom: verticalPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

typedef RefreshCallback = Future<void> Function();

/// The content of a page that is wrapped in a [RefreshIndicator] that and with a [PaddedChild] in a
/// [SingleChildScrollView]
class RefresheablePaddedContent extends StatelessWidget {
  /// The [RefresheablePaddedContent] uses the parent widget constraints to build a [LayoutBuilder] that
  /// has a [RefreshIndicator] in a [SingleChildScrollView] that has a [ConstrainedBox] holding the
  /// [ScrollablePaddedContent.child] inside a [PaddedChild]
  const RefresheablePaddedContent({
    Key key,
    @required this.child,
    @required this.onRefresh,
    this.horizontalPadding = 2.5,
    this.verticalPadding = 1.5,
  }) : super(key: key);

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double horizontalPadding;

  /// The override factor of the horizontal padding to be applied in the child. Applied on both ends
  final double verticalPadding;

  /// The refresh action to be called by the [RefreshIndicator]
  final RefreshCallback onRefresh;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: onRefresh,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: PaddedChild(
                left: horizontalPadding,
                right: horizontalPadding,
                top: verticalPadding,
                bottom: verticalPadding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
