import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class DropdownSearchB extends StatefulWidget {
  const DropdownSearchB(
      {Key? key,
      this.dropdownHeight = 48,
      this.dropdownWidth,
      this.icon = Icons.keyboard_arrow_down,
      required this.items,
      required this.selected,
      this.setState = false,
      this.errorText = '',
      this.borderColor = bExtraLightGray,
      this.bgColor = bWhite,
      this.label = '',
      this.isMandatory = false,
      this.dropDownValue,
      this.hint = 'Select',
      this.isMultiple = false,
      this.canTag = false,
      this.labelSize = 16,
      this.padding = 5,
      this.onTap,
      this.loading = false})
      : super(key: key);

  final double dropdownHeight;
  final double? dropdownWidth;
  final IconData? icon;
  final List<DropdownItem> items;
  final Function selected;
  final bool setState;
  final String errorText;
  final Color borderColor, bgColor;
  final String label;
  final bool isMandatory;
  final int? dropDownValue;
  final String hint;
  final bool isMultiple;
  final bool canTag;
  final double labelSize;
  final double padding;
  final Function? onTap;
  final bool loading;

  @override
  State<DropdownSearchB> createState() => _DropdownSearchBState();
}

class _DropdownSearchBState extends State<DropdownSearchB> {
  int? dropDownValue;
  GlobalKey key = GlobalKey();
  List<DropdownItem> selectedItem = [];

  OverlayEntry? popupDialog;

  void _showPopupDialog() {
    if (popupDialog == null) {
      popupDialog = showDropdown(context, key,
          items: widget.items,
          preSelected: selectedItem,
          isMultiple: widget.isMultiple,
          isTag: widget.canTag, save: (items) {
        setState(() {
          selectedItem = items;
          if (selectedItem.isNotEmpty) {
            if (widget.isMultiple) {
              List<String> result = [];
              for (int i = 0; i < selectedItem.length; i++) {
                result.add(selectedItem[i].name);
              }
              widget.selected(result);
            } else if (widget.canTag) {
              widget.selected(selectedItem[selectedItem.length - 1].name);
            } else {
              widget.selected(selectedItem[selectedItem.length - 1].value);
            }
          }
        });
      }, closeDropDown: (close) {
        if (close) {
          _dismissPopupDialog();
        }
      });
      Overlay.of(context).insert(popupDialog!);
    }
  }

  void _dismissPopupDialog() {
    if (popupDialog != null) {
      popupDialog!.remove();
      popupDialog = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.setState) {
        dropDownValue = null;
        selectedItem.clear();
      } else if (widget.dropDownValue != null &&
          !widget.dropDownValue!.isNegative) {
        dropDownValue = widget.dropDownValue!;
        selectedItem.clear();
        for (int i = 0; i < widget.items.length; i++) {
          if (widget.items[i].value == widget.dropDownValue) {
            selectedItem.add(widget.items[i]);
            break;
          }
        }
      }
      if (selectedItem.isNotEmpty) {
        bool has = false;
        final value = selectedItem[0].value;
        for (int i = 0; i < widget.items.length; i++) {
          if (widget.items[i].value == value) {
            has = true;
            break;
          }
        }
        if (!has && !widget.canTag) {
          dropDownValue = null;
          selectedItem.clear();
        }
      }
    });

    return WillPopScope(
        onWillPop: () async {
          bool shouldReturn = true;
          if (popupDialog != null) {
            _dismissPopupDialog();
            shouldReturn = false;
          }
          return shouldReturn;
        },
        child: SizedBox(
            width: widget.dropdownWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: key,
              children: [
                if (widget.label != '')
                  Row(
                    children: [
                      Flexible(
                          child: TextB(
                        text: widget.label,
                        textStyle: TextStyle(fontSize: widget.labelSize),
                        fontColor: bDark,
                      )),
                      const SizedBox(width: 5),
                      if (widget.isMandatory)
                        const TextB(
                          text: '*',
                          textStyle: bBody1,
                          fontColor: bDarkRed,
                        ),
                    ],
                  ),
                SizedBox(height: widget.padding),
                GestureDetector(
                    onTap: () {
                      if (!widget.loading) {
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                        _showPopupDialog();
                      }
                    },
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: bExtraLightGray),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedItem.isNotEmpty
                                  ? !widget.isMultiple &&
                                          selectedItem.isNotEmpty
                                      ? Expanded(
                                          child:
                                              TextB(text: selectedItem[0].name))
                                      : Expanded(child: selectedItemView())
                                  : TextB(text: widget.hint),
                              !widget.loading
                                  ? Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: bGray,
                                      ),
                                    )
                                  : Container(
                                      height: 16,
                                      width: 16,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: const CircularProgressIndicator(
                                          color: bGray, strokeWidth: 2))
                            ],
                          ),
                        ))),
                if (widget.errorText != "")
                  TextB(
                    text: widget.errorText,
                    fontSize: 12,
                    fontColor: bDarkRed,
                  )
              ],
            )));
  }

  Widget selectedItemView() {
    return Wrap(
      children: selectedItem
          .map((item) => GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.blue.withOpacity(.3),
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 2),
                    Flexible(child: TextB(text: item.name)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedItem.remove(item);
                          if (selectedItem.isEmpty) {
                            if (widget.isMultiple) {
                              widget.selected(<String>[]);
                            } else if (widget.canTag) {
                              widget.selected('');
                            } else {
                              widget.selected(-1);
                            }
                          } else {
                            if (widget.isMultiple) {
                              List<String> result = [];
                              for (int i = 0; i < selectedItem.length; i++) {
                                if (item.value != selectedItem[i].value) {
                                  result.add(selectedItem[i].name);
                                }
                              }
                              widget.selected(result);
                            } else if (widget.canTag) {
                              widget.selected(
                                  selectedItem[selectedItem.length - 1].name);
                            } else {
                              widget.selected(
                                  selectedItem[selectedItem.length - 1].value);
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: const Icon(Icons.close, size: 16),
                      ),
                    )
                  ],
                ),
              )))
          .toList(),
    );
  }
}

