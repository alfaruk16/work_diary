import 'package:work_diary/core/widgets/dropdown_search.dart';

const List<String> items = ['Select'];
const dateItemList = [
  DropdownItem(name: 'Next 30 Days', value: -1),
  DropdownItem(name: 'Today', value: 0),
  DropdownItem(name: 'Yesterday', value: 1),
  DropdownItem(name: "Last 7 days", value: 2),
  DropdownItem(name: "This Month", value: 3),
  DropdownItem(name: 'Last 30 days', value: 4),
  DropdownItem(name: 'Last 60 days', value: 5),
  //const DropdownItem(name: 'Custom Date', value: 5),
];
