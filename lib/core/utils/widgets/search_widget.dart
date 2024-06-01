import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  final String textSearch;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;

  const SearchBarWidget({
    Key? key,
    required this.textSearch,
    required this.hintText,
    required this.onChanged,
    required this.onSubmit,
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: Color(0xFFF4F6F9),
          color: Colors.white),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: widget.onSubmit,
        onChanged: widget.onChanged,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
            prefixIcon: Row(children: [
              SvgPicture.asset(
                'assets/icons/search-normal.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 12,
              ),
            ]),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 36,
            ),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/horizontal-container.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                widget.onChanged('');
                controller.clear();

                widget.onSubmit('');
                // FocusScope.of(context).requestFocus(
                //   FocusNode(),
                // );
              },
            )
            // suffixIconConstraints: const BoxConstraints(
            //   maxHeight: 22,
            //   maxWidth: 22,
            // ),
            ),
        style: style,
      ),
    );
  }
}
