class CommonCapital{
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}


class GlobleValue{

  static int selectedIndex = 0;
  static   int button = 0;

}