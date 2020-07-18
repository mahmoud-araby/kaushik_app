import 'package:kaushik_app/new_code/models/multiple_option_question.dart';
import 'package:kaushik_app/new_code/models/question.dart';
import 'package:kaushik_app/new_code/models/slider_question.dart';
import 'package:kaushik_app/new_code/models/time_question.dart';
import 'package:kaushik_app/new_code/models/time_question_pair.dart';
import 'package:kaushik_app/new_code/models/yes_or_no_question.dart';

Question TestWorkQuestion = SliderQuestion(
  question: 'How much did you work yesterday?',
  value: 0.0,
  unit: 'Hours',
  max: 8.0,
  min: 0.0,
  divisions: 80,
);
Question TestNapQuestion = YesOrNoQuestion(
  question: 'Did you Take a nap Yesterday',
);
Question TestNapStartQuestion = TimeQuestion(
  question: 'when did your nap start?',
);
Question TestNapEndQuestion = TimeQuestion(
  question: 'when did your wake up from your nap?',
);
Question TestNapQuestionPair = TimeQuestionPair(
  startQuestion: TestNapQuestion,
  napStartQuestion: TestNapStartQuestion,
  napEndQuestion: TestNapEndQuestion,
  errorMessage: 'Wake-up time must be later than the start of your nap.',
  secondQuestionDefaultRestriction: true,
);
Question TestMealQuestion = MultipleOptionQuestion(
  question: 'Which meal(s) did you eat yesterday?'
      'Select all that apply.',
  optionOneString: 'Breakfast',
  optionTwoString: 'Launch',
  optionThreeString: 'Dinner',
);
Question TestExerciseQuestion = YesOrNoQuestion(
  question: 'Did you exercise Yesterday',
);
