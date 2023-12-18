import 'package:flutter/material.dart';
import 'package:offline_report_system/screens/branch.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:offline_report_system/widgets/app_textfield.dart';
import 'package:offline_report_system/widgets/const.dart';

class ProvinceScreen extends StatefulWidget {
  final String provinceName;
  const ProvinceScreen({super.key, required this.provinceName});

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: widget.provinceName),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.primaryColor,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.01),
                  child: AppText(
                    text: 'List of branches in ${widget.provinceName}',
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                      width: screenSize.width,
                      controller: _searchController,
                      prefixIcon: Icons.search,
                      hintText: 'Search .....'),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Container(
                  width: screenSize.width,
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.01,
                      horizontal: screenSize.width * 0.02),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20.0,
                      ),
                      topRight: Radius.circular(20.0),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provinceList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.only(bottom: screenSize.height * 0.01),
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(color: AppColors.hintColor),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BranchScreen(
                                  branchName: branchList[index],
                                  branchImage: branchImages[index],
                                ),
                              ),
                            );
                          },
                          leading: Image.asset(branchImages[index]),
                          title: AppText(
                            text: branchList[index],
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: const AppText(
                            text: 'location',
                            fontSize: 15.0,
                            color: AppColors.hintColor,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          tileColor: AppColors.whiteColor,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
