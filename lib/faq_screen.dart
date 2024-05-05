import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Map<String , String>> faqlist = [
    {
      "question" : "1.Why is regular veterinary care important for my pet?",
      "answer" : "Regular veterinary care is essential for maintaining your pet's overall health and detecting any potential"
          "issues early on. Routine check-ups allow our veterinarians to monitor your pet's well-being, provide preventive care, and address any concerns you may have.",
    },
    {
      "question" : "2.How often should I bring my pet in for vaccinations?",
      "answer" : "The frequency of vaccinations depends on your pet's age, lifestyle, and individual health needs. Our veterinarians will create a customized vaccination schedule tailored to your pet's specific requirements to ensure they receive optimal protection against infectious diseases.",

    },
    {
      "question" : "3.What should I feed my pet for a balanced diet?",
      "answer" : "A balanced diet is crucial for your pet's health and vitality. Our veterinarians can provide personalized dietary recommendations based on your pet's age, breed, size, and any medical conditions they may have. We'll help you choose the right food to meet your pet's nutritional needs.",
    },
    {
      "question" : "4. How can I prevent parasites like fleas and ticks on my pet?",
      "answer" : "Preventing parasites is an important aspect of pet care. Our veterinarians can recommend safe and effective parasite prevention products tailored to your pet's lifestyle and risk factors. Regular use of preventive medications can help protect your pet from fleas, ticks, heartworms, and other parasites.",
    },
    {
      "question" : "5.What are the signs of dental problems in pets?",
      "answer" : "Dental health is crucial for your pet's overall well-being. Signs of dental problems may include bad breath, swollen gums, tartar buildup, and difficulty eating. Our veterinarians can perform a thorough dental exam and recommend appropriate treatment options to keep your pet's teeth and gums healthy.",
    },
    {
      "question" : "6.How can I help my pet maintain a healthy weight?",
      "answer" : "Maintaining a healthy weight is essential for your pet's long-term health. Our veterinarians can offer guidance on portion control, feeding schedules, and exercise routines to help your pet achieve and maintain a healthy weight. We'll work with you to create a personalized weight management plan for your furry friend.",
    },
    {
      "question" : "7.What should I do if my pet is vomiting or experiencing diarrhea?",
      "answer" : "Vomiting and diarrhea can be symptoms of various underlying health issues, including infections, dietary indiscretion, and gastrointestinal disorders. If your pet is experiencing these symptoms, it's essential to contact our clinic for guidance. Our veterinarians can assess your pet's condition and recommend appropriate treatment options.",
    },
    {
      "question" : "8.How can I keep my pet's skin and coat healthy?",
      "answer" : "Regular grooming and proper nutrition are essential for maintaining your pet's skin and coat health. Our veterinarians can recommend grooming techniques and products suited to your pet's coat type and skin condition. We'll also provide dietary advice to promote healthy skin and a shiny coat.",
    },
    {
      "question" : "9.When should I have my pet spayed or neutered?",
      "answer" : "Spaying or neutering your pet can have numerous health benefits, including reducing the risk of certain reproductive cancers and behavioral issues. Our veterinarians can discuss the optimal timing for spaying or neutering based on your pet's age, breed, and individual circumstances.",
    },
    {
      "question" : "10.How can I keep my senior pet comfortable and healthy?",
      "answer" : "As pets age, they may require special care to maintain their health and comfort. Our veterinarians can guide senior pet care, including nutritional support, pain management, and preventive screenings. We'll work with you to ensure your senior pet enjoys a happy and comfortable life in their golden years.",
    },
  ];

  List<bool> expansionStateList = [];

  @override
  void initState() {
    expansionStateList = List<bool>.generate(faqlist.length, (index) => false);
    super.initState();
  }
  void toogleExpansion(int index) {
    setState(() {
      expansionStateList[index] = ! expansionStateList[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "FAQ Medical" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: faqlist.length,
          itemBuilder: (context, index) {
            return ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex , isExpanded){
                toogleExpansion(index);
              },
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          faqlist[index]['question']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),

                        ),
                      );
                    },
                    body: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                      child: Text(faqlist[index]['answer']!),
                    ) ,
                  isExpanded: expansionStateList[index],
                ),

              ],
            );
          },
      ),
    );
  }
}
