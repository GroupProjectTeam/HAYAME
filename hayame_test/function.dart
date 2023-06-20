import 'database.dart' as db;
import 'interface.dart' as ui;

void change_task_title(int id, String title) {
  //write your code here
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i][0] == id) {
      db.task_DB[i][1] = title;
    }
  }
}
