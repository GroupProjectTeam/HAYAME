import 'database.dart' as db;
import 'interface.dart' as ui;
import 'function.dart';

void main() {
  print(db.task_DB); //実際にはUIで表示する
  change_task_title(ui.get_id_UI(), ui.get_title_UI()); //実際にはあるボタンを押す
  print(db.task_DB); //実際にはUIで表示する
}
