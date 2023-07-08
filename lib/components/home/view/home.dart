import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../Data/State/account_cubit.dart';
import '../../../Data/State/organizer_cubit.dart';
import '../../../Data/State/ssfl_cubit.dart';
import '../../../core/product/helper/cached_network_image.dart';
import '../../../core/product/helper/loading_animation.dart';
import '../../../core/product/helper/snack-bars.dart';
import '../../../core/product/helper/text_button.dart';
import '../../../core/product/navigator/app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.parentContex});
  final BuildContext parentContex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool commentBoxVisible = false;
  double mainhorizontal = 10;
  String sharedMessage = "Hello";

  @override
  Widget build(BuildContext context) {
    var rootState = widget.parentContex.watch<AccountCubit>();
    UserModel currentUser = rootState.currentUser!;
    int? followOrganizerLength = rootState.followOrganizerList != null ? rootState.followOrganizerList?.length : 0;
    var ssflState = widget.parentContex.read<SSFLCubit>();
    TextEditingController commentController = TextEditingController();
    void refresh() {
      setState(() {
        rootState.initializ();
      });
    }

    //?
    return rootState.isLoading
        ? SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: Image.asset("assets/logo.png"),
                      // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            showSearch(context: context, delegate: SearchBar(ccontex: context));
                          },
                        ),
                        //!Notification Button
                        IconButton(onPressed: () {}, icon: _notificationIcon(counter: 2)),
                      ],
                      titleSpacing: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ];
                }),
                //Color.fromRGBO(16, 12, 12, 1)
                //Page Refresh
                body: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        refresh();
                      },
                    );
                  },
                  child: ListView.builder(
                      itemCount: followOrganizerLength,
                      itemBuilder: ((context, index) {
                        OrganizerModel organizerItem = rootState.followOrganizerList![index];
                        return followOrganizerLength != 0
                            ? Column(
                                children: rootState.followOrganizerList![index].event!
                                    .map((eventList) =>

                                        //Folowwed organizer event item
                                        Column(
                                          children: [
                                            //Event Title and avatar icon
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: mainhorizontal),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                      //* Text button:Navigate to Organizer info page
                                                      child: TextButtonNavigateOrganizerInfo(organizerItem: organizerItem)),
                                                  Expanded(
                                                    child:
                                                        //* Organizer Logo
                                                        ClipOval(
                                                            child: CachedImageProvider(
                                                                imageUrl: "https://arctype.com/blog/content/images/2021/04/NULL.jpg")
//_rootState.followOrganizerList![index].image.toString()
                                                            // NetworkImage(_rootState.followOrganizerList![index].image.toString()),
                                                            ),
                                                  ),

                                                  //*Emty fow expanded
                                                  const Expanded(child: SizedBox()),
                                                ],
                                              ),
                                            ),
                                            //event ımage

                                            //!!!Yeniden düzenle
                                            CachedNetImage(
                                                imageUrl: eventList.imageUrl ?? "https://arctype.com/blog/content/images/2021/04/NULL.jpg"),
                                            //* Event actions buttons
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: mainhorizontal),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      //* Like-dislike Button group
                                                      LikeDislikeButtonGroup(
                                                          updateState: refresh, parentContex: widget.parentContex, eventID: eventList.id),
                                                      //TODO Comment Button visibility
                                                      /*
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              commentBoxVisible = !commentBoxVisible;
                                                            });
                                                          },
                                                          icon: const Icon(Icons.comment)),
                                                          */
                                                      //* Event Shared button
                                                      IconButton(
                                                          onPressed: () {
                                                            Share.share(sharedMessage);
                                                          },
                                                          icon: const Icon(Icons.share)),
                                                    ],
                                                  ),

                                                  //* Save Event
                                                  SaveEventButton(
                                                      parentContex: widget.parentContex, eventID: eventList.id, updateState: refresh)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            //* Event Description
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: mainhorizontal),
                                              child: ReadMoreText(
                                                eventList.description.isNotNullOrNoEmpty ? eventList.description.toString() : "...",
                                                trimLines: 2,
                                                colorClickableText: Theme.of(context).colorScheme.primary,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'Daha Fazlasını Göster',
                                                trimExpandedText: 'Daha Azını Göster',
                                              ),
                                            ),

                                            //TODO Event Commants List
                                            /*
                                            TextButton(
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        //! //////////////////////
                                                        _commantListWidget(commentIdList: eventList.commentList),
                                                  );
                                                },
                                                child: Text(eventList.commentList!.isNotEmpty
                                                    ? '${eventList.commentList!.length.toString()} Yorumun Tümünü Görüntüle'
                                                    : "Henüz Yorum Yok")),
                                            */
                                            const SizedBox(height: 20),
                                            const Divider(),
                                            //* Comment Add Textfiled
                                            Visibility(
                                              visible: commentBoxVisible,
                                              child: TextFormField(
                                                controller: commentController,
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          CommentModel newComment = CommentModel(
                                                            contents: commentController.text,
                                                          );
                                                          setState(() {
                                                            ssflState.addCommentToEvent(currentUser.id!, eventList.id!, newComment);
                                                          });
                                                        },
                                                        icon: Icon(Icons.send)),
                                                    label: const Center(
                                                      child: Text("Yorum"),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              )
                            : const Center(child: Text("Gösterilicek Birşey Yok ..."));
                      })),
                )))
        : const LoadingBar();
  }
}

