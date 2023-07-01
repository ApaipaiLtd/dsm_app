import 'dart:ui';
import 'package:flutter/material.dart';

const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData themeData = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return Builder(builder: (BuildContext context) {
        return Theme(
          data: theme ?? themeData,
          child: BackdropFilter(filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5), child: pageChild),
        );
      });
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black38, // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  final Animatable<double> dialogScaleTween = Tween<double>(begin: 1.3, end: 1.0).chain(CurveTween(curve: Curves.linearToEaseOut));
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: animation.drive(dialogScaleTween),
      child: child,
    ),
  );
}

class CustomDialog extends StatelessWidget {
  /// Creates an alert dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [titlePadding] and [contentPadding] default to null, which implies a
  /// default that depends on the values of the other properties. See the
  /// documentation of [titlePadding] and [contentPadding] for details.
  const CustomDialog({
    super.key,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticLabel,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.scrollable = false,
  });

  /// An optional icon to display at the top of the dialog.
  ///
  /// Typically, an [Icon] widget. Providing an icon centers the [title]'s text.
  final Widget? icon;

  /// Color for the [Icon] in the [icon] of this [CustomDialog].
  ///
  /// If null, [DialogTheme.iconColor] is used. If that is null, defaults to
  /// color scheme's [ColorScheme.secondary] if [ThemeData.useMaterial3] is
  /// true, black otherwise.
  final Color? iconColor;

  /// Padding around the [icon].
  ///
  /// If there is no [icon], no padding will be provided. Otherwise, this
  /// padding is used.
  ///
  /// This property defaults to providing 24 pixels on the top, left, and right
  /// of the [icon]. If [title] is _not_ null, 16 pixels of bottom padding is
  /// added to separate the [icon] from the [title]. If the [title] is null and
  /// [content] is _not_ null, then no bottom padding is provided (but see
  /// [contentPadding]). In any other case 24 pixels of bottom padding is
  /// added.
  final EdgeInsetsGeometry? iconPadding;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog, below the (optional) [icon].
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 24 pixels on the top, left, and right
  /// of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Style for the text in the [title] of this [CustomDialog].
  ///
  /// If null, [DialogTheme.titleTextStyle] is used. If that's null, defaults to
  /// [TextTheme.titleLarge] of [ThemeData.textTheme].
  final TextStyle? titleTextStyle;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog in a lighter font.
  ///
  /// Typically this is a [SingleChildScrollView] that contains the dialog's
  /// message. As noted in the [CustomDialog] documentation, it's important
  /// to use a [SingleChildScrollView] if there's any risk that the content
  /// will not fit, as the contents will otherwise overflow the dialog.
  ///
  /// The [content] must support reporting its intrinsic dimensions. In
  /// particular, [ListView], [GridView], and [CustomScrollView] cannot be used
  /// here unless they are first wrapped in a widget that itself can report
  /// intrinsic dimensions, such as a [SizedBox].
  final Widget? content;

  /// Padding around the content.
  ///
  /// If there is no [content], no padding will be provided. Otherwise, this
  /// padding is used.
  ///
  /// This property defaults to providing a padding of 20 pixels above the
  /// [content] to separate the [content] from the [title], and 24 pixels on the
  /// left, right, and bottom to separate the [content] from the other edges of
  /// the dialog.
  ///
  /// If [ThemeData.useMaterial3] is true, the top padding separating the
  /// content from the title defaults to 16 pixels instead of 20 pixels.
  final EdgeInsetsGeometry? contentPadding;

  /// Style for the text in the [content] of this [CustomDialog].
  ///
  /// If null, [DialogTheme.contentTextStyle] is used. If that's null, defaults
  /// to [TextTheme.titleMedium] of [ThemeData.textTheme].
  final TextStyle? contentTextStyle;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog with an [OverflowBar].
  ///
  /// Typically this is a list of [TextButton] widgets. It is recommended to
  /// set the [Text.textAlign] to [TextAlign.end] for the [Text] within the
  /// [TextButton], so that buttons whose labels wrap to an extra line align
  /// with the overall [OverflowBar]'s alignment within the dialog.
  ///
  /// If the [title] is not null but the [content] _is_ null, then an extra 20
  /// pixels of padding is added above the [OverflowBar] to separate the [title]
  /// from the [actions].
  final List<Widget>? actions;

  /// Padding around the set of [actions] at the bottom of the dialog.
  ///
  /// Typically used to provide padding to the button bar between the button bar
  /// and the edges of the dialog.
  ///
  /// The [buttonPadding] may contribute to the padding on the edges of
  /// [actions] as well.
  ///
  /// If there are no [actions], then no padding will be included.
  ///
  /// {@tool snippet}
  /// This is an example of a set of actions aligned with the content widget.
  /// ```dart
  /// AlertDialog(
  ///   title: const Text('Title'),
  ///   content: Container(width: 200, height: 200, color: Colors.green),
  ///   actions: <Widget>[
  ///     ElevatedButton(onPressed: () {}, child: const Text('Button 1')),
  ///     ElevatedButton(onPressed: () {}, child: const Text('Button 2')),
  ///   ],
  ///   actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  /// * [OverflowBar], which [actions] configures to lay itself out.
  final EdgeInsetsGeometry? actionsPadding;

