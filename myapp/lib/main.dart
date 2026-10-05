import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'page_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Biodata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BiodataForm(),
    );
  }
}

class BiodataForm extends StatefulWidget {
  const BiodataForm({super.key});

  @override
  State<BiodataForm> createState() => _BiodataFormState();
}

class _BiodataFormState extends State<BiodataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  final fullName = TextEditingController();
  final dob = TextEditingController();
  final pob = TextEditingController();
  final age = TextEditingController();
  final sex = TextEditingController();
  final civilStatus = TextEditingController();
  final citizenship = TextEditingController();
  final religion = TextEditingController();
  final address = TextEditingController();
  final contact = TextEditingController();
  final email = TextEditingController();

  final fatherName = TextEditingController();
  final fatherOcc = TextEditingController();
  final motherName = TextEditingController();
  final motherOcc = TextEditingController();
  final spouseName = TextEditingController();
  final children = TextEditingController();

  final elementary = TextEditingController();
  final elemYear = TextEditingController();
  final highSchool = TextEditingController();
  final hsYear = TextEditingController();
  final college = TextEditingController();
  final course = TextEditingController();
  final section = TextEditingController();
  final collYear = TextEditingController();
  final honors = TextEditingController();

  final skills = TextEditingController();

  final ref1Name = TextEditingController();
  final ref1Pos = TextEditingController();
  final ref1Contact = TextEditingController();

  Future<void> _saveBiodata() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance.collection('biodata').add({
        'full_name': fullName.text.trim(),
        'date_of_birth': dob.text.trim(),
        'place_of_birth': pob.text.trim(),
        'age': age.text.trim(),
        'sex': sex.text.trim(),
        'civil_status': civilStatus.text.trim(),
        'citizenship': citizenship.text.trim(),
        'religion': religion.text.trim(),
        'address': address.text.trim(),
        'contact': contact.text.trim(),
        'email': email.text.trim(),
        'father_name': fatherName.text.trim(),
        'father_occupation': fatherOcc.text.trim(),
        'mother_name': motherName.text.trim(),
        'mother_occupation': motherOcc.text.trim(),
        'spouse_name': spouseName.text.trim(),
        'children': children.text.trim(),
        'elementary_school': elementary.text.trim(),
        'elementary_year': elemYear.text.trim(),
        'high_school': highSchool.text.trim(),
        'high_school_year': hsYear.text.trim(),
        'college': college.text.trim(),
        'course': course.text.trim(),
        'section': section.text.trim(),
        'college_year': collYear.text.trim(),
        'honors': honors.text.trim(),
        'skills': skills.text.trim(),
        'reference_name': ref1Name.text.trim(),
        'reference_position': ref1Pos.text.trim(),
        'reference_contact': ref1Contact.text.trim(),
        'created_at': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biodata saved to Firebase.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save biodata. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    fullName.dispose();
    dob.dispose();
    pob.dispose();
    age.dispose();
    sex.dispose();
    civilStatus.dispose();
    citizenship.dispose();
    religion.dispose();
    address.dispose();
    contact.dispose();
    email.dispose();

    fatherName.dispose();
    fatherOcc.dispose();
    motherName.dispose();
    motherOcc.dispose();
    spouseName.dispose();
    children.dispose();

    elementary.dispose();
    elemYear.dispose();
    highSchool.dispose();
    hsYear.dispose();
    college.dispose();
    course.dispose();
    section.dispose();
    collYear.dispose();
    honors.dispose();

    skills.dispose();

    ref1Name.dispose();
    ref1Pos.dispose();
    ref1Contact.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Biodata"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Open student form',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute<void>(builder: (_) => const FormPage()));
            },
            icon: const Icon(Icons.school_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Personal Information"),

              field("Full Name", fullName),
              field("Date of Birth", dob, hint: "MM/DD/YYYY"),
              field("Place of Birth", pob),
              field("Age", age, keyboard: TextInputType.number),
              field("Sex", sex),
              field("Civil Status", civilStatus),
              field("Citizenship", citizenship),
              field("Religion", religion),
              field("Permanent Address", address, maxLines: 2),
              field("Contact No.", contact, keyboard: TextInputType.phone),
              field(
                "Email Address",
                email,
                keyboard: TextInputType.emailAddress,
              ),

              sectionTitle("Family Background"),

              field("Father's Full Name", fatherName),
              field("Father's Occupation", fatherOcc),
              field("Mother's Full Name", motherName),
              field("Mother's Occupation", motherOcc),
              field("Spouse's Name (if married)", spouseName),
              field("Children (if any)", children),

              sectionTitle("Educational Background"),

              field("Elementary School", elementary),
              field("Year Graduated", elemYear),
              field("High School", highSchool),
              field("Year Graduated", hsYear),
              field("College/Vocational School", college),
              field("Course/Degree", course),
              field("Section", section),
              field("Year Graduated", collYear),
              field("Honors/Awards", honors),

              sectionTitle("Skills & Qualifications"),

              field("Skills", skills, maxLines: 3),

              sectionTitle("Character Reference 1"),

              field("Name", ref1Name),
              field("Position", ref1Pos),
              field("Contact No.", ref1Contact),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveBiodata,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('SUBMIT', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget field(
    String label,
    TextEditingController controller, {
    String? hint,
    int maxLines = 1,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