//? Save Event Button /////////////////////////////////////////
class SaveEventButton extends StatefulWidget {
  const SaveEventButton({super.key, required this.parentContex, required this.eventID, required this.updateState});

  ////////////////////////////////////////////////////////////////
  final BuildContext parentContex;
  final eventID;
  final VoidCallback updateState;
  ////////////////////////////////////////////////////////////////
  @override
  State<SaveEventButton> createState() => _SaveEventButtonState();
}

class _SaveEventButtonState extends State<SaveEventButton> {
  bool isSave = false;
  UserModel _currentUser = UserModel();
  @override
  void initState() {
    _currentUser = widget.parentContex.read<AccountCubit>().currentUser!;
    isSave = _currentUser.userEventStore!.contains(widget.eventID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (!isSave) {
            // Addd event store
            var res = await widget.parentContex.read<SSFLCubit>().saveOrganizerEventToUserStore(_currentUser.id!, widget.eventID);
            if (res) {
              isSave = isSave ? false : true;
              widget.updateState();
              ScaffoldMessenger.of(context).showSnackBar(
                WarningMessage("Başarılı", "Kaydedilenlerden eklendi"),
              );
            }
          } else {
            //remove event store
            var res = await widget.parentContex.read<SSFLCubit>().removeOrganizerEventToUserStore(_currentUser.id!, widget.eventID);
            if (res) {
              isSave = isSave ? false : true;
              widget.updateState();
              ScaffoldMessenger.of(context).showSnackBar(
                WarningMessage("Başarılı", "Kaydedilenlerden kaldırıldı"),
              );
            }
          }
        },
        icon: Icon(
          isSave ? Icons.bookmark_added : Icons.bookmark_add,
          color: isSave ? Colors.blue : Colors.black,
        ));
  }
}

//? //////////////////////////////////////////////////////////////////////////////////
class LikeDislikeButtonGroup extends StatefulWidget {
  const LikeDislikeButtonGroup({super.key, required this.parentContex, required this.eventID, required this.updateState});
  //! 111111
  final BuildContext parentContex;
  final eventID;

  final VoidCallback updateState;

  @override
  State<LikeDislikeButtonGroup> createState() => _LikeDislikeButtonGroupState();
}

class _LikeDislikeButtonGroupState extends State<LikeDislikeButtonGroup> {
  //! Like - Dislike buttons event

