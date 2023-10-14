import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../cubit/app_cubit.dart';
import '../../../states/app_states.dart';
import '../../../widgets/reusable_widgets.dart';
import '../../view_image_screen.dart';

class PersonPhotoScreen extends StatefulWidget {
  const PersonPhotoScreen({super.key,required this.id});

  final String id;

  @override
  State<PersonPhotoScreen> createState() => _PersonPhotoScreenState();
}

class _PersonPhotoScreenState extends State<PersonPhotoScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getPersonPhotos(widget.id);
    _scrollController.addListener(()  {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent
          && !AppCubit.get(context).isLastPersonPhoto){
        AppCubit.get(context).getPersonPhotosFromLast(widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(lang=='en'?'Photos':'الصور'),
          ),
          body: AppCubit.get(context).personPhotos.isNotEmpty
              ? GridView.count(
            controller: _scrollController,
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.69,
            children: AppCubit.get(context).personPhotos
                .asMap()
                .entries
                .map((entry) => buildPhotoItem(entry.key, entry.value))
                .toList(),
          )
              : const Center(
            child: Text(
              'No Photos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPhotoItem(int index, String image) => InkWell(
    onTap: () {
      navigateTo(
        context: context,
        screen: ViewImagesScreen(
          photos:AppCubit.get(context).myPhotos,
          selectedIndex: index,
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(1),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    ),
  );
}