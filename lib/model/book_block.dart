class BookBlock{
   String cover;
   String title;
   String description;

   BookBlock.fromJson(Map data) {
     cover = data['cover'];
     title = data['title'];
     description = data['description'];
   }
}
