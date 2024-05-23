part of './widgets.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileWidget;
  final Widget desktopWidget;

  const ResponsiveLayout({
    super.key,
    required this.mobileWidget,
    required this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < Const.PhoneWidth) {
          return mobileWidget;
        } else {
          return desktopWidget;
        }
      },
    );
  }
}
