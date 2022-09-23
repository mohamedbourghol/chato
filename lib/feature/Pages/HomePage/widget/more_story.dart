import 'package:chato/feature/Pages/HomePage/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../story/controller/story_controller.dart';
import '../../../../story/widgets/story_view.dart';
import '../model/getStatus/status_user_model.dart';



class MoreStories extends StatefulWidget {
 final List<StatusUserModel>  statusUser;
 final bool? me;
 final HomeBloc bloc;
 final int index;
  const MoreStories({
    Key? key,required this.statusUser,
  required this.me,
    required this.bloc,
    required this.index
  }) : super(key: key);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();
  late VideoPlayerController controller ;
  bool checkIsImage(String? endUrl) {
    if (endUrl != null) {
      endUrl = endUrl.substring(endUrl.length - 4, endUrl.length);
      if (endUrl.contains('jpeg') ||
          endUrl.contains('jpg') ||
          endUrl.contains('png') ||
          endUrl.contains('gif')) {
        return true;
      }
    }


    return false;
  }
  @override
  void dispose() {
    storyController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StoryView(
        storyItems: [
           for(int i=0;i<widget.statusUser.length;i++)
             ...[
               if(checkIsImage(widget.statusUser[i].status!))
               StoryItem.pageImage(
                 id:widget.statusUser[i].id! ,
                 url:
                 widget.statusUser[i].status!,
                 caption: "",
                 index: i+1,
                 controller: storyController,



               )else

                 StoryItem.pageVideo(
                   widget.statusUser[i].status!,
                   caption: "",
                   index: i+1,
                   id:widget.statusUser[i].id! ,
                   controller: storyController,



                 )
             ]


        ],
        onStoryShow: (s) {

               widget.bloc.onSeenStatusEvent(statusId: s.id!,
               seenNumber: s.index!,
                 index: widget.index
               );
               print("Showing a story");
             

        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,



      ),
    );
  }
}