import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';

class HomeOwnerAboutPage extends StatefulWidget {
  const HomeOwnerAboutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeOwnerAboutPageState createState() => _HomeOwnerAboutPageState();
}

class _HomeOwnerAboutPageState extends State<HomeOwnerAboutPage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      //backgroundColor: const Color(0xFFFFDD00).withOpacity(0.8),
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor2,
      appBar: HomeOwnerAppBar(
        showBackButton: true,
        title: 'Hakkımızda',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: width * 0.5, //350.0,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.yellow[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            ImagePaths.hallway,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Uygulama Hakkında',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: dark
                                  ? AppColors.dark
                                  : AppColors.primaryColor2,
                              fontWeight: FontWeight.bold,
                            ),
                        /*
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SignikaNegative',
                          fontSize: 25.0,
                          color: AppColors.primaryColor2,
                        ),
                        */
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Hadi Bulsana, apart arama deneyimini kolaylaştırmak ve ev sahipleri ile kiracıları bir araya getirmek amacıyla tasarlanmış özel bir platformdur. Kiralık apart arayışında olanlar için ideal bir çözüm sunarken ev sahiplerine de mülklerini kolayca tanıtabilme imkanı sağlar.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Misyonumuz',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    //const SizedBox(height: 5.0),
                    Text(
                      'Misyonumuz, kullanıcılarımızın konforu ve kolaylığı üzerine odaklanmaktır. Hadi Bulsana olarak amacımız, apart arama sürecini sıkıntısız ve keyifli bir deneyime dönüştürmek, aynı zamanda ev sahiplerinin de potansiyel kiracılarla iletişimini kolaylaştırmaktır.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Neler Sunuyoruz?',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Hadi Bulsana, kullanıcı dostu bir arayüzle birlikte şu olanakları sunar:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final List<String> features = [
                          '• Apart Arama Kolaylığı: Şehir filtreleriyle istenilen lokasyonda arama yapabilme imkanı.',
                          '• Popüler İlanlar: En fazla ilgi gören apartları bir araya getirerek kullanıcılara öneri sunma.',
                          '• Favori Listesi: Beğenilen ilanları takip etmek ve kolayca erişim sağlama.',
                          '• Kullanıcı Dostu Profil Yönetimi: Kişisel bilgileri güncelleme ve apart ilanlarını yönetme imkanı.'
                        ];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            features[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.dark.withOpacity(0.6),
                                ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'İletişim',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Hadi Bulsana ile ilgili herhangi bir sorunuz veya geri bildiriminiz varsa, lütfen bizimle iletişime geçmekten çekinmeyin. Size en iyi hizmeti sunabilmek için buradayız. Hadi Bulsana, apart arama deneyimini yeniden tanımlıyor ve size hayallerinizdeki evi bulma konusunda yardımcı oluyor.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Teşekkür ederiz, Hadi Bulsana Ekibi',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
