enum PictureSize {
  small, medium, large
}

extension PictureSizeExtension on PictureSize {
  static const urlValues = {
    PictureSize.small: 'S',
    PictureSize.medium: 'M',
    PictureSize.large: 'L',
  };

  String get urlValue => urlValues[this]!;
}
