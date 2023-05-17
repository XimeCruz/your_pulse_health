import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/exercise_data.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';
import 'package:your_pulse_health/screens/onboarding/widget/onboarding_tile.dart';

class DataConstants {
  // Onboarding
  static final onboardingTiles = [
    OnboardingTile(
      title: TextConstants.onboarding1Title,
      mainText: TextConstants.onboarding1Description,
      imagePath: PathConstants.onboarding1,
    ),
    OnboardingTile(
      title: TextConstants.onboarding2Title,
      mainText: TextConstants.onboarding2Description,
      imagePath: PathConstants.onboarding2,
    ),
    OnboardingTile(
      title: TextConstants.onboarding3Title,
      mainText: TextConstants.onboarding3Description,
      imagePath: PathConstants.onboarding3,
    ),
    OnboardingTile(
      title: TextConstants.onboarding4Title,
      mainText: TextConstants.onboarding4Description,
      imagePath: PathConstants.onboarding4,
    ),
    OnboardingTile(
      title: TextConstants.onboarding5Title,
      mainText: TextConstants.onboarding5Description,
      imagePath: PathConstants.onboarding5,
    ),
  ];

  //Workouts
  static final List<WorkoutData> workouts = [
   WorkoutData(
        id : 'workout1',
        title: TextConstants.reportsTitle,
        exercises: TextConstants.reportsExercises,
        minutes: TextConstants.reportsMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.reports1,
        exerciseDataList: [ ]),
    WorkoutData(
        id : 'workout2',
        title: TextConstants.recordsTitle,
        exercises: TextConstants.recordsExercises,
        minutes: TextConstants.recordsMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.records1,
        exerciseDataList: []),
    WorkoutData(
        id : 'workout3',
        title: TextConstants.tipsTitle,
        exercises: TextConstants.tipsExercises,
        minutes: TextConstants.tipsMinutes,
        currentProgress: 12,
        progress: 14,
        image: PathConstants.tips1,
        exerciseDataList: []),
  ];

  static final List<TipData> tips = [
    TipData(
        id : 'tip1',
        title: TextConstants.tipsTitle1,
        description: TextConstants.tipsDescription1,
        exercises: TextConstants.reportsExercises,
        textTip: TextConstants.tipsText1,
        minutes: TextConstants.reportsMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.imageTip1,
        exerciseDataList: [ ]),
    TipData(
        id : 'tip2',
        title: TextConstants.tipsTitle2,
        description: TextConstants.tipsDescription2,
        textTip: TextConstants.tipsText2,
        exercises: TextConstants.recordsExercises,
        minutes: TextConstants.recordsMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.imageTip2,
        exerciseDataList: []),
    TipData(
        id : 'tip3',
        title: TextConstants.tipsTitle3,
        description: TextConstants.tipsDescription3,
        textTip: TextConstants.tipsText3,
        exercises: TextConstants.tipsExercises,
        minutes: TextConstants.tipsMinutes,
        currentProgress: 12,
        progress: 14,
        image: PathConstants.imageTip3,
        exerciseDataList: []),
    TipData(
        id : 'tip4',
        title: TextConstants.tipsTitle4,
        description: TextConstants.tipsDescription4,
        exercises: TextConstants.reportsExercises,
        textTip: TextConstants.tipsText4,
        minutes: TextConstants.reportsMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.imageTip4,
        exerciseDataList: [ ]),
    TipData(
        id : 'tip5',
        title: TextConstants.tipsTitle5,
        description: TextConstants.tipsDescription5,
        textTip: TextConstants.tipsText5,
        exercises: TextConstants.recordsExercises,
        minutes: TextConstants.recordsMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.imageTip5,
        exerciseDataList: []),
    TipData(
        id : 'tip6',
        title: TextConstants.tipsTitle6,
        description: TextConstants.tipsDescription6,
        textTip: TextConstants.tipsText6,
        exercises: TextConstants.tipsExercises,
        minutes: TextConstants.tipsMinutes,
        currentProgress: 12,
        progress: 14,
        image: PathConstants.imageTip6,
        exerciseDataList: []),
    TipData(
        id : 'tip7',
        title: TextConstants.tipsTitle7,
        description: TextConstants.tipsDescription7,
        textTip: TextConstants.tipsText7,
        exercises: TextConstants.reportsExercises,
        minutes: TextConstants.reportsMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.imageTip7,
        exerciseDataList: [ ]),
    TipData(
        id : 'tip8',
        title: TextConstants.tipsTitle8,
        description: TextConstants.tipsDescription8,
        textTip: TextConstants.tipsText8,
        exercises: TextConstants.recordsExercises,
        minutes: TextConstants.recordsMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.imageTip8,
        exerciseDataList: []),
  ];

