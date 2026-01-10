// text_scanner_state.dart
class TextScannerState {
  final bool isLoading;
  final String text;

  const TextScannerState({
    this.isLoading = false,
    this.text = '',
  });

  TextScannerState copyWith({
    bool? isLoading,
    String? text,
  }) {
    return TextScannerState(
      isLoading: isLoading ?? this.isLoading,
      text: text ?? this.text,
    );
  }
}
