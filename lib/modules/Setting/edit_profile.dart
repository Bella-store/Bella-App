import 'package:bella_app/modules/Setting/cubit/edit_profile_cubit.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel currentUser;

  const EditProfileScreen({super.key, required this.currentUser});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  File? _imageFile;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.userName);
    _emailController =
        TextEditingController(text: widget.currentUser.userEmail);
    _addressController =
        TextEditingController(text: widget.currentUser.address);
    _phoneController = TextEditingController(text: widget.currentUser.phone);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      final storageRef = FirebaseStorage.instance.ref().child('user_images/$fileName');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isUploading = true;
    });

    String? imageUrl;

    if (_imageFile != null) {
      imageUrl = await _uploadImageToFirebase(_imageFile!);
    }

    final updatedUser = widget.currentUser.copyWith(
      userName: _nameController.text,
      userEmail: _emailController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      userImage: imageUrl ?? widget.currentUser.userImage,
    );

    context.read<EditProfileCubit>().updateUserProfile(updatedUser);

    setState(() {
      _isUploading = false;
    });

    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.editProfile(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Implement delete account logic here
            },
          ),
        ],
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : CachedNetworkImageProvider(
                                widget.currentUser.userImage) as ImageProvider,
                        child: _imageFile == null
                            ? const Icon(Icons.camera_alt, size: 30)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      widget.currentUser.userName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 20),
                  _buildTextField('Email Address', _emailController),
                  const SizedBox(height: 10),
                  _buildTextField('Username', _nameController),
                  const SizedBox(height: 10),
                  _buildTextField('Address', _addressController),
                  const SizedBox(height: 10),
                  _buildTextField('Mobile Number', _phoneController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isUploading ? null : _saveProfile,
                    child: _isUploading
                        ? const CircularProgressIndicator()
                        : const Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