  static final List<PressureData> bpms = [
    // PressureData(
    //     id: 'id1',
    //     date: 'May 11, 12:10',
    //     bpm: 65,
    //     status: 'Normal'),
    // PressureData(
    //     id: 'id1',
    //     date: 'May 11, 12:10',
    //     bpm: 65,
    //     status: 'Normal'),
    // PressureData(
    //     id: 'id1',
    //     date: 'May 11, 12:10',
    //     bpm: 65,
    //     status: 'Normal'),
    // PressureData(
    //     id: 'id1',
    //     date: 'May 11, 12:10',
    //     bpm: 65,
    //     status: 'Normal'),
    // PressureData(
    //     id: 'id1',
    //     date: 'May 11, 12:10',
    //     bpm: 65,
    //     status: 'Normal'),
  ];

  // static final List<WorkoutData> workouts = [
  //   WorkoutData(
  //       id : 'workout1',
  //       title: TextConstants.yogaTitle,
  //       exercises: TextConstants.yogaExercises,
  //       minutes: TextConstants.yogaMinutes,
  //       currentProgress: 10,
  //       progress: 16,
  //       image: PathConstants.yoga,
  //       exerciseDataList: [
  //         ExerciseData(
  //           title: TextConstants.reclining,
  //           minutes: TextConstants.recliningMinutes,
  //           progress: 1,
  //           video: PathConstants.recliningVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //           ],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.cowPose,
  //           minutes: TextConstants.cowPoseMinutes,
  //           progress: 0.3,
  //           video: PathConstants.cowPoseVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.warriorPose,
  //           minutes: TextConstants.warriorPoseMinutes,
  //           progress: 0.99,
  //           video: PathConstants.warriorIIVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //       ]),
  //   WorkoutData(
  //       id : 'workout2',
  //       title: TextConstants.pilatesTitle,
  //       exercises: TextConstants.pilatesExercises,
  //       minutes: TextConstants.pilatesMinutes,
  //       currentProgress: 1,
  //       progress: 20,
  //       image: PathConstants.pilates,
  //       exerciseDataList: [
  //         ExerciseData(
  //           title: TextConstants.reclining,
  //           minutes: TextConstants.recliningMinutes,
  //           progress: 0.1,
  //           video: PathConstants.recliningVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.cowPose,
  //           minutes: TextConstants.cowPoseMinutes,
  //           progress: 0.1,
  //           video: PathConstants.cowPoseVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.warriorPose,
  //           minutes: TextConstants.warriorPoseMinutes,
  //           progress: 0.0,
  //           video: PathConstants.warriorIIVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //       ]),
  //   WorkoutData(
  //       id : '',
  //       title: TextConstants.fullBodyTitle,
  //       exercises: TextConstants.fullBodyExercises,
  //       minutes: TextConstants.fullBodyMinutes,
  //       currentProgress: 12,
  //       progress: 14,
  //       image: PathConstants.fullBody,
  //       exerciseDataList: [
  //         ExerciseData(
  //           title: TextConstants.reclining,
  //           minutes: TextConstants.recliningMinutes,
  //           progress: 0.99,
  //           video: PathConstants.recliningVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.cowPose,
  //           minutes: TextConstants.cowPoseMinutes,
  //           progress: 0.6,
  //           video: PathConstants.cowPoseVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.warriorPose,
  //           minutes: TextConstants.warriorPoseMinutes,
  //           progress: 0.8,
  //           video: PathConstants.warriorIIVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //       ]),
  //   WorkoutData(
  //     id : '',
  //     title: TextConstants.stretchingTitle,
  //     exercises: TextConstants.stretchingExercises,
  //     minutes: TextConstants.stretchingMinutes,
  //     currentProgress: 0,
  //     progress: 8,
  //     image: PathConstants.stretching,
  //     exerciseDataList: [
  //       ExerciseData(
  //         title: TextConstants.reclining,
  //         minutes: TextConstants.recliningMinutes,
  //         progress: 0.0,
  //         video: PathConstants.recliningVideo,
  //         description: TextConstants.warriorDescription,
  //         steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //       ),
  //       ExerciseData(
  //         title: TextConstants.cowPose,
  //         minutes: TextConstants.cowPoseMinutes,
  //         progress: 0.0,
  //         video: PathConstants.cowPoseVideo,
  //         description: TextConstants.warriorDescription,
  //         steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //       ),
  //       ExerciseData(
  //         title: TextConstants.warriorPose,
  //         minutes: TextConstants.warriorPoseMinutes,
  //         progress: 0.0,
  //         video: PathConstants.warriorIIVideo,
  //         description: TextConstants.warriorDescription,
  //         steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //       ),
  //     ],
  //   ),
  // ];

