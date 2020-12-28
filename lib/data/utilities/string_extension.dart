extension StringExtension on String {
  String toTitleCase() {
    if(this ==null || this.length<1)
      return "";
    String  val = this.toLowerCase();
    return "${val[0].toUpperCase()}${val.substring(1)}";
  }
}