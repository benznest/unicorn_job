import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/pages/home_page.dart';
import 'package:unicorn_app_scheduler/ui/widgets/menu_item_widget.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';

class MenuWidget extends StatelessWidget {
  final HomePageMenu initMenu;
  final bool displayTitle;
  final Function(HomePageMenu)? onMenuSelected;

  MenuWidget(
      {required this.initMenu, this.displayTitle = false, this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.BACKGROUND_PRIMARY,
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MenuItemWidget(
            icon: "assets/images/ic_rocket.png",
            title: "Schedule",
            isSelected: initMenu == HomePageMenu.SCHEDULE,
            displayTitle: displayTitle,
            onTap: () {
              onMenuSelected?.call(HomePageMenu.SCHEDULE);
            },
          ),
          SizedBox(height: 8,),
          MenuItemWidget(
            icon: "assets/images/ic_playlist.png",
            title: "Jobs",
            isSelected: initMenu == HomePageMenu.JOBS,
            displayTitle: displayTitle,
            onTap: () {
              onMenuSelected?.call(HomePageMenu.JOBS);
            },
          ),
        ],
      ),
    );
  }
}
