import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:tasks_flutter_one/features/home/contract/home_contract.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
import 'package:tasks_flutter_one/features/home/presenter/home_presenter.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';
import 'package:tasks_core/design-ui/components/add_task_component.dart';
import '../data/model/task_vo.dart';
import '../data/provider/home_task_provider.dart';

class HomeScreenPage extends BaseWidgetView {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  BaseState<BaseWidgetView> createState() => _HomeScreenPageStateState();
}

class _HomeScreenPageStateState extends BaseState<HomeScreenPage>
    implements HomeView {
  HomePresenterImpl? _homePresenterImpl;
  bool _showItemTasksView = false;
  bool _showLoadingPage = false;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void onViewCreated() {
    _homePresenterImpl = HomePresenterImpl(this, HomeRepository());
    _homePresenterImpl?.init();
    print("onViewCreated");
    super.onViewCreated();
  }

  @override
  Widget build(BuildContext context) {
    _homePresenterImpl?.init();
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color(ColorResource.BLUE_BABY_SKY),
        appBar: AppBar(
          title: const Text("Tarefas"),
          backgroundColor: const Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
          automaticallyImplyLeading: false,
        ),
        body: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            left: true,
            right: true,
            top: true,
            bottom: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AddTaskHeaderComponent(onCLick: () {
                    print("click called");
                    _homePresenterImpl?.onCLickAddTask();
                  }),
                  _showLoadingPage
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor:
                                Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
                          ),
                        )
                      : Container(),
                  Visibility(
                    visible: _showItemTasksView,
                    child: Consumer<HomeTaskProvider>(
                      builder: (context, homeTaskProvider, child) {
                        return Flexible(
                          child: ListView.builder(
                              itemCount: homeTaskProvider.tasksList?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onDoubleTap: () {
                                    _homePresenterImpl?.onChangeLongPress(
                                        !homeTaskProvider.onDoubleTapTaskCard);

                                    if (homeTaskProvider.onDoubleTapTaskCard) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Deletar Tarefa"),
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              content: const Text(
                                                  "Deseja deletar esta tarefa?"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _homePresenterImpl
                                                          ?.onClickDeleteTask(
                                                              homeTaskProvider
                                                                      .tasksList![
                                                                  index]);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Sim")),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    (states) {
                                                      // If the button is pressed, return green, otherwise blue
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed)) {
                                                        return Colors.redAccent;
                                                      }
                                                      return Colors.red;
                                                    })),
                                                    onPressed: () {
                                                      setState(() {
                                                        _homePresenterImpl
                                                            ?.onChangeLongPress(
                                                                homeTaskProvider
                                                                    .onDoubleTapTaskCard);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text("Não")),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  onTap: () {
                                    _homePresenterImpl?.navigateToEditTaskPage(
                                        context,
                                        homeTaskProvider.tasksList![index]);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            color: Colors.greenAccent,
                                            elevation: 10,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Text(
                                                              homeTaskProvider
                                                                  .tasksList![
                                                                      index]
                                                                  .title)),
                                                      IconButton(
                                                          onPressed: () {
                                                            homeTaskProvider
                                                                        .tasksList![
                                                                            index]
                                                                        .latitude !=
                                                                    ""
                                                                ? showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            builderContext) {
                                                                      return AlertDialog(
                                                                        title: Text(homeTaskProvider
                                                                            .tasksList![index]
                                                                            .title),
                                                                        titleTextStyle: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black,
                                                                            fontSize: 20),
                                                                        backgroundColor:
                                                                            Colors.greenAccent,
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20))),
                                                                        content:
                                                                            SizedBox(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height:
                                                                              300,
                                                                          child:
                                                                              GoogleMap(
                                                                            initialCameraPosition:
                                                                                CameraPosition(
                                                                              target: LatLng(double.parse(homeTaskProvider.tasksList![index].latitude), double.parse(homeTaskProvider.tasksList![index].longitude)),
                                                                              zoom: 13.5,
                                                                            ),
                                                                            onMapCreated:
                                                                                (mapController) {
                                                                              _controller.complete(mapController);
                                                                            },
                                                                            markers: {
                                                                              Marker(
                                                                                markerId: const MarkerId("currentLocation"),
                                                                                position: LatLng(double.parse(homeTaskProvider.tasksList![index].latitude), double.parse(homeTaskProvider.tasksList![index].longitude)),
                                                                              )
                                                                            },
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  Navigator.pop(context);
                                                                                });
                                                                              },
                                                                              child: const Text("Fechar")),
                                                                        ],
                                                                      );
                                                                    })
                                                                : showMessage(
                                                                    "Não foi possivel encontrar a localização desta tarefa");
                                                          },
                                                          icon: const Icon(
                                                            Icons.location_on,
                                                            size: 24,
                                                          ))
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, bottom: 8),
                                                    child: Text(
                                                      homeTaskProvider
                                                          .tasksList![index]
                                                          .description,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ])),
                                      )),
                                );
                              }),
                        );
                      },
                    ),
                  )
                ]),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  @override
  void sendCallNavigateHome() {
    _homePresenterImpl?.navigateToHomeAddTaskScreen(context);
  }

  @override
  showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  showOrHideLoading(bool flag) {
    setState(() {
      _showLoadingPage = flag;
    });
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  popPage() {}

  @override
  void setupTasksView(List<TaskVO> taskVO) {
    Provider.of<HomeTaskProvider>(context, listen: false)
        .onChangeTasksList(taskVO);
    setState(() {
      _showItemTasksView = true;
    });
  }

  @override
  void onResume() {
    _homePresenterImpl?.init();
    super.onResume();
  }

  @override
  void showOnDeleteDialog(bool flag) {
    Provider.of<HomeTaskProvider>(context, listen: false)
        .onChangeLongPress(flag);
  }
}
