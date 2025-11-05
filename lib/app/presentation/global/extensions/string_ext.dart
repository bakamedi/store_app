extension StringExt on String {
  /// Verifica si el string es una URL válida (http o https)
  bool get isValidUrl {
    final uri = Uri.tryParse(this);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  /// Verifica si es una URL de imagen (.jpg, .png, etc.)
  bool get isValidImageUrl {
    if (!isValidUrl) return false;
    final imageRegex = RegExp(
      r'\.(jpeg|jpg|png|gif|bmp|webp)$',
      caseSensitive: false,
    );
    return imageRegex.hasMatch(this);
  }
}