  bool _isLike = false;
  bool _isDisLike = false;
  @override
  void initState() {
    _isLike = widget.parentContex.read<AccountCubit>().currentUser!.likeList!.contains(widget.eventID);
    _isDisLike = widget.parentContex.read<AccountCubit>().currentUser!.disLikeList != null
        ? widget.parentContex.read<AccountCubit>().currentUser!.disLikeList!.contains(widget.eventID)
        : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _rootState = widget.parentContex.read<AccountCubit>();
    var _ssflState = widget.parentContex.read<SSFLCubit>();
    return Container(
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                if (!_isDisLike && !_isLike) {
                  var res = await _ssflState.addLikeToEvent(_rootState.currentUser!.id!, widget.eventID);
                  if (res) {
                    setState(() {
                      _isLike = _isLike ? false : true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      WarningMessage("Lİke error", "beğeni butonlarında hata var"),
                    );
                  }
                } else {
                  if (_isLike) {
                    var res = await _ssflState.removeLikeEvent(_rootState.currentUser!.id!, widget.eventID);
                    if (res) {
                      setState(() {
                        _isLike = _isLike ? false : true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        WarningMessage("Lİke error", "beğeni butonlarında hata var"),
                      );
                    }
                  }
                }
              },
              icon: Icon(Icons.thumb_up_alt, color: _isLike == true ? Colors.green.shade700 : Colors.black)),
          IconButton(
              onPressed: () async {
                if (!_isDisLike && !_isLike) {
                  var res = await _ssflState.addDislikeToEvent(_rootState.currentUser!.id!, widget.eventID);
                  if (res) {
                    setState(() {
                      _isDisLike = _isDisLike ? false : true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      WarningMessage("Lİke error", "beğeni butonlarında hata var"),
                    );
                  }
                } else {
                  if (_isDisLike) {
                    var res = await _ssflState.removeDislikeEvent(_rootState.currentUser!.id!, widget.eventID);
                    if (res) {
                      setState(() {
                        _isDisLike = _isDisLike ? false : true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        WarningMessage("Lİke error", "beğeni butonlarında hata var"),
                      );
                    }
                  }
                }
              },
              icon: Icon(Icons.thumb_down_alt, color: _isDisLike == true ? Colors.redAccent.shade400 : Colors.black))
        ],
      ),
    );
  }
}

class _commantListWidget extends StatelessWidget {
  _commantListWidget({super.key, required this.commentIdList});

  List<int>? commentIdList;

  @override
  Widget build(BuildContext context) {
    context.read<SSFLCubit>().getCommentList(commentIdList);
    final List<CommentModel> _commentList = context.read<SSFLCubit>().commentsList;
    return AlertDialog(
        title: Text('Toplam ${commentIdList!.length.toString()} yorum var.'),
        actions: commentIdList!.isNotEmpty && _commentList.isNotEmpty
            ? _commentList
                .map((commentItem) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: FlutterLogo(size: 40.0)),
                          title: TextButton(
                              onPressed: () {
                                AutoRouter.of(context).push(UserInfoRoute(userId: commentItem.addedUsersId!));
                              },
                              child: Text(commentItem.addedUsersName.toString())),
                          subtitle: Text(commentItem.contents.toString()),
                          trailing: Icon(Icons.more_vert),
                        )
                      ],
                    ))
                .toList()
            : [Text("data")]);
  }
}

class SearchBar extends SearchDelegate {
  SearchBar({required this.ccontex});
  BuildContext ccontex;

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Cancel bottun
    IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Onay Butonu
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<OrganizerModel>? searchList = [];
    ccontex.read<OrganizerCubit>().searchOrganizer(query);

    searchList = ccontex.read<OrganizerCubit>().searchList;
    if (searchList!.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: searchList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(searchList![index].image.toString())),
              title: Text(searchList[index].title.toString()),
              subtitle: const Text("20000 Takipçi"),
              onTap: () {
                context.router.push(OrganizerInfoRoute(organizerModel: searchList![index]));
              },
            );
          });
    } else {
      return const Divider();
    }
  }
}

class _notificationIcon extends StatelessWidget {
  _notificationIcon({super.key, required this.counter});

  int counter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          const Icon(
            Icons.notifications,
            //color: Colors.black,
            size: 30,
          ),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 5),
            child: Container(
              width: 15,
              height: 15,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: const Color(0xffc32c37), border: Border.all(color: Colors.black, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
