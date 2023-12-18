import 'package:flutter/material.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_text.dart';

class BranchDataTable extends StatefulWidget {
  final String branchName;
  const BranchDataTable({super.key, required this.branchName});

  @override
  State<BranchDataTable> createState() => _BranchDataTableState();
}

class _BranchDataTableState extends State<BranchDataTable> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: widget.branchName),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.print,
                color: AppColors.blackColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.01),
        child: Container(
          width: screenSize.width,
          color: AppColors.whiteColor,
          padding: EdgeInsets.all(screenSize.width * 0.01),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: AppText(text: 'ID')),
                  DataColumn(label: AppText(text: 'Name')),
                  DataColumn(label: AppText(text: 'Sender')),
                  DataColumn(label: AppText(text: 'Receiver')),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '1')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '2')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '3')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '4')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '5')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(AppText(text: '6')),
                      DataCell(AppText(text: 'someName')),
                      DataCell(AppText(text: 'senderName')),
                      DataCell(AppText(text: 'receiverName')),
                    ],
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
