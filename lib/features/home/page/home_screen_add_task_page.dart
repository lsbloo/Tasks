import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasks_flutter_one/core/state/base_state.dart';
import 'package:tasks_flutter_one/core/state/base_widget_view.dart';
import 'package:tasks_flutter_one/features/home/contract/home_add_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
import 'package:tasks_flutter_one/features/home/presenter/home_add_task_presenter.dart';
import '../../../design-ui/color/colors_resource.dart';

class HomeScreenAddTaskPage extends BaseWidgetView {
  const HomeScreenAddTaskPage({Key? key}) : super(key: key);

  @override
  _HomeScreenAddTaskPageState createState() => _HomeScreenAddTaskPageState();
}

class _HomeScreenAddTaskPageState extends BaseState<HomeScreenAddTaskPage>
    implements HomeAddTaskView {
  HomeAddTaskPresenterImpl? _homeAddTaskPresenterImpl;

  final Completer<GoogleMapController> _controller = Completer();

  String _datePicked = "Hoje";
  bool _setupExpandItem = true;
  bool _isTaskFav = false;
  bool _isLoading = false;
  String _valueDefaultCritTask = "baixa";
  bool _showDialogLocation = false;
  bool _showMapLocate = false;
  String _dataLocateLat = "";
  String _dataLocateLong = "";
  bool _statePopPage = true;

  final TextEditingController _textEditingControllerTitle =
      TextEditingController();
  final TextEditingController _textEditingControllerDescription =
      TextEditingController();

  void _onTaskFavChanged(bool newValue) => setState(() {
        _isTaskFav = newValue;
      });

  @override
  void onViewCreated() {
    _homeAddTaskPresenterImpl =
        HomeAddTaskPresenterImpl(this, HomeRepository());
    super.onViewCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(ColorResource.BLUE_BABY_SKY),
      appBar: AppBar(
        title: const Text("Criar Tarefa"),
        backgroundColor: const Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
        automaticallyImplyLeading: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_showMapLocate) {
            setState(() {
              _showMapLocate = false;
              _statePopPage = true;
              _homeAddTaskPresenterImpl?.setControlPopPage(false);
            });
          }

          return _statePopPage;
        },
        child: _showMapLocate
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(_dataLocateLat),
                        double.parse(_dataLocateLong)),
                    zoom: 13.5,
                  ),
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: LatLng(double.parse(_dataLocateLat),
                          double.parse(_dataLocateLong)),
                    )
                  },
                ),
              )
            : SafeArea(
                left: true,
                right: true,
                bottom: true,
                top: true,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          const Text(
                            "Tarefa",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(ColorResource.BLACK_LIGHT)),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 96,
                              child: Card(
                                elevation: 10,
                                color: const Color(ColorResource.BLACK_LIGHT),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 4, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Data",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      _homeAddTaskPresenterImpl
                                                          ?.onClickLocationIcon();
                                                      if (_showDialogLocation) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                builderContext) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Obter Localização"),
                                                                titleTextStyle: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                                backgroundColor:
                                                                    Colors
                                                                        .greenAccent,
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                                content: const Text(
                                                                    "Obter Localização do dispostivo"),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        _homeAddTaskPresenterImpl
                                                                            ?.onGiveLocationUser();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          "Permitir")),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _showDialogLocation =
                                                                              false;
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      },
                                                                      child: const Text(
                                                                          "Negar")),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.add_location_alt,
                                                      size: 24,
                                                    ))
                                              ],
                                            )),
                                        SizedBox(
                                          height: 34,
                                          child: TextButton(
                                            onPressed: () {
                                              _homeAddTaskPresenterImpl
                                                  ?.onClickDateButton();
                                            },
                                            child: Text(
                                              _datePicked,
                                              style: const TextStyle(
                                                color: Color(ColorResource
                                                    .GREEN_BABY_SKY),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    elevation: 10,
                                    color: const Color(
                                        ColorResource.BLUE_COLOR_STEEL),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            IconButton(
                                              icon: _setupExpandItem
                                                  ? const Icon(
                                                      Icons.arrow_drop_up)
                                                  : const Icon(
                                                      Icons.arrow_drop_down),
                                              onPressed: () {
                                                _homeAddTaskPresenterImpl
                                                    ?.onClickExpandItemsForm();
                                              },
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 0, 14, 0),
                                          child: Visibility(
                                            visible: _setupExpandItem,
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      Text("Titulo"),
                                                      SizedBox(
                                                        width: 24,
                                                      ),
                                                      Flexible(
                                                          child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 24,
                                                                right: 12),
                                                        child: TextField(
                                                          autocorrect: true,
                                                          autofocus: false,
                                                          controller:
                                                              _textEditingControllerTitle,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Insira um titulo"),
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Descrição"),
                                                      const SizedBox(
                                                        width: 24,
                                                      ),
                                                      Flexible(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0,
                                                                right: 12),
                                                        child: TextField(
                                                          autocorrect: true,
                                                          autofocus: false,
                                                          controller:
                                                              _textEditingControllerDescription,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Descrição da tarefa"),
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text("Criticidade"),
                                                      const SizedBox(
                                                        width: 24,
                                                      ),
                                                      DropdownButton(
                                                        items: const [
                                                          DropdownMenuItem(
                                                            value: "baixa",
                                                            child:
                                                                Text("Baixa"),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: "media",
                                                            child:
                                                                Text("Média"),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: "alta",
                                                            child: Text("Alta"),
                                                          ),
                                                        ],
                                                        onChanged: (onChange) {
                                                          setState(() {
                                                            _valueDefaultCritTask =
                                                                onChange!;
                                                          });
                                                        },
                                                        value:
                                                            _valueDefaultCritTask,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text("Favoritar?"),
                                                      const SizedBox(
                                                        width: 24,
                                                      ),
                                                      Checkbox(
                                                          value: _isTaskFav,
                                                          onChanged: (value) {
                                                            _onTaskFavChanged(
                                                                value!);
                                                          }),
                                                    ],
                                                  ),
                                                ])),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Visibility(
                                    visible: _setupExpandItem,
                                    child: ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.green),
                                        ),
                                        onPressed: () {
                                          _homeAddTaskPresenterImpl
                                              ?.onClickAddTask(
                                                  _textEditingControllerTitle
                                                      .text,
                                                  _textEditingControllerDescription
                                                      .text,
                                                  _datePicked,
                                                  _isTaskFav,
                                                  _dataLocateLat,
                                                  _dataLocateLong);
                                        },
                                        child: !_isLoading
                                            ? const Text("Adicionar")
                                            : const CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                backgroundColor: Color(
                                                    ColorResource
                                                        .BLUE_COLOR_SPLASH_SCREEN),
                                              )),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void showPageDatePicker() {
    _selectDate(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      _homeAddTaskPresenterImpl?.onSaveDateSelected(pickedDate);
    }
  }

  @override
  void showDatePickedSelected(String date) {
    setState(() {
      _datePicked = date;
    });
  }

  @override
  void setupExpandItems() {
    setState(() {
      _setupExpandItem = !_setupExpandItem;
    });
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
      _isLoading = flag;
    });
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  popPage() {
    _homeAddTaskPresenterImpl?.popBackStack(context);
  }

  @override
  void setupDialogConfirmLocation() {
    setState(() {
      _showDialogLocation = true;
    });
  }

  @override
  void setupMapWithLocate(String lat, String long) {
    setState(() {
      _showMapLocate = true;
      _dataLocateLat = lat;
      _dataLocateLong = long;
      _statePopPage = false;
    });
  }
}
