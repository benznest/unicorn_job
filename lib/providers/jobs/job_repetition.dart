enum JobRepetition { single, daily }

class JobRepetitionUtil {
  static JobRepetition? get(int id) {
    switch (id) {
      case 1:
        return JobRepetition.single;
      case 2:
        return JobRepetition.daily;
    }
    return null;
  }
}

extension JobRepetitionExtension on JobRepetition {
  String get title {
    switch (this) {
      case JobRepetition.single:
        return "Just one";
      case JobRepetition.daily:
        return "Daily";
    }
  }

  int get id {
    switch (this) {
      case JobRepetition.single:
        return 1;
      case JobRepetition.daily:
        return 2;
    }
  }
}