  /// Defines the horizontal layout of the [actions] according to the same
  /// rules as for [Row.mainAxisAlignment].
  ///
  /// This parameter is passed along to the dialog's [OverflowBar].
  ///
  /// If this parameter is null (the default) then [MainAxisAlignment.end]
  /// is used.
  final MainAxisAlignment? actionsAlignment;

  /// The horizontal alignment of [actions] within the vertical
  /// "overflow" layout.
  ///
  /// If the dialog's [actions] do not fit into a single row, then they
  /// are arranged in a column. This parameter controls the horizontal
  /// alignment of widgets in the case of an overflow.
  ///
  /// If this parameter is null (the default) then [OverflowBarAlignment.end]
  /// is used.
  ///
  /// See also:
  ///
  /// * [OverflowBar], which [actions] configures to lay itself out.
  final OverflowBarAlignment? actionsOverflowAlignment;

  /// The vertical direction of [actions] if the children overflow
  /// horizontally.
  ///
  /// If the dialog's [actions] do not fit into a single row, then they
  /// are arranged in a column. The first action is at the top of the
  /// column if this property is set to [VerticalDirection.down], since it
  /// "starts" at the top and "ends" at the bottom. On the other hand,
  /// the first action will be at the bottom of the column if this
  /// property is set to [VerticalDirection.up], since it "starts" at the
  /// bottom and "ends" at the top.
  ///
  /// See also:
  ///
  /// * [OverflowBar], which [actions] configures to lay itself out.
  final VerticalDirection? actionsOverflowDirection;

  /// The spacing between [actions] when the [OverflowBar] switches to a column
  /// layout because the actions don't fit horizontally.
  ///
  /// If the widgets in [actions] do not fit into a single row, they are
  /// arranged into a column. This parameter provides additional vertical space
  /// between buttons when it does overflow.
  ///
  /// The button spacing may appear to be more than the value provided. This is
  /// because most buttons adhere to the [MaterialTapTargetSize] of 48px. So,
  /// even though a button might visually be 36px in height, it might still take
  /// up to 48px vertically.
  ///
  /// If null then no spacing will be added in between buttons in an overflow
  /// state.
  final double? actionsOverflowButtonSpacing;

  /// The padding that surrounds each button in [actions].
  ///
  /// This is different from [actionsPadding], which defines the padding
  /// between the entire button bar and the edges of the dialog.
  ///
  /// If this property is null, then it will default to
  /// 8.0 logical pixels on the left and right.
  final EdgeInsetsGeometry? buttonPadding;

  /// {@macro flutter.material.dialog.backgroundColor}
  final Color? backgroundColor;

  /// {@macro flutter.material.dialog.elevation}
  final double? elevation;

  /// {@macro flutter.material.dialog.shadowColor}
  final Color? shadowColor;

  /// {@macro flutter.material.dialog.surfaceTintColor}
  final Color? surfaceTintColor;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// In iOS, if this label is not provided, a semantic label will be inferred
  /// from the [title] if it is not null.
  ///
  /// In Android, if this label is not provided, the dialog will use the
  /// [MaterialLocalizations.alertDialogLabel] as its label.
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// {@macro flutter.material.dialog.insetPadding}
  final EdgeInsets insetPadding;

  /// {@macro flutter.material.dialog.clipBehavior}
  final Clip clipBehavior;

  /// {@macro flutter.material.dialog.shape}
  final ShapeBorder? shape;

  /// {@macro flutter.material.dialog.alignment}
  final AlignmentGeometry? alignment;

  /// Determines whether the [title] and [content] widgets are wrapped in a
  /// scrollable.
  ///
  /// This configuration is used when the [title] and [content] are expected
  /// to overflow. Both [title] and [content] are wrapped in a scroll view,
  /// allowing all overflowed content to be visible while still showing the
  /// button bar.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogTheme defaults = theme.useMaterial3 ? _DialogDefaultsM3(context) : _DialogDefaultsM2(context);

