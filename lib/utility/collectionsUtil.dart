class CollectionsUtils {
  static bool isEmpty(List list) {
    if (list == null || list.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  static int length(List list) {
    return isEmpty(list) ? 0 : list.length;
  }
}
