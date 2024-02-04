import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/chooseProfile/widgets/profile_icon.dart';
import 'package:hadi_bulsana/ui/views/homeowner/auth/host_tabbar_auth_screen.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/tenant_tabbar_auth_screen.dart';

class ChooseProfile extends StatelessWidget {
  const ChooseProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profil Seç',
            style: TextStyle(
                fontSize: 22.0,
                color: dark ? AppColors.whiteColor : AppColors.darkerGrey,
                fontWeight: FontWeight.bold),
          ),
          GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 32.0,
                  crossAxisSpacing: 8.0,
                  crossAxisCount: 2),
              itemCount: 2,
              itemBuilder: (BuildContext ctx, index) {
                Color iconColor =
                    index == 0 ? AppColors.error : AppColors.primaryColor;
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HostTabbarAuthScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TenantTabbarAuthScreen()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: ProfileIcon(
                                color: iconColor,
                              )),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        index == 0 ? 'Ev Sahibi' : 'Kiracı',
                        style: TextStyle(color: iconColor),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class Smile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size.width * .20, center.height * .50),
        size.shortestSide * .05, paint);

    canvas.drawCircle(Offset(size.width * .80, center.height * .50),
        size.shortestSide * .05, paint);

    var startPoint = Offset(size.width * .25, size.height / 2);
    var controlPoint1 = Offset(size.width * .3, size.height / 1.6);
    var controlPoint2 = Offset(size.width * .6, size.height / 1.6);
    var endPoint = Offset(size.width * .8, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.cubicTo(size.width * .8, size.height / 2, size.width * .86,
        size.height / 2, size.width * .8, size.height / 1.8);

    path.cubicTo(size.width * .6, size.height / 1.4, size.width * .3,
        size.height / 1.46, size.width * .25, size.height / 1.7);

    path.cubicTo(size.width * .25, size.height / 1.68, size.width * .18,
        size.height / 2, size.width * .25, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Smile oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Smile oldDelegate) => false;
}
