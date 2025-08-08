import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  final String textSearch;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;
  final BorderRadiusGeometry? borderRadiusInput;

  const SearchBarWidget({
    Key? key,
    required this.textSearch,
    required this.hintText,
    required this.onChanged,
    required this.onSubmit,
    this.borderRadiusInput,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Color(0xff403F4D), fontWeight: FontWeight.w400, fontSize: 16, height: 1.2);
    const styleHint = TextStyle(color: Color(0xffA5A5AB), fontWeight: FontWeight.w400, fontSize: 16, height: 1.2);
    final style = widget.textSearch.isEmpty ? styleHint : styleActive;
    return Container(
      // height: 48,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color(0xFFF6F6F6)),
          borderRadius: widget.borderRadiusInput ?? BorderRadius.circular(50),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: widget.onSubmit,
        onChanged: widget.onChanged,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 16, top: 11, bottom: 11, right: 16),
          hintText: widget.hintText,
          constraints: BoxConstraints(minHeight: 32, maxHeight: 46),
          hintStyle: style,
          border: InputBorder.none,
          suffixIcon: Container(
            height: 24,
            child: IconButton(
              constraints: BoxConstraints(minWidth: 24, minHeight: 24),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size(24, 24)),
                fixedSize: MaterialStateProperty.all(Size(24, 24)),
                maximumSize: MaterialStateProperty.all(Size(24, 24)),
              ),
              icon: Icon(
                Icons.search_outlined,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                // widget.onChanged('');
                // widget.onSubmit('');
              },
            ),
          ),
        ),
        style: style,
      ),
    );
  }
}
