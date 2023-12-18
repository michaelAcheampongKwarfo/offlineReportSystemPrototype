import 'package:flutter/material.dart';
import 'package:offline_report_system/screens/province.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/const.dart';
import 'package:offline_report_system/widgets/grid_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Offline Report'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profileScreen');
            },
            icon: const Icon(Icons.menu)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.primaryColor,
                child: Container(
                  width: screenSize.width,
                  padding: EdgeInsets.all(screenSize.width * 0.02),
                  decoration: const BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text:
                            'SLCB offline report system for province\nand their branch',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.02),
                        child: AppText(
                          text: 'Showing report as at ${DateTime.now()}',
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.bgColor,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.785,
                  padding: EdgeInsets.all(screenSize.width * 0.01),
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      //topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.03,
                            top: screenSize.height * 0.02),
                        child: const AppText(
                          text: 'Province',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: provinceList.length,
                          itemBuilder: (context, index) {
                            return GridCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProvinceScreen(
                                        provinceName: provinceList[index]),
                                  ),
                                );
                              },
                              provinceName: provinceList[index],
                              imagePath: provinceImages[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
