part of 'package:board_client/widgets/widgets.dart';

class desktopHeader extends StatelessWidget {
  const desktopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              width: 100,
              color: Colors.blue,
            )
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Row(/*children: NavItems.navItemList(context)*/),
                SizedBox(width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
