import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/screens/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);
  static String id = 'Gallery_page';

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  File? selectedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });

      // Upload the selected image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(selectedImage!);

      uploadTask.then((res) {
        res.ref.getDownloadURL().then((downloadUrl) {
          // Store the download URL or use it as needed
          print('Image Download URL: $downloadUrl');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff3E657B),
        appBar: AppBar(
          backgroundColor: const Color(0xff3E657B),
          elevation: 0,
          leading: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: selectedImage != null
                        ? CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(selectedImage!),
                    )
                        : const Icon(
                      Icons.add,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                selectedImage != null
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>  HomeScreen(

                        ),));
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F3F6),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          isArabic ? 'هيا لنبدأ!!' : 'Let\'s Go!',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5D6B7B)),
                        ),
                      ),
                    ),
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        isArabic ? 'اختر ' : 'Choose a',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        isArabic
                            ? 'صورة الملف الشخصي'
                            : 'Profile Picture',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
