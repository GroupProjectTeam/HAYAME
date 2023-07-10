import 'database.dart' as db;

List TEMP_TASK_DB = db_task2TEMP();
List TEMP_APPOINTMENT_DB = db_appointment2TEMP();

/* need to convert */
List db_task2TEMP() {
  List result = [];
  // for (db.TaskModel item in db.task_DB){
  //   int id = item.id;
  //   String title = item.title;
  //   int deadline = item.deadline.millisecondsSinceEpoch;
  //   int duration = item.duration * 60000;
  //   int real_duration = item.realDuration * 60000;
  //   bool if_done = item.ifDone;
  //   result.add([id, title, deadline, duration, real_duration, if_done])
  // }
  result = List.from(db.task_DB);
  return result;
}

List db_appointment2TEMP() {
  List result = [];
  // for (db.AppointmentModel item in db.task_DB) {
  //   int id = item.id;
  //   String title = item.title;
  //   int begin_time = item.beginTime.millisecondsSinceEpoch;
  //   int end_time = item.endTime.millisecondsSinceEpoch;
  //   result.add([id, title, begin_time, end_time]);
  // }
  result = List.from(db.appointment_DB);
  return result;
}

List search_task(int task_id) {
  /*return task by input task_id */
  List current_task = [];
  for (List task in TEMP_TASK_DB) {
    if (task[0] == task_id) {
      current_task = task;
      break;
    }
  }
  if (current_task == []) {
    Error();
  }
  return current_task;
}

bool schedule_task(task_id) {
  // schedule one task
  /* find the current task */
  List current_task = search_task(task_id);
  int deadline = current_task[2];
  int duration = current_task[3];
  bool if_done = current_task[5];
  // print("in schedule_task");
  if (if_done) {
    // print("the task has been arranged");
    return false;
  } else {
    List free_time_list = calculate_free_time(deadline, duration);
    if (free_time_list.length > 0) {
      print("start arrange task" + task_id.toString());
      // print("in free time list:");
      // print(free_time_list);
      List recommended = recommend_free_time(free_time_list);
      arrange_task(current_task, recommended);
    } else {
      print("free_time not enough");
      return false;
    }
  }
  return true;
}

List calculate_free_time(int deadline, int duration) {
  // return a list of free time, given schedule_DB
  // print("in caculate_free_time");
  List result = [];
  for (List free_time in db.free_DB) {
    int free_time_duration = free_time[2] - free_time[1];
    int end_free_time = free_time[2];
    if ((duration <= free_time_duration) & (deadline >= end_free_time)) {
      result.add(free_time);
    }
  }
  return result;
}

List recommend_free_time(List free_time_list) {
  /* Now we only retrun the last free_time */
  free_time_list = insertion_sort_double_list(free_time_list, 1);
  return free_time_list.last;
}

void arrange_task(List task, List free_time) {
  int new_task_id = task[0];
  int new_sub_task_id = 001;
  int task_duration = task[3];
  int new_begin_time = free_time[1];
  int new_end_time = task_duration + new_begin_time;
  var new_title = task[1];
  List new_task_schedule = [
    new_task_id,
    new_sub_task_id,
    new_begin_time,
    new_end_time
  ];
  db.schedule_DB.add(new_task_schedule);
  List new_task_appointment = [
    db.appointment_and_schedule_DB.length,
    new_title,
    new_begin_time,
    new_end_time,
    0, // it is not an appointment
    new_task_id
  ];
  db.appointment_and_schedule_DB.add(new_task_appointment);
  remove_task_from_free_time(free_time, new_begin_time, new_end_time);
}

void remove_task_from_free_time(List free_time, int begin_time, int end_time) {
  /*free_time: the free time block need to remove;
    begin_time & end_time: the inserted task's begin time and end time */
  int free_time_id = search_index_by_id(free_time[0], db.free_DB);
  db.free_DB.removeAt(free_time_id);
  if (begin_time > free_time[1]) {
    int new_free_time_id = db.free_DB.last[0] + 1;
    db.free_DB.add([new_free_time_id, free_time[1], begin_time]);
  }
  if (free_time[2] > end_time) {
    int new_free_time_id = db.free_DB.last[0] + 1;
    db.free_DB.add([new_free_time_id, end_time, free_time[2]]);
  }
}

void AppSch_2_free_time() {
  /* update the db.free_DB by db.appointment_and_schedule_DB */
  List time_slice = <int>[db.SYS_START_TIME, db.SYS_END_TIME];
  for (List appointment in db.appointment_and_schedule_DB) {
    // int appointment_id = appointment[0];
    // var title = appointment[1];
    int begin_time = appointment[2];
    int end_time = appointment[3];
    time_slice.add(begin_time);
    time_slice.add(end_time);
  }
  time_slice.sort();
  db.free_DB.clear();
  for (int i = 0; i < time_slice.length; i++) {
    if (i.isEven) {
      if (time_slice[i + 1] - time_slice[i] > 0) {
        int new_free_id = i ~/ 2;
        db.free_DB.add([new_free_id, time_slice[i], time_slice[i + 1]]);
      }
    }
  }
}

