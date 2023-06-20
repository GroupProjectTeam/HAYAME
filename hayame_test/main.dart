import 'database.dart' as db;
import 'interface.dart' as ui;
import 'function.dart';

void main() {
  print(db.task_DB);
  change_task_title(ui.get_id_UI(), ui.get_title_UI());
  print(db.task_DB);
}
