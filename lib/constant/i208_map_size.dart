class I208MapSize {
  static final I208MapSize instance = I208MapSize._internal();
  static const mapTop = 868;
  static const mapLeft = 478;
  static const width = 844;
  static const height = 671;
  static const x = 13;
  static const y = 12;

  I208MapSize._internal();

  factory I208MapSize() => instance;

  int convertToMapX(int pinX) => x - ((pinX - mapLeft) / width * x).floor();

  int convertToMapY(int pinY) => y - ((pinY - mapTop) / height * y).floor();

  int convertToPinX(int mapX) =>
      ((-mapX + 0.5) * width / x + mapLeft + width).ceil();

  int convertToPinY(int mapY) =>
      ((-mapY + 0.7) * height / y + mapTop + height).floor();
}
