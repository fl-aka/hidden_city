String toIndo(String bahan) {
  late String result;
  switch (bahan) {
    case "Monday":
      result = "Senin";
      break;
    case "Tuesday":
      result = "Selasa";
      break;
    case "Wednesday":
      result = "Rabu";
      break;
    case "Thursday":
      result = "Kamis";
      break;
    case "Friday":
      result = "Jum'at";
      break;
    case "Saturday":
      result = "Sabtu";
      break;
    case "Sunday":
      result = "Minggu";
      break;
    case "January":
      result = "Januari";
      break;
    case "February":
      result = "Februari";
      break;
    case "March":
      result = "Maret";
      break;
    case "April":
      result = bahan;
      break;
    case "May":
      result = "Mei";
      break;
    case "June":
      result = "Juni";
      break;
    case "July":
      result = "Juli";
      break;
    case "August":
      result = "Agustus";
      break;
    case "September":
      result = bahan;
      break;
    case "October":
      result = "Oktober";
      break;
    case "November":
      result = bahan;
      break;
    case "December":
      result = "Desember";
      break;
    default:
      result = "error";
  }
  return result;
}

String dayName(int x) {
  String returner = "";
  switch (x) {
    case 1:
      returner = "Monday";
      break;
    case 2:
      returner = "Tuesday";
      break;
    case 3:
      returner = "Wednesday";
      break;
    case 4:
      returner = "Thursday";
      break;
    case 5:
      returner = "Friday";
      break;
    case 6:
      returner = "Saturday";
      break;
    case 7:
      returner = "Sunday";
      break;
  }
  return returner;
}

monthName(int x) {
  String result = '';
  switch (x) {
    case 1:
      result = "January";
      break;
    case 2:
      result = "February";
      break;
    case 3:
      result = "March";
      break;
    case 4:
      result = "April";
      break;
    case 5:
      result = "May";
      break;
    case 6:
      result = "June";
      break;
    case 7:
      result = "July";
      break;
    case 8:
      result = "August";
      break;
    case 9:
      result = "September";
      break;
    case 10:
      result = "October";
      break;
    case 11:
      result = "November";
      break;
    case 12:
      result = "December";
      break;
  }
  return result;
}

String dayToIndo(DateTime date) {
  String result;
  result = toIndo(dayName(date.weekday));
  return result;
}

String monthToIndo(DateTime date) {
  String result;
  result = toIndo(monthName(date.month));
  return result;
}