OverlayEntry showDropdown(
    BuildContext context, GlobalKey<State<StatefulWidget>> key,
    {List<DropdownItem> items = const [],
    required List<DropdownItem> preSelected,
    int? dropDownValue,
    required Function save,
    required isMultiple,
    required isTag,
    required Function closeDropDown}) {
  FocusScope.of(context).unfocus();
  List<DropdownItem> selectedItems = [];
  List.from(selectedItems..addAll(preSelected));
  bool keyboard = false;

  final ValueNotifier<double> notifier = ValueNotifier(0.0);
  final keyboardVisibilityController = KeyboardVisibilityController();
  final size = MediaQuery.of(context).size;
  Size position = const Size(0.0, 0.0);
  double parentHeight = 0.0;
  double parentWidth = 0.0;
  double previousValue = 0.0;

  if (key.currentContext != null) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);
    position = Size(offset.dx, offset.dy);
    parentHeight = box.size.height;
    parentWidth = box.size.width;
  }
  notifier.value = position.height + parentHeight;

  keyboardVisibilityController.onChange.listen((bool visible) {
    keyboard = visible;
    if (keyboard) {
      notifier.value = 0;
    } else if (previousValue > 0) {
      notifier.value = previousValue;
    }
  });

  return OverlayEntry(
      builder: (context) => SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              ModalBarrier(
                onDismiss: () {
                  closeDropDown(true);
                },
              ),
              ValueListenableBuilder<double>(
                  valueListenable: notifier,
                  builder: (BuildContext context, double value, Widget? child) {
                    return Positioned(
                        height: notifier.value == 0
                            ? size.height -
                                MediaQuery.of(context).viewInsets.bottom -
                                MediaQuery.of(context).padding.top -
                                20
                            : null,
                        left: !keyboard ? position.width : 20,
                        right: !keyboard
                            ? size.width - position.width - parentWidth
                            : 20,
                        top: notifier.value == 0
                            ? MediaQuery.of(context).padding.top + 10
                            : notifier.value,
                        child: Material(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownView(
                              items: items,
                              preSelected: selectedItems,
                              keyboard: keyboard,
                              isMultiple: isMultiple,
                              isTag: isTag,
                              closeDialog: closeDropDown,
                              height: (value) {
                                final bottom =
                                    MediaQuery.of(context).viewInsets.bottom;
                                if (value >
                                    size.height - notifier.value + bottom) {
                                  final top = size.height - value - 10;
                                  notifier.value = top > 0 ? top : 0;
                                }
                                if (notifier.value > 10) {
                                  previousValue = notifier.value;
                                }
                              },
                              addItem: (item) {
                                if (isMultiple) {
                                  selectedItems.add(item);
                                } else {
                                  selectedItems = [item];
                                }
                              },
                              removeItem: (item) {
                                selectedItems.remove(item);
                              },
                              save: () {
                                save(selectedItems);
                              },
                              width: parentWidth,
                            )));
                  })
            ],
          )));
}

