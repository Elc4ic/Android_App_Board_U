part of 'package:board_client/widgets/widgets.dart';

PreferredSizeWidget header = const PreferredSize(
  preferredSize: Size.fromHeight(Const.HeaderHight),
  child: ResponsiveLayout(
    mobileWidget: MobileSearchHeader(),
    desktopWidget: desktopHeader(),
  ),
);