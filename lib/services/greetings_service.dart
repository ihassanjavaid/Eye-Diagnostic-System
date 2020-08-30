class Greetings{
  static String showGreetings() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12 && (timeNow > 3)) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow <= 22)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}