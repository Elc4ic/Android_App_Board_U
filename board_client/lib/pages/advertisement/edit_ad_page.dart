import 'dart:io';

import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/widgets/form/add_form.dart';
import 'package:board_client/widgets/try_again.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixnum/fixnum.dart';


class EditAdPage extends StatefulWidget {
  const EditAdPage({super.key, required this.adId});

  final Int64 adId;

  @override
  State<EditAdPage> createState() => _EditAdPageState();
}

class _EditAdPageState extends State<EditAdPage> {
  List<XFile> files = [];

  String? token = GetIt.I<UserService>().getToken();

  late final _adBloc = AdCubit.get(context);

  List<Widget> wrapFiles(List<XFile> files, BuildContext context) {
    return List.generate(
      files.length,
      (index) => TextButton(
        onPressed: () {
          setState(() {
            files.removeAt(index);
          });
        },
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Image.file(
                File(files[index].path),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Text((index + 1).toString(),
                  style: Theme.of(context).textTheme.bodyMedium),
              const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.close, size: 20, color: Colors.black87)),
            ],
          ),
        ),
      ),
    ).toList();
  }

  @override
  void initState() {
    _adBloc.loadAd(id: widget.adId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2)),
                  child: InkWell(
                    onTap: _imagePick,
                    child: const Center(
                      child: Icon(Icons.file_download_sharp),
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: wrapFiles(files, context),
              ),
              BlocConsumer<AdCubit, AdState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AdLoaded) {
                    return AddAdForm(result: files, ad: state.ad);
                  }
                  if (state is AdLoadingFailure) {
                    return TryAgainWidget(
                      exception: state.exception,
                      onPressed: () {
                        _adBloc.loadAd(id: widget.adId);
                      },
                    );
                  } else {
                    return Container(color: Colors.black12);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _imagePick() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      if (picked != null) {
        files.add(picked);
      }
    });
  }
}
