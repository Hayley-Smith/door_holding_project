// about_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Door-Holding Behavior on a Community College Campus'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introduction',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This project examines the door-holding behavior on our community college campus. It focuses on whether the act of holding the door for another is influenced by age, gender, or proximity of the person behind the door holder. These factors will serve as the independent variables, while the dependent variable is the door-holding action itself.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Dependent Variable',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The dependent variable in this study is the types of door-holding behavior observed. The categories for this behavior are:\n\n'
                    '- Full Hold: The person holds the door until the person behind them reaches it.\n'
                    '- Partial Hold: The person pushes the door slightly or holds it briefly before letting it close.\n'
                    '- No Hold: The person makes no attempt to hold the door.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Independent Variables',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Age: The observed person was categorized as either a teen, adult, or elder based on appearance.\n'
                    'Gender: The observed person was categorized as male, female, or other.\n'
                    'Distance: The distance between the door-holder and the person behind them was categorized as less than 5 feet, 5-10 feet, and more than 10 feet.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Data Collection',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The data was collected over 6 sessions on 4 different days at various entrances around campus. I observed 35 instances of door-holding behavior and recorded the data via a custom-designed user interface run on a smartphone and stored in a cloud database. The dataset attempts to capture a good mixture of age, gender, and distance to observe if these variables influenced the likelihood of door-holding.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Analysis',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The data shows several patterns in door-holding behavior; the most common being the Full Hold, which was observed 18 times. The second most common behavior was the Partial Hold, coming in at 9 observed cases. There were 8 instances of No Hold.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Distance Analysis',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Full holds were the most common when the person behind was within 5ft of the door-holder, occurring in 10 out of 12 cases. When the distance increased to 5-10 feet, the behavior became more mixed, with 5 full holds, 4 partial holds, and 3 no holds. At distances of more than 10 feet, most people opted for the no-hold behavior. This suggests that distance reduces the likelihood of holding the door.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Age Analysis',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Adults most often participated in the full-hold behavior and were the most likely to hold the door at all. Teens exhibited more varied behavior, with 4 instances of no hold, 3 instances of full hold, and 3 of partial hold. This suggests that younger individuals might follow the door-holding norm less consistently. Elders primarily participated in full holds when the person was close, but their responses varied more as distance increased.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Gender Analysis',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The genders displayed no significant behavioral differences. This suggests that the door-holding norm is shared across genders in this community.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Discussion',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The data supports the hypothesis that distance is a significant predictor of door-holding behavior. People are much more likely to hold the door if the following person is within 5 feet. As the distance increases, the consistency of the response decreases. In addition, age plays a role, with adults adhering more consistently to the norm. Teens and elders exhibited more varied behavior.\n\n'
                    'The presence of partial holds suggests that some individuals are aware of the norm but do not always feel the need to participate, especially as distance increases. The absence of significant gender differences indicates that the norm is universally shared among males and females on campus.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Conclusion',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Door-holding behavior at this community college campus is primarily influenced by the distance between the door-holder and the person following. Adults are more consistent in holding doors, while teens and elders exhibit more variability. Gender does not appear to play a significant role. These findings suggest that while door-holding is a widely accepted norm, it is flexible and influenced by situational factors like distance and age.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
