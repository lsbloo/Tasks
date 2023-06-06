import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_flutter_one/core/state/base_state.dart';
import 'package:tasks_flutter_one/core/state/base_widget_view.dart';
import 'package:tasks_flutter_one/features/home/contract/home_edit_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import 'package:tasks_flutter_one/features/home/data/provider/home_task_provider.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
import '../../../design-ui/color/colors_resource.dart';
import '../presenter/home_edit_task_presenter.dart';

class HomeScreenEditPage extends BaseWidgetView {
  const HomeScreenEditPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenEditPage> createState() => _HomeScreenEditPageViewState();
}

class _HomeScreenEditPageViewState extends BaseState<HomeScreenEditPage>
    implements HomeEditPageView {
  HomeEditPresenter? _homeEditPresenter;

  final TextEditingController _textEditingControllerTitle =
      TextEditingController();
  final TextEditingController _textEditingControllerDescription =
      TextEditingController();

  String _valueDefaultCritTask = "baixa";
  TaskVO? args;

  void _onTaskFavChanged(bool newValue) => setState(() {
        args?.favorite = newValue;
      });

  @override
  void onViewCreated() {
    _homeEditPresenter = HomeEditPresenter(this, HomeRepository());
    _homeEditPresenter?.init();
    super.onViewCreated();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as TaskVO;

    return Scaffold(
      backgroundColor: const Color(ColorResource.BLUE_BABY_SKY),
      appBar: AppBar(
        title: Text(args!.title),
        backgroundColor: const Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
        automaticallyImplyLeading: true,
      ),
      body: Consumer<HomeTaskProvider>(
        builder: (context, homeTaskProvider, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Card(
                    elevation: 10,
                    color: const Color(ColorResource.BLUE_COLOR_STEEL),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 24),
                              child: Text(
                                "Editar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: IconButton(
                                  onPressed: () {
                                    _homeEditPresenter?.onClickLocationIcon(
                                        !homeTaskProvider.showLocateEditDialog);

                                    if (homeTaskProvider.showLocateEditDialog) {
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext builderContext) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Obter Localização"),
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
                                                  "Obter Localização do dispostivo"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _homeEditPresenter?.onGiveLocationUser();
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Permitir")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        Provider.of<HomeTaskProvider>(
                                                                context)
                                                            .onShowEditAlertLocateDialog(
                                                                false);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text("Negar")),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add_location_alt,
                                    size: 24,
                                  )),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: Visibility(
                              visible: true,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Text("Titulo"),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 12),
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: false,
                                          controller:
                                              _textEditingControllerTitle,
                                          decoration: InputDecoration(
                                              hintText: args!.title),
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
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 12),
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: false,
                                          controller:
                                              _textEditingControllerDescription,
                                          decoration: InputDecoration(
                                              hintText: args!.description),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Criticidade"),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      DropdownButton(
                                        items: const [
                                          DropdownMenuItem(
                                            value: "baixa",
                                            child: Text("Baixa"),
                                          ),
                                          DropdownMenuItem(
                                            value: "media",
                                            child: Text("Média"),
                                          ),
                                          DropdownMenuItem(
                                            value: "alta",
                                            child: Text("Alta"),
                                          ),
                                        ],
                                        onChanged: (onChange) {
                                          setState(() {
                                            _valueDefaultCritTask = onChange!;
                                          });
                                        },
                                        value: _valueDefaultCritTask,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Favoritar?"),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      Checkbox(
                                          value: args!.favorite,
                                          onChanged: (value) {
                                            _onTaskFavChanged(value!);
                                          }),
                                    ],
                                  ),
                                ]),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          _homeEditPresenter?.onClickEditTask(
                              args!,
                              _textEditingControllerTitle.text,
                              _textEditingControllerDescription.text,
                              "baixa",
                              args!.favorite);
                        },
                        child: homeTaskProvider.showLoadingButton
                            ? const Text("Editar")
                            : const CircularProgressIndicator(
                                strokeWidth: 2.0,
                                backgroundColor: Color(
                                    ColorResource.BLUE_COLOR_SPLASH_SCREEN),
                              )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  popPage() {
    _homeEditPresenter?.popBackStack(context);
  }

  @override
  showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  showOrHideLoading(bool flag) {
    Provider.of<HomeTaskProvider>(context, listen: false)
        .onShowLoadingButton(flag);
  }

  @override
  void refresh() {
    setState(() {});
  }

  @override
  void setupDialogConfirmLocation(bool flag) {
    Provider.of<HomeTaskProvider>(context, listen: false).onShowEditAlertLocateDialog(flag);
  }
}
