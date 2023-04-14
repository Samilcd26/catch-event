import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../Data/State/root_cubit.dart';
import '../../../Data/State/ssfl_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';
import '../../../core/product/navigator/app_router.dart';
import '../../addEvent/view/add_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.parentContex});
  final BuildContext parentContex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool commentBoxVisible = false;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ;
    var _rootState = widget.parentContex.watch<RootCubit>();
    //?
    return _rootState.isLoading
        ? SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: Image.asset("assets/logo.png"),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            showSearch(context: context, delegate: SearchBar(ccontex: context));
                          },
                        ),
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
                  child: Container(
                    color: Colors.black,
                    child: ListView.builder(
                        itemCount: _rootState.followOrganizerList != null ? _rootState.followOrganizerList?.length : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: _rootState.followOrganizerList![index].event!
                                .map((eventList) =>

                                    //Folowwed organizer event item
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.black),
                                        child: Column(
                                          children: [
                                            const Divider(height: 50),
                                            //Card Title
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: Text(_rootState.followOrganizerList![index].title.toString())),
                                                  Expanded(
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(_rootState.followOrganizerList![index].image.toString()),
                                                    ),
                                                  ),

                                                  //?UnFollowButton
                                                  const Expanded(child: SizedBox()),
                                                ],
                                              ),
                                            ),
                                            //event ımage

                                            //!!!!!!!!!!!!!!!!!!!!!!Image.network(eventList.imageUrl.toString()),
                                            CachedNetworkImage(
                                              imageUrl: eventList.imageUrl ?? "https://arctype.com/blog/content/images/2021/04/NULL.jpg",
                                              placeholder: (context, url) => const ImageLoadAnimation(),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                            //Event actions buttons
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    //LikeButon
                                                    LikeDislikeButtonGroup(
                                                        updateState: refresh, parentContex: widget.parentContex, eventID: eventList.id),
                                                    //Comment
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            commentBoxVisible = !commentBoxVisible;
                                                          });
                                                          // context.read<SSFLCubit>().addCommentToEvent(context.read<AccountCubit>().currentUser!.id!, eventList.id!, comment)
                                                        },
                                                        icon: const Icon(Icons.comment)),
                                                    //Share
                                                    IconButton(
                                                        onPressed: () {
                                                          Share.share('check out my website https://example.com');
                                                        },
                                                        icon: const Icon(Icons.share)),
                                                  ],
                                                ),

                                                //Save Event
                                                SaveEventButton(
                                                    parentContex: widget.parentContex, eventID: eventList.id, updateState: refresh)
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            //Event Description
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: ReadMoreText(
                                                eventList.description.toString(),
                                                trimLines: 2,
                                                colorClickableText: Colors.pink,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                              ),
                                            ),

                                            //Event Commants List
                                            //! Etkinlik başladıktan sonra aktif olucak boot olmasın diye
                                            TextButton(
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        _commantListWidget(commentIdList: eventList.commentList),
                                                  );
                                                },
                                                child: Text('${eventList.commentList!.length.toString()} Yorumun Tümünü Görüntüle')),
                                            const Divider(),
                                            Visibility(
                                              visible: commentBoxVisible,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                                                    label: const Center(
                                                      child: Text("Yorum"),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        })),
                  ),
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
    _currentUser = widget.parentContex.read<RootCubit>().currentUser!;
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
          color: isSave ? Colors.white : Colors.white,
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
    _isLike = widget.parentContex.read<RootCubit>().currentUser!.likeList!.contains(widget.eventID);
    _isDisLike = widget.parentContex.read<RootCubit>().currentUser!.disLikeList != null
        ? widget.parentContex.read<RootCubit>().currentUser!.disLikeList!.contains(widget.eventID)
        : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _rootState = widget.parentContex.read<RootCubit>();
    var _ssflState = widget.parentContex.read<SSFLCubit>();
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(50)),
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
              icon: Icon(Icons.thumb_up_alt, color: _isLike == true ? Colors.green.shade700 : Colors.white)),
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
              icon: Icon(Icons.thumb_down_alt, color: _isDisLike == true ? Colors.redAccent.shade400 : Colors.white))
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
        title: Text('Toplam ${commentIdList!.length.toString()} mesaj var.'),
        content: const Text('AlertDialog description'),
        actions: commentIdList!.isNotEmpty && _commentList.isNotEmpty
            ? _commentList
                .map((e) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: FlutterLogo(size: 40.0)),
                          title: Text(e.byAddId.toString()),
                          subtitle: Text(e.contents.toString()),
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
    ccontex.read<RootCubit>().searchOrganizer(query);

    searchList = ccontex.read<RootCubit>().searchList;
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
            color: Colors.white,
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
                  BoxDecoration(shape: BoxShape.circle, color: const Color(0xffc32c37), border: Border.all(color: Colors.white, width: 1)),
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