int search_index_by_id(int id, List l) {
  /*return index by input id */
  List current = [];
  int i = -1;
  for (List item in l) {
    i++;
    if (item[0] == id) {
      break;
    }
  }
  if (current == []) {
    Error();
  }
  return i;
}

bool schedule_tasks() {
  /* schedule all tasks in TEMP_TASK_DB */
  List task_id_list = [];
  List temp_task_DB = insertion_sort_double_list(TEMP_TASK_DB, 3);
  // for (List task in temp_task_DB) {
  //   task_id_list.add(task[0]);
  // }
  for (int i = temp_task_DB.length - 1; i >= 0; i--) {
    task_id_list.add(temp_task_DB[i][0]);
  }
  for (int task_id in task_id_list) {
    bool result = schedule_task(task_id);
    if (!result) {
      print("can not arrange task, id: " + task_id.toString());
      db.schedule_DB.clear();
      return false;
    }
  }
  return true;
}

void initialize_appointment_and_schedule_DB() {
  db.appointment_and_schedule_DB.clear();
  for (List appointment in TEMP_APPOINTMENT_DB) {
    int display_id = db.appointment_and_schedule_DB.length;
    var title = appointment[1];
    int begin_time = appointment[2]; // need to convert to string
    int end_time = appointment[3];
    int original_id = appointment[0];
    int is_appointment = 1;
    List new_item = [
      display_id,
      title,
      begin_time,
      end_time,
      is_appointment,
      original_id
    ];
    db.appointment_and_schedule_DB.add(new_item);
  }
}

/**write this */
List insertion_sort_double_list(List l, int index) {
  /*l is a double list, index is the position of the element to be sorted*/
  List result = [];
  for (List li in l) {
    bool flag = false;
    for (int j = 0; j < result.length; j++) {
      if (li[index] < result[j][index]) {
        result.insert(j, li);
        flag = true;
        break;
      }
    }
    if (!flag) {
      result.add(li);
    }
  }
  return result;
}

String timestamp2date(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
  String result = date.year.toString() +
      "/" +
      date.month.toString() +
      "/" +
      date.day.toString();
  return result;
}

String timestamp2hour_minute(int time) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
  String result = date.hour.toString() + ":" + date.minute.toString();
  return result;
}

String timestamp2hour_difference(int time1, int time2) {
  DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time1);
  DateTime date2 = DateTime.fromMillisecondsSinceEpoch(time2);
  Duration d = date2.difference(date1);
  String result = (d.inMinutes / 60).toStringAsFixed(1) + " hours";
  return result;
}

List data_UI() {
  // db.appointment_and_schedule_DB -> output
  List output = [];
  List output_today = [];
  List output_tomorrow = [];
  List output_other = [];
  List temp_list =
      insertion_sort_double_list(db.appointment_and_schedule_DB, 2);
  for (List item in temp_list) {
    int id = item[0];
    String title = item[1];
    String day = timestamp2date(item[2]);
    String start_hour_minute = timestamp2hour_minute(item[2]);
    String end_hour_minute = timestamp2hour_minute(item[3]);
    String hour_difference = timestamp2hour_difference(item[2], item[3]);
    String today = timestamp2date(DateTime.now().millisecondsSinceEpoch);
    String tomorrow = timestamp2date(
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch);
    // if (day == today) {
    //   output_today.add([
    //     id,
    //     title,
    //     day,
    //     start_hour_minute,
    //     end_hour_minute,
    //     hour_difference
    //   ]);
    // } else {
    //   if (day == tomorrow) {
    //     output_tomorrow.add([
    //       id,
    //       title,
    //       day,
    //       start_hour_minute,
    //       end_hour_minute,
    //       hour_difference
    //     ]);
    //   } else {
    //     output_other.add([
    //       id,
    //       title,
    //       day,
    //       start_hour_minute,
    //       end_hour_minute,
    //       hour_difference
    //     ]);
    //   }
    // }
    output.add(
        [id, title, day, start_hour_minute, end_hour_minute, hour_difference]);
  }
  // output = [output_today, output_tomorrow, output_other];
  return output;
}

List schedule_arranger() {
  /* After insert one or more than one tasks, run this function */
  initialize_appointment_and_schedule_DB();
  AppSch_2_free_time();
  schedule_tasks();
  List output = data_UI();
  print(output);
  return output;
}

void main() {
  // initialize_appointment_and_schedule_DB();
  // print(db.appointment_and_schedule_DB);
  // AppSch_2_free_time();
  // print(db.free_DB);
  // schedule_tasks();
  // print(TEMP_APPOINTMENT_DB);
  // print(db.appointment_and_schedule_DB);
  // List output = data_UI();
  // print(output);

  // List l = [
  //   [1, 100],
  //   [3, 300],
  //   [2, 500]
  // ];
  // List l0 = insertion_sort_double_list(l, 0);
  // print(l0);

  schedule_arranger();
}