    String? label = semanticLabel;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label ??= MaterialLocalizations.of(context).alertDialogLabel;
    }

    // The paddingScaleFactor is used to adjust the padding of Dialog's
    // children.
    final double paddingScaleFactor = _paddingScaleFactor(MediaQuery.textScaleFactorOf(context));
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? iconWidget;
    Widget? titleWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    if (icon != null) {
      final bool belowIsTitle = title != null;
      final bool belowIsContent = !belowIsTitle && content != null;
      final EdgeInsets defaultIconPadding = EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        right: 24.0,
        bottom: belowIsTitle
            ? 16.0
            : belowIsContent
                ? 0.0
                : 24.0,
      );
      final EdgeInsets effectiveIconPadding = iconPadding?.resolve(textDirection) ?? defaultIconPadding;
      iconWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveIconPadding.left * paddingScaleFactor,
          right: effectiveIconPadding.right * paddingScaleFactor,
          top: effectiveIconPadding.top * paddingScaleFactor,
          bottom: effectiveIconPadding.bottom,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor ?? dialogTheme.iconColor ?? defaults.iconColor,
          ),
          child: icon!,
        ),
      );
    }

    if (title != null) {
      final EdgeInsets defaultTitlePadding = EdgeInsets.only(
        left: 24.0,
        top: icon == null ? 24.0 : 0.0,
        right: 24.0,
        bottom: content == null ? 20.0 : 0.0,
      );
      final EdgeInsets effectiveTitlePadding = titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: icon == null ? effectiveTitlePadding.top * paddingScaleFactor : effectiveTitlePadding.top,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style: titleTextStyle ?? dialogTheme.titleTextStyle ?? defaults.titleTextStyle!,
          textAlign: icon == null ? TextAlign.start : TextAlign.center,
          child: Semantics(
            // For iOS platform, the focus always lands on the title.
            // Set nameRoute to false to avoid title being announce twice.
            namesRoute: label == null && theme.platform != TargetPlatform.iOS,
            container: true,
            child: title,
          ),
        ),
      );
    }

    if (content != null) {
      final EdgeInsets defaultContentPadding = EdgeInsets.only(
        left: 24.0,
        top: theme.useMaterial3 ? 16.0 : 20.0,
        right: 24.0,
        bottom: 24.0,
      );
      final EdgeInsets effectiveContentPadding = contentPadding?.resolve(textDirection) ?? defaultContentPadding;
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: title == null && icon == null ? effectiveContentPadding.top * paddingScaleFactor : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: DefaultTextStyle(
          style: contentTextStyle ?? dialogTheme.contentTextStyle ?? defaults.contentTextStyle!,
          child: Semantics(
            container: true,
            child: content,
          ),
        ),
      );
    }

    if (actions != null) {
      final double spacing = (buttonPadding?.horizontal ?? 16) / 2;
      actionsWidget = Padding(
        padding: actionsPadding ?? dialogTheme.actionsPadding ?? (theme.useMaterial3 ? defaults.actionsPadding! : defaults.actionsPadding!.add(EdgeInsets.all(spacing))),
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.end,
          spacing: spacing,
          overflowAlignment: actionsOverflowAlignment ?? OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions!,
        ),
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (title != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (icon != null) iconWidget!,
                  if (title != null) titleWidget!,
                  if (content != null) contentWidget!,
                ],
              ),
            ),
          ),
        if (actions != null) actionsWidget!,
      ];
    } else {
      columnChildren = <Widget>[
        if (icon != null) iconWidget!,
        if (title != null) titleWidget!,
        if (content != null) Flexible(child: contentWidget!),
        if (actions != null) actionsWidget!,
      ];
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      alignment: alignment,
      child: dialogChild,
    );
  }
}

class _DialogDefaultsM3 extends DialogTheme {
  _DialogDefaultsM3(this.context)
      : super(
          alignment: Alignment.center,
          elevation: 6.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28.0))),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  Color? get iconColor => _colors.secondary;

  @override
  Color? get backgroundColor => _colors.surface;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => _colors.surfaceTint;

  @override
  TextStyle? get titleTextStyle => _textTheme.headlineSmall;

  @override
  TextStyle? get contentTextStyle => _textTheme.bodyMedium;

  @override
  EdgeInsetsGeometry? get actionsPadding => const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0);
}

// Hand coded defaults based on Material Design 2.
class _DialogDefaultsM2 extends DialogTheme {
  _DialogDefaultsM2(this.context)
      : _textTheme = Theme.of(context).textTheme,
        _iconTheme = Theme.of(context).iconTheme,
        super(
          alignment: Alignment.center,
          elevation: 24.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        );

  final BuildContext context;
  final TextTheme _textTheme;
  final IconThemeData _iconTheme;

  @override
  Color? get iconColor => _iconTheme.color;

  @override
  Color? get backgroundColor => Theme.of(context).dialogBackgroundColor;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;

  @override
  TextStyle? get titleTextStyle => _textTheme.titleLarge;

  @override
  TextStyle? get contentTextStyle => _textTheme.titleMedium;

  @override
  EdgeInsetsGeometry? get actionsPadding => EdgeInsets.zero;
}

double _paddingScaleFactor(double textScaleFactor) {
  final double clampedTextScaleFactor = clampDouble(textScaleFactor, 1.0, 2.0);
  // The final padding scale factor is clamped between 1/3 and 1. For example,
  // a non-scaled padding of 24 will produce a padding between 24 and 8.
  return lerpDouble(1.0, 1.0 / 3.0, clampedTextScaleFactor - 1.0)!;
}