class DropdownView extends StatefulWidget {
  const DropdownView(
      {super.key,
      required this.items,
      required this.height,
      required this.addItem,
      required this.preSelected,
      required this.removeItem,
      required this.save,
      required this.width,
      this.keyboard = false,
      this.isMultiple = false,
      this.isTag = false,
      required this.closeDialog});

  final List<DropdownItem> items;
  final List<DropdownItem> preSelected;
  final Function height;
  final Function(DropdownItem) addItem;
  final Function(DropdownItem) removeItem;
  final VoidCallback save;
  final double width;
  final bool keyboard;
  final bool isMultiple;
  final bool isTag;
  final Function closeDialog;

  @override
  State<StatefulWidget> createState() {
    return _DropDownB();
  }
}

class _DropDownB extends State<DropdownView> {
  List<DropdownItem> list = [];
  bool added = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        double modalHeight =
            (context.findRenderObject() as RenderBox).size.height;
        widget.height(modalHeight);
      },
    );

    if (!added) {
      list.addAll(widget.items);
      added = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: !widget.keyboard ? MainAxisSize.min : MainAxisSize.max,
      children: [
        SizedBox(width: widget.width),
        TextFieldB(
            focusNode: FocusNode(),
            onChanged: (text) {
              list.clear();
              for (int i = 0; i < widget.items.length; i++) {
                if ((widget.items[i].name
                    .toLowerCase()
                    .contains(text.trim().toLowerCase()))) {
                  list.add(widget.items[i]);
                }
              }
              setState(() {});
            },
            hintText: widget.isTag ? 'Search / Add' : 'Search',
            controller: controller,
            hintColor: Colors.black.withOpacity(.75)),
        if (!widget.keyboard)
          Flexible(child: listView())
        else
          Expanded(child: listView()),
        if (widget.isMultiple || (list.isEmpty && widget.isTag))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Spacer(),
                ButtonB(
                  text: list.isEmpty && widget.isTag ? "Add" : "Ok",
                  press: () {
                    if (list.isEmpty &&
                        controller.text.isNotEmpty &&
                        widget.isTag) {
                      widget.addItem(DropdownItem(
                          name: controller.text,
                          value: DateTime.now().millisecondsSinceEpoch));
                    }
                    widget.save();
                    widget.closeDialog(true);
                  },
                  heigh: 38,
                  fontSize: 16,
                  textColor: bWhite,
                  fontWeight: FontWeight.w400,
                  bgColor: bBlue,
                  horizontalPadding: 20,
                ),
              ],
            ),
          ),
        const SizedBox(height: 15)
      ],
    );
  }

  Widget listView() {
    return list.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 10),
              ...List.generate(list.length, (index) {
                bool isPreselected =
                    isContains(widget.preSelected, list[index]);
                final bool isNegative = list[index].value.isNegative;

                return GestureDetector(
                  onTap: () {
                    if (!widget.isMultiple && !isNegative) {
                      widget.addItem(list[index]);
                      widget.save();
                      widget.closeDialog(true);
                    } else {
                      setState(() {
                        if (!isPreselected) {
                          widget.addItem(list[index]);
                          isPreselected = true;
                        } else {
                          widget.removeItem(list[index]);
                          isPreselected = false;
                        }
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              alignment: isNegative
                                  ? Alignment.bottomLeft
                                  : Alignment.centerLeft,
                              height: 40,
                              child: TextB(
                                  text: list[index].name,
                                  fontSize: isNegative ? 14 : null,
                                  fontWeight: isNegative
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontColor: isPreselected
                                      ? bBlue
                                      : isNegative
                                          ? Colors.black
                                          : null)),
                        ),
                        if (widget.isMultiple)
                          Container(
                            padding: const EdgeInsets.only(right: 12),
                            child: isPreselected
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: bDarkGray,
                                  ),
                          )
                      ],
                    ),
                  ),
                );
              }),
            ],
          ))
        : Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
            child: const TextB(
              text: 'No Item Found',
            ));
  }

  bool isContains(List<DropdownItem> items, DropdownItem item) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].value == item.value) {
        return true;
      }
    }
    return false;
  }
}

class DropdownItem {
  const DropdownItem({required this.name, required this.value});
  final String name;
  final int value;
}
