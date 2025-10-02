import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../theme/color/app_colors.dart';
import '../custom_loading/custom_loading.dart';

class CustomVideo extends StatefulWidget {
  /// video is ( network url , file path , asset path , content Uri path ) by type
  final String video;
  final VideoSourceType type;
  const CustomVideo({
    super.key,
    required this.video,
    this.type = VideoSourceType.network,
  });

  @override
  State<CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitial = true;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child:
          _isInitial
              ? GestureDetector(
                onTap: () {
                  _initial();
                },
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child:
                        _isLoading
                            ? const CustomLoading()
                            : Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.white(context),
                            ),
                  ),
                ),
              )
              : Chewie(controller: _chewieController!),
    );
  }

  Future<void> _initial() async {
    setState(() {
      _isLoading = true;
    });
    switch (widget.type) {
      case VideoSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.video);
        break;
      case VideoSourceType.network:
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.video),
        );
        break;
      case VideoSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.video));
        break;
      case VideoSourceType.contentUri:
        _videoPlayerController = VideoPlayerController.contentUri(
          Uri.parse(widget.video),
        );
        break;
    }

    await _videoPlayerController?.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
    );
    _isInitial = false;
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}

enum VideoSourceType { asset, network, file, contentUri }
