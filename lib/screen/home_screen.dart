import 'package:bmi/constant/colors.dart';
import 'package:bmi/screen/widgets/left_chart.dart';
import 'package:bmi/screen/widgets/right_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double weight = 0;
  double height = 0;
  double calculateBmi = 0;
  double leftChartWidth = 20;
  double rightChartWidth = 20;
  String resultText = '';
  final weightCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [weightTextField(), heightTextField()],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    calculateWidget()
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                calculateBmi.toStringAsFixed(2),
                style: TextStyle(
                  color: blackColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                resultText,
                style: TextStyle(
                  color: orangeColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              RightChartShapeWidget(
                width: rightChartWidth,
              ),
              SizedBox(
                height: 30,
              ),
              LeftChartShapeWidget(
                width: leftChartWidth,
              ),
              SizedBox(
                height: 60,
              ),
              resetFormWidget()
            ],
          ),
          developerName()
        ],
      )),
    );
  }

  void _calculateBmiOnTap() {
    if (_formKey.currentState!.validate()) {
      weight = double.parse(weightCtrl.text);
      height = double.parse(heightCtrl.text);
      setState(() {
        FocusScope.of(context).unfocus();
        calculateBmi = weight / (height * height);

        if (calculateBmi > 25) {
          resultText = 'شما اضافه وزن دارید';
          leftChartWidth = 30;
          rightChartWidth = 250;
        } else if (calculateBmi >= 18.5 && calculateBmi <= 25) {
          resultText = 'وزن شما نرمال است';
          leftChartWidth = 150;
          rightChartWidth = 150;
        } else {
          resultText = 'شما کمبود وزن دارید';
          leftChartWidth = 250;
          rightChartWidth = 30;
        }

      });
    }
  }

  void _resetForm() {
    setState(() {
      weightCtrl.clear();
      heightCtrl.clear();
      height = 0;
      weight = 0;
      calculateBmi = 0;
      rightChartWidth = 20;
      leftChartWidth = 20;
      resultText = '';
    });
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'تو چنده؟ BMI',
        style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget weightTextField() {
    return SizedBox(
      width: 130,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: weightCtrl,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: orangeColor, fontSize: 28),
        onChanged: (value) {
          setState(() {
            weightCtrl.text = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'وزن رو وارد نکردی';
          }
          final weight = int.parse(value);
          if (weight < 0 || weight==0) {
            return 'وزن اشتباهه';
          }
          return null;
        },

        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'وزن : 60',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: orangeColor.withOpacity(0.5),
                fontSize: 28),
            errorStyle: TextStyle(color: orangeColor)),
      ),
    );
  }

  Widget heightTextField() {
    return SizedBox(
      width: 130,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: heightCtrl,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: orangeColor, fontSize: 28),
        onChanged: (value) {
          setState(() {
            heightCtrl.text = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'قد رو وارد نکردی';
          }
          final regex = RegExp(r'^\d+\.\d{2}$');
          if (!regex.hasMatch(value)) {
            return 'قد را اعشاری وارد کن';
          }
          final height = double.parse(value);
          if (height < 0) {
            return 'اندازه قد اشتباهه';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'قد : 1.70',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: orangeColor.withOpacity(0.5),
                fontSize: 28),
            errorStyle: TextStyle(color: orangeColor),

        ),
      ),
    );
  }

  Widget calculateWidget() {
    return InkWell(
      onTap: _calculateBmiOnTap,
      child: Text(
        'محاسبه کن',
        style: TextStyle(
          color: blackColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget resetFormWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _resetForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'فرم رو ریست کن',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.refresh,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget developerName() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        'برنامه نویس : مهنوش هاشمی',
        style: TextStyle(
            color: blackColor, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}
