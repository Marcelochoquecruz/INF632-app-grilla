// lib/views/main_view.dart
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/clock_widget.dart';
import '../widgets/custom_card.dart';
import '../controllers/theme_controller.dart';

class FloatingPhonesWidget extends StatelessWidget {
  FloatingPhonesWidget({super.key});

  final Random random = Random();
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: List.generate(6, (index) {
        return Positioned(
          left: random.nextDouble() * (screenWidth - 40),
          top: random.nextDouble() * (screenHeight - 40),
          child: Transform.rotate(
            angle: random.nextDouble() * pi * 2,
            child: Icon(
              Icons.phone_android,
              size: 40,
              color: colors[index].withOpacity(0.7),
            ),
          ),
        );
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double horizontalPadding = screenWidth < 600 ? 20.0 : 40.0;
            double contentWidth = screenWidth < 600 ? double.infinity : 600.0;

            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical:
                            orientation == Orientation.portrait ? 30.0 : 20.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Desarrollo de Aplicaciones móviles',
                            style: TextStyle(
                              fontSize: screenWidth < 600 ? 28 : 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait ? 8 : 4,
                          ),
                          Text(
                            'INF-632',
                            style: TextStyle(
                              fontSize: screenWidth < 600 ? 20 : 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height:
                                orientation == Orientation.portrait ? 20 : 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: themeController.toggleTheme,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          themeController.isDarkMode
                                              ? CupertinoIcons.sun_max_fill
                                              : CupertinoIcons.moon_fill,
                                          size: screenWidth < 600 ? 24 : 28,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Cambiar tema',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                            fontSize:
                                                screenWidth < 600 ? 16 : 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                orientation == Orientation.portrait ? 20 : 12,
                          ),
                          if (orientation == Orientation.portrait) ...[
                            const ClockWidget(),
                            const SizedBox(height: 30),
                            _buildExamButton(context, screenWidth),
                            const SizedBox(height: 30),
                            const CustomCard(),
                          ] else ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: ClockWidget(),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      _buildExamButton(context, screenWidth),
                                      const SizedBox(height: 20),
                                      const CustomCard(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                FloatingPhonesWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExamButton(BuildContext context, double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(45),
        child: Text(
          'Ver examen',
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => Get.toNamed('/home'),
      ),
    );
  }
}
