import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_bar.dart';

class MyIdsScreen extends StatefulWidget {
  const MyIdsScreen({super.key});

  @override
  State<MyIdsScreen> createState() => _MyIdsScreenState();
}

class _MyIdsScreenState extends State<MyIdsScreen> {
  List<String> faceIds = [
    'Ayman\'s FaceID',
    'Ahmed\'s FaceID',
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        context.go(AppRouter.faceIdListRoute);
      } else if (index == 1) {
        context.go(AppRouter.docsRoute);
      } else if (index == 2) {
        context.go(AppRouter.appRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FaceID\'s Library',
      ),
      body: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: faceIds.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
                      title: Text(faceIds[index]),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            faceIds.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  faceIds.add('New FaceID');
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardColor,
                  padding: const EdgeInsets.all(16),
                  minimumSize: const Size(double.infinity, 50)),
              icon: const Icon(Icons.person_outline),
              label: const Text('Add new FaceID'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My IDs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Docs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'App',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.iconColor,
        onTap: _onItemTapped,
      ),
    );
  }
}