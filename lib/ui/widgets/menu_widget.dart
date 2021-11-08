import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_image_asset.dart';
import 'package:unicorn_app_scheduler/ui/pages/home_page.dart';
import 'package:unicorn_app_scheduler/ui/widgets/menu_item_widget.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';

class MenuWidget extends StatelessWidget {
  final HomePageMenu initMenu;
  final bool displayTitle;
  final Function(HomePageMenu)? onMenuSelected;

  const MenuWidget(
      {Key? key,
      required this.initMenu,
      this.displayTitle = false,
      this.onMenuSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.BACKGROUND_PRIMARY,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MenuItemWidget(
            icon: MyImageAsset.task,
            title: "Task",
            isSelected: initMenu == HomePageMenu.SCHEDULE,
            displayTitle: displayTitle,
            onTap: () {
              onMenuSelected?.call(HomePageMenu.SCHEDULE);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          MenuItemWidget(
            icon: MyImageAsset.job,
            title: "Jobs",
            isSelected: initMenu == HomePageMenu.JOBS,
            displayTitle: displayTitle,
            onTap: () {
              onMenuSelected?.call(HomePageMenu.JOBS);
            },
          ),
          const Spacer(),
          MenuItemWidget(
            icon: MyImageAsset.info,
            title: "About",
            isSelected: initMenu == HomePageMenu.ABOUT,
            displayTitle: displayTitle,
            onTap: () {
              onMenuSelected?.call(HomePageMenu.ABOUT);
            },
          ),
        ],
      ),
    );
  }
}
