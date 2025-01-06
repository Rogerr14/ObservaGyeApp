import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/slider_page/widget/app_information.dart';
import 'package:observa_gye_app/modules/slider_page/widget/information_citizen.dart';
import 'package:observa_gye_app/modules/slider_page/widget/user_information.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageViewController,
            onPageChanged: _onPageChange,
            children:  [
              InformationCitizen(),
              AppInformation(),
              UserInformation()
            ],
          ),
          PageIndicator(currentPageIndex: _currentPageIndex, tabController: _tabController, onUpdateCurrentPageIndex: _updateCurrentPageIndex),
          Visibility(
            visible: _currentPageIndex == 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Align(
                alignment: Alignment.bottomRight,
                // top: 50,
                // right: 20,
                child: FadeInLeft(
                  animate: true,
                  delay: const Duration(milliseconds: 700),
                  child: FilledButtonWidget(
                    onPressed: () {
                      final storage = SecureStorage();
                      storage.setInfomation('true');
                      GlobalHelper.navigateToPageRemove(context, '/login');
                    },
                    text: 'Continuar',
                    color: AppTheme.white,
                    width: 30,
                    colorText: AppTheme.primaryColor,
                  )),
              ),
            ),
          )
        ],
      ),
    );
  }

  _onPageChange(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    _currentPageIndex = currentPageIndex;
    setState(() {});
  }
  
   _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator(
      {super.key,
      required this.currentPageIndex,
      required this.tabController,
      required this.onUpdateCurrentPageIndex});

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_outlined,
              size: 30,
              color: AppTheme.white,
            ),
          ),
           TabPageSelector(
            controller: tabController,
            color: AppTheme.hinText,
            selectedColor: AppTheme.white,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 30,
              color: AppTheme.white,
            ),
          ),
        ],
      ),
    );
  }
}
