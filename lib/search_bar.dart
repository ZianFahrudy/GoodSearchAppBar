import 'package:flutter/material.dart';

import 'debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  ///  label - String ,isRequired : No
  ///  onSearchChanged - Function(String)  ,isRequired : No
  ///  onFilterChanged - Function() ,isRequired : No
  ///  searchDecoration - InputDecoration  ,isRequired : No
  ///  searchStyle - TextStyle ,isRequired :  No
  ///  cursorColor - Color ,isRequired : No
  ///  isFilter - bool - default true
  /// searchEnabled - bool - default true
  const SearchBarWidget({
    Key? key,
    required this.label,
    required this.onSearchChanged,
    this.onFilterChanged,
    this.filter = false,
    this.focus = true,
    this.labelStyle,
    this.searchIcon,
    this.clearIcon,
    this.hintText,
    this.filterIcon,
    this.hintStyle,
    this.cursorColor,
    this.centerTitle = true,
  }) : super(key: key);

  final String label;
  final Function(String) onSearchChanged;
  final Function()? onFilterChanged;
  final bool? filter;
  final bool? focus;
  final TextStyle? labelStyle;
  final Widget? searchIcon;
  final Widget? clearIcon;
  final Widget? filterIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? cursorColor;
  final bool? centerTitle;

  @override
  State createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late bool _isSearch;
  final _fnSearch = FocusNode();
  final _debouncer = Debouncer();

  @override
  void initState() {
    if (widget.focus!) {
      _isSearch = true;
    } else {
      _isSearch = false;
    }
    if (widget.focus!) {
      _fnSearch.requestFocus();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use row as Root view
    return GestureDetector(
      onTap: () {
        if (!_isSearch) {
          setState(() {
            _isSearch = true;
            _fnSearch.requestFocus();
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // if (widget.searchEnabled!) const SizedBox(width: 50),
          // Handle Animated Change view for Title and TextField Search
          Expanded(
            // Use animated Switcher to show animation in transition widget
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //animated from right to left
                final inAnimation =
                    Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                        .animate(animation);
                //animated from left to right
                final outAnimation =
                    Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                        .animate(animation);

                // show different animation base on key
                if (child.key == const ValueKey('textF')) {
                  return ClipRect(
                    child: SlideTransition(position: inAnimation, child: child),
                  );
                } else {
                  return ClipRect(
                    child:
                        SlideTransition(position: outAnimation, child: child),
                  );
                }
              },
              child: _isSearch
                  ?
                  //Container of SearchView
                  SizedBox(
                      key: const ValueKey('textF'),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          focusNode: _fnSearch,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          minLines: 1,
                          cursorColor: widget.cursorColor ??
                              Theme.of(context).primaryColor,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: widget.hintText ?? 'Search...',
                            hintStyle: widget.hintStyle,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onChanged: (value) {
                            _debouncer.run(() {
                              widget.onSearchChanged(value);
                            });
                          },
                        ),
                      ),
                    )
                  :
                  //Container of Label
                  SizedBox(
                      key: const ValueKey('align'),
                      height: 60,
                      child: Align(
                        alignment: widget.centerTitle!
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Text(
                          widget.label,
                          style: widget.labelStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
            ),
          ),
          // Handle Animated Change view for Search Icon and Close Icon
          // if (widget.searchEnabled!)
          IconButton(
            padding: EdgeInsets.zero,
            icon:
                // Use animated Switcher to show animation in
                // transition widget
                AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //animated from top to bottom
                final inAnimation =
                    Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                        .animate(animation);
                //animated from bottom to top
                final outAnimation = Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation);

                // show different animation base on key
                if (child.key == const ValueKey('close')) {
                  return ClipRect(
                    child: SlideTransition(
                      position: inAnimation,
                      child: child,
                    ),
                  );
                } else {
                  return ClipRect(
                    child:
                        SlideTransition(position: outAnimation, child: child),
                  );
                }
              },
              child: _isSearch
                  ? widget.clearIcon ??
                      //if is search, set icon as Close
                      const Icon(
                        Icons.close,
                        key: ValueKey('close'),
                      ) //if is !search, set icon as Search
                  : widget.searchIcon ??
                      const Icon(
                        Icons.search,
                        key: ValueKey('search'),
                      ),
            ),
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
                if (!_isSearch) widget.onSearchChanged('');

                if (_isSearch) _fnSearch.requestFocus();
              });
            },
          ),
          if (widget.filter!)
            _isSearch
                ? const SizedBox.shrink()
                : IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: widget.onFilterChanged,
                    icon: widget.filterIcon ?? const Icon(Icons.filter_alt),
                  )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
