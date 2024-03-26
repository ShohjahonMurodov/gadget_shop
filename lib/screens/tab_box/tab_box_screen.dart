import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/screens/tab_box/message/message_screen.dart';
import 'package:gadget_shop/screens/tab_box/product/product_screen.dart';
import 'package:gadget_shop/screens/tab_box/profile/profile_screen.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/view_models/tab_view/tab_view_models.dart';
import 'package:provider/provider.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  List<Widget> screens = [
    const ProductScreen(),
    const ProfileScreen(),
    const MessageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          color: AppColors.c_0001FC,
        ),
        unselectedLabelStyle: const TextStyle(
          color: AppColors.c_0A1034,
        ),
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        backgroundColor: AppColors.c_EFF5FB,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.home,
              colorFilter: const ColorFilter.mode(
                AppColors.c_0A1034,
                BlendMode.srcIn,
              ),
            ),
            label: "",
            activeIcon: SvgPicture.asset(
              AppImages.home,
              colorFilter: const ColorFilter.mode(
                AppColors.c_0001FC,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.person,
              colorFilter: const ColorFilter.mode(
                AppColors.c_0A1034,
                BlendMode.srcIn,
              ),
            ),
            label: "",
            activeIcon: SvgPicture.asset(
              AppImages.person,
              colorFilter: const ColorFilter.mode(
                AppColors.c_0001FC,
                BlendMode.srcIn,
              ),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: AppColors.c_0A1034,
            ),
            label: "",
            activeIcon: Icon(
              Icons.message,
              color: AppColors.c_0001FC,
            ),
          ),
        ],
      ),
    );
  }
}
