extension ListExtensions<T> on List<T> {
  List<List<T>> group(int length) {
    final groupedList = <List<T>>[];
    while (groupedList.length * length < this.length) {
      groupedList.add(this.skip(groupedList.length * length).take(length).toList());
    }
    return groupedList;
  }
}
