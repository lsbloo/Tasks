import 'package:flutter/material.dart';
import '../../core/data/model/weather_data_model.dart';
import '../color/colors_resource.dart';
import '../images/Images_resouce.dart';

class WeatherDataComponent extends StatefulWidget {
  final CurrentWeather? weather;

  const WeatherDataComponent({Key? key, required this.weather})
      : super(key: key);

  @override
  State<WeatherDataComponent> createState() => _WeatherDataComponentState();
}

class _WeatherDataComponentState extends State<WeatherDataComponent> {
  late String tempC = "";
  late String tempCT = "";
  late String tempF = "";
  late String temp = "";
  late String location = "";
  late String iconUrlCondition = "";

  @override
  void initState() {
    super.initState();
    _setTemp();
    _setLocation();
    _setCondition();
  }

  void _setTemp() {
    setState(() {
      tempCT = "${widget.weather?.current?.temp_c?.toStringAsPrecision(2)}º";
      tempC = "C:º${widget.weather?.current?.temp_c?.toStringAsPrecision(2)}";
      tempF = "F:º${widget.weather?.current?.temp_f?.toStringAsPrecision(2)}";
      temp = "$tempC $tempF";
    });
  }

  void _setLocation() {
    setState(() {
      location =
          "${widget.weather?.location?.name},${widget.weather?.location?.region}";
    });
  }

  void _setCondition() {
    setState(() {
      iconUrlCondition = "https:${widget.weather?.current?.conditionDataWeather?.icon}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(colors: [
                Color(ColorResource.BLUE_COLOR_STEEL),
                Color(ColorResource.WHITE_BABY_SKY),
              ])),
          child: Card(
            elevation: 16,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tempCT,
                        style:
                            const TextStyle(fontSize: 52, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        temp,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        location,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  Image.network(
                    iconUrlCondition,
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
