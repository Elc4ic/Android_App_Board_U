part of 'values.dart';

class Styles {
  static TextStyle navBarText() {
    return GoogleFonts.bitter(
      fontSize: Markup.size_12,
    );
  }

  static Widget TitleText32(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontWeight: FontWeight.w800,
        fontSize: Markup.size_32,
      ),
    );
  }

  static Widget TitleText24(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontWeight: FontWeight.w800,
        fontSize: Markup.size_24,
      ),
    );
  }

  static Widget Text24(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontSize: Markup.size_24,
      ),
    );
  }

  static Widget Text16(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontSize: Markup.size_16,
      ),
    );
  }

  static Widget Text12(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontSize: Markup.size_12,
      ),
    );
  }

  static Widget TitleText16(String data) {
    return Text(
      data,
      style: GoogleFonts.bitter(
        fontWeight: FontWeight.w800,
        fontSize: Markup.size_16,
      ),
    );
  }
}
