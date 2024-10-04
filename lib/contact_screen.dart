import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/2k_stars.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'assets/nasa_blue_logo.json',
              repeat: true,
              reverse: true,
              animate: true,
              backgroundLoading: true,
              // backgroundLoading: true,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Contact Us title
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Get in touch with the team behind Quik Vision.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Introduction
                  const Text(
                    '''We are a group of passionate computer engineering students from Fayoum University who are fascinated by space exploration
We developed Quik Vision to participate in NASA's International Space Apps Challenge.
Our goal is to contribute our skills and knowledge while inspiring others' passion for the cosmos.''',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Team members in a grid with padding
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 350,
                    ), // Add vertical padding
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 150,
                        mainAxisSpacing: 10,

                        // childAspectRatio: 0.8,
                        // mainAxisExtent: 100,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return TeamMember(
                          teamMemberModel: teamMembers[index],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamMember extends StatelessWidget {
  final TeamMemberModel teamMemberModel;

  const TeamMember({
    Key? key,
    required this.teamMemberModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.8),
        borderOnForeground: true,
        semanticContainer: true,
        surfaceTintColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12.withOpacity(0.8),
            gradient: const LinearGradient(
              colors: [
                Colors.black12,
                Colors.black87,
                Colors.blueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  teamMemberModel.imageUrl,
                ),
              ),
              const SizedBox(height: 16),
              // Name
              Text(
                teamMemberModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ), // Small space between name and job title
              // Job Title
              Text(
                teamMemberModel.jobTitle, // Display the job title
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey, // Grey color for job title
                ),
              ),
              const SizedBox(height: 8),
              // Social icons
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.envelope,
                        size: 20,
                        color: Colors.white,
                      ), // Set color to white
                      onPressed: () async {
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: teamMemberModel.gmail,
                        );
                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                        } else {
                          throw 'Could not launch $teamMemberModel.gmail';
                        }
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 20,
                        color: Colors.white,
                      ), // Set color to white
                      onPressed: () async {
                        if (await canLaunchUrl(
                            Uri.parse(teamMemberModel.linkedInUrl))) {
                          await launchUrl(
                              Uri.parse(teamMemberModel.linkedInUrl));
                        } else {
                          throw 'Could not launch $teamMemberModel.linkedInUrl';
                        }
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.github,
                          size: 20, color: Colors.white), // Set color to white
                      onPressed: () async {
                        if (await canLaunchUrl(
                            Uri.parse(teamMemberModel.githubUrl))) {
                          await launchUrl(Uri.parse(teamMemberModel.githubUrl));
                        } else {
                          throw 'Could not launch $teamMemberModel.githubUrl';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMemberModel {
  final String imageUrl;
  final String name;
  final String jobTitle;
  final String linkedInUrl;
  final String githubUrl;
  final String gmail;

  TeamMemberModel({
    required this.imageUrl,
    required this.name,
    required this.jobTitle,
    required this.linkedInUrl,
    required this.githubUrl,
    required this.gmail,
  });
}
List<TeamMemberModel> teamMembers = [
  TeamMemberModel(
    imageUrl: 'assets/aya_nady.jpg',
    name: 'Aya Nady',
    jobTitle: 'Software Engineer',
    linkedInUrl: 'https://www.linkedin.com/in/aya-nady-8b7546199/',
    githubUrl: 'https://github.com/AyaNady17',
    gmail: 'ayanady22193@gmail.com',
  ),
  TeamMemberModel(
    imageUrl: 'assets/kareem_abdeen.jpeg',
    name: 'Kareem Abdeen',
    jobTitle: 'Software Engineer',
    linkedInUrl: 'https://www.linkedin.com/in/kareemabdeen/',
    githubUrl: 'https://github.com/kareemabdeen',
    gmail: 'kareemabdeen222@gmail.com',
  ),
  TeamMemberModel(
    imageUrl: 'assets/zead_omar.jpg',
    name: 'Zead Omar',
    jobTitle: 'AI Engineer',
    linkedInUrl: 'https://www.linkedin.com/in/zeadoy/',
    githubUrl: 'https://github.com/Ziad-o-Yusef',
    gmail: 'zeadomar240@gmail.com',
  ),
  TeamMemberModel(
    imageUrl: 'assets/sondos_amr.jpg',
    name: 'Sondos Amr',
    jobTitle: 'AI Engineer',
    linkedInUrl: 'https://www.linkedin.com/in/sondos-amr/',
    githubUrl: 'https://github.com/sondosamr',
    gmail: 'sa3178@fayoum.edu.eg',
  ),
];
