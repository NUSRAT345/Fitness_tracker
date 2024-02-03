import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:async';

class Exercise {
  final String name;
  final String description;
  final String benefits;
  final String imageUrl;

  Exercise({
    required this.name,
    required this.description,
    required this.benefits,
    required this.imageUrl,
  });
}

class ExerciseListScreen extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      name: "Push-ups",
      description: "Performing push-ups is an effective bodyweight exercise that primarily targets the muscles of the chest, shoulders, and triceps. It also engages the core muscles for stability. Start in a plank position with hands placed shoulder-width apart, lower your body towards the ground by bending your elbows, and then push back up to the starting position.",
      benefits: "Strengthen your chest and arms.",
      imageUrl: "assets/img/push-up.png",
    ),
    Exercise(
      name: "Squats",
      description:"Squats are a fundamental lower body exercise that targets the muscles of the thighs, hips, and buttocks. To perform a squat, stand with feet shoulder-width apart, lower your body by bending your knees and hips, and then return to the standing position. Proper form is crucial to maximize the benefits and prevent injury.",
      benefits: "Build strong leg muscles.",
      imageUrl: "assets/img/squats.jpeg",
    ),
    Exercise(
      name: "Plank",
      description:" Holding a push-up position with arms straight, maintaining a straight line from head to heels..",
      benefits:"Strengthens core muscles, improves stability.",
      imageUrl: "assets/img/plank.png",
    ),
    Exercise(
      name: "Jumping Jacks",
      description:" A full-body cardio exercise involving jumping and arm movement.",
      benefits: "Improves cardiovascular fitness and overall body coordination.",
      imageUrl: "assets/img/jumping jack.jpeg",
    ),
    Exercise(
      name: "Burpees",
      description:"A high-intensity exercise involving a combination of a squat, plank, push-up, and jump.",
      benefits: "Targets multiple muscle groups, enhances cardiovascular endurance.",
      imageUrl: "assets/img/burpees.png",
    ),
    Exercise(
      name: "Mountain Climbers",
      description: " A dynamic exercise that mimics the motion of climbing a mountain while in a plank position.",
      benefits:"Engages core muscles, improves cardiovascular endurance.",
      imageUrl: "assets/img/mountain climber.jpeg",
    ),
    Exercise(
      name: "Lunges",
      description: "Forward or reverse stepping motion with one leg while keeping the other stationary.",
      benefits: " Strengthens leg muscles, improves balance.",
      imageUrl: "assets/img/lunges.jpeg",
    ),
    Exercise(
      name: "Russian Twists",
      description: "Seated on the floor, rotate your torso to touch the floor on each side.",
      benefits: "Targets obliques, improves core strength.",
      imageUrl: "assets/img/russian twist.jpeg",
    ),
    Exercise(
      name:"Leg Raises",
      description:"Lying on your back, lift both legs toward the ceiling without bending the knees.",
      benefits:"Targets lower abdominal muscles.",
      imageUrl: "assets/img/leg raises.png",
    ),
    Exercise(
      name: "Tricep Dips",
      description: "Using a sturdy surface, lower and lift your body by bending and straightening your arms.",
      benefits: "Strengthens triceps, improves arm strength.",
      imageUrl: "assets/img/triceps dips.png",
    ),
    Exercise(
      name: "Side Plank",
      description: "Similar to a regular plank but on one side, supporting your body with one arm.",
      benefits: "Targets obliques and improves lateral stability",
      imageUrl: "assets/img/side plank.jpeg",
    ),
    Exercise(
      name: "Wall Sit",
      description: "Sit against a wall with knees bent at a 90-degree angle, holding the position.",
      benefits: "Strengthens quadriceps and glutes.",
      imageUrl: "assets/img/wall sit.jpeg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise List'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          Exercise exercise = exercises[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(exercise.name),
              //subtitle: Text(exercise.description),
              leading: Image.asset(
                exercise.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDescriptionScreen(exercise: exercise),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseDescriptionScreen extends StatelessWidget {
  final Exercise exercise;

  ExerciseDescriptionScreen({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            exercise.imageUrl,
            height: 280,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            exercise.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
 SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Description: ',
                  style: TextStyle(fontWeight: FontWeight.bold,color:const Color.fromARGB(255, 156, 7, 7), fontSize: 17),
                ),

                TextSpan(
                  text: exercise.description,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Benefits: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color:const Color.fromARGB(255, 156, 7, 7), fontSize: 17),
                ),
                TextSpan(
                  text: exercise.benefits,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailScreen(exercise: exercise),
                ),
              );
            },
            child: Text('Start Exercise'),
          ),
        ],
      ),
    );
  }
}



class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  ExerciseDetailScreen({required this.exercise});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _secondsRemaining = 30;
  bool _timerRunning = false;
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularCountDownTimer(
            duration: _secondsRemaining,
            controller: _controller,
            width: 150,
            height: 150,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.blue,
            fillGradient: null,
            backgroundColor: Colors.transparent,
            backgroundGradient: null,
            strokeWidth: 10.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onComplete: () {
              setState(() {
                _timerRunning = false;
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timerRunning = true;
                  });
                  _controller.start();
                },
                child: Text('Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.resume();
                },
                child: Text('Resume'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.pause();
                },
                child: Text('Pause'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






void main() {
  runApp(MaterialApp(
    home: ExerciseListScreen(),
  ));
}