  // static final List<WorkoutData> homeWorkouts = [
  //   WorkoutData(
  //       title: TextConstants.cardioTitle,
  //       exercices: TextConstants.cardioExercises,
  //       minutes: TextConstants.cardioMinutes,
  //       currentProgress: 10,
  //       progress: 16,
  //       image: PathConstants.cardio,
  //       exerciseDataList: [
  //         ExerciseData(
  //           title: TextConstants.reclining,
  //           minutes: TextConstants.recliningMinutes,
  //           progress: 1,
  //           video: PathConstants.recliningVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //             TextConstants.warriorStep1,
  //             TextConstants.warriorStep2,
  //           ],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.cowPose,
  //           minutes: TextConstants.cowPoseMinutes,
  //           progress: 0.3,
  //           video: PathConstants.cowPoseVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.warriorPose,
  //           minutes: TextConstants.warriorPoseMinutes,
  //           progress: 0.99,
  //           video: PathConstants.warriorIIVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //       ]),
  //   WorkoutData(
  //       title: TextConstants.armsTitle,
  //       exercices: TextConstants.armsExercises,
  //       minutes: TextConstants.armsMinutes,
  //       currentProgress: 1,
  //       progress: 20,
  //       image: PathConstants.cardio,
  //       exerciseDataList: [
  //         ExerciseData(
  //           title: TextConstants.reclining,
  //           minutes: TextConstants.recliningMinutes,
  //           progress: 0.1,
  //           video: PathConstants.recliningVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.cowPose,
  //           minutes: TextConstants.cowPoseMinutes,
  //           progress: 0.1,
  //           video: PathConstants.cowPoseVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //         ExerciseData(
  //           title: TextConstants.warriorPose,
  //           minutes: TextConstants.warriorPoseMinutes,
  //           progress: 0.0,
  //           video: PathConstants.warriorIIVideo,
  //           description: TextConstants.warriorDescription,
  //           steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
  //         ),
  //       ]),
  // ];

  // Reminder
  static List<String> reminderDays = [
    TextConstants.everyday,
    TextConstants.monday_friday,
    TextConstants.weekends,
    TextConstants.monday,
    TextConstants.tuesday,
    TextConstants.wednesday,
    TextConstants.thursday,
    TextConstants.friday,
    TextConstants.saturday,
    TextConstants.sunday,
  ];



  //Type pressure
  static final List<TypePressureData> typepressure = [
    TypePressureData(name: 'Celular', text: 'Medir por la cámara del celular'),
    TypePressureData(name: 'Oximeter and Device', text:'Medir por el oximetro o el dispositivo ECG')
  ];

}
