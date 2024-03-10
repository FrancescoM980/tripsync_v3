import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:tripsync_v3/ui/common_widget/common_form_field.dart';
import 'package:tripsync_v3/ui/common_widget/main_button.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold_without_appbar.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  final passwordKey = GlobalKey<FormState>(
    debugLabel: 'Login password'
  );
  LayerLink layerLink = LayerLink();
  final bool _isFlagCircle = true;
  final bool _showFlagInInput = true;
  final bool _showArrow = true;
  late List<CountrySelectorNavigator> navigators;
  late CountrySelectorNavigator selectorNavigator;
  final TextEditingController passwordController = TextEditingController();
  List<String> nameOfNavigators = [
    'Page',
    'Dialog',
    'Bottom Sheet',
    'Modal Bottom Sheet',
    'Draggable Bottom Sheet',
    'Dropdown',
  ];
  final PhoneController telefonoController = PhoneController(PhoneNumber(isoCode: IsoCode.IT, nsn: ''));
  String numberPhone = '';
  bool isHidden = true;
  String prefix = '';
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigators = <CountrySelectorNavigator>[
      const CountrySelectorNavigator.draggableBottomSheet(),
      const CountrySelectorNavigator.modalBottomSheet(),
      const CountrySelectorNavigator.dialog(),
      const CountrySelectorNavigator.searchDelegate(),
      const CountrySelectorNavigator.bottomSheet(),

      CountrySelectorNavigator.dropdown(
        backgroundColor: const Color(0xFFE7DEF6),
        borderRadius: BorderRadius.circular(5),
        layerLink: layerLink,
        showSearchInput: true,
      ),
    ];
    selectorNavigator = navigators.first;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        
        return TripScaffoldWithoutAppBar(
          loadingBool: [
            controller.isLoadingLogin
          ],
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/new_logo2.png')
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 3,
                      color: Theme.of(context).dividerColor
                    )
                  ),
                  child: PhoneInput(
                    showArrow: _showArrow,
                    shouldFormat: false,
                    onChanged: (value) {
                      prefix = (value?.countryCode ?? '');
                      numberPhone = (value?.countryCode ?? '') + (value?.nsn ?? '');
                      print(numberPhone + prefix);
                    },
                    validator:
                        PhoneValidator.compose([PhoneValidator.required(
                          errorText: AppLocalizations.of(context)!.errorPhoneValidator
                        ), PhoneValidator.valid(
                          errorText: AppLocalizations.of(context)!.errorPhoneValidator
                        )]),
                    flagShape: _isFlagCircle ? BoxShape.circle : BoxShape.rectangle,
                    showFlagInInput: _showFlagInInput,
                    controller: telefonoController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.phoneForm,
                      border: InputBorder.none
                    ),
                    countrySelectorNavigator: selectorNavigator,
                    defaultCountry: IsoCode.IT,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: passwordKey,
                  child: CommonForm(
                    validator: (p0) {
                      if ((p0?.length ?? ''.length) < 3) {
                        return AppLocalizations.of(context)!.validatorPassword;
                      }
                      
                    },
                    titleText: 'Password', 
                    icon: Icons.lock, 
                    paddingHorizontal: 0,
                    controller: passwordController,
                    isHidden: isHidden,
                    maxLines: 1,
                    iconTrailing: isHidden ? Icons.visibility : Icons.visibility_off, 
                    onTapTrailing: () {
                      isHidden = !isHidden;
                      controller.update();
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.rememberPassword} ',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 13
                      )
                    ),
                    Text(
                      AppLocalizations.of(context)!.clickHere,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                      )
                    )
                  ],
                ),
                SizedBox(height: 20),
                MainButton(
                  paddingButton: 0,
                  paddingInterno: 15,
                  onTap: () async {
                    if (passwordKey.currentState!.validate()) {
                      await controller.saveAutologin(
                        numberPhone, 
                        passwordController.text,
                        prefix
                      );
                      
                    }
                  }, 
                  titleText: AppLocalizations.of(context)!.buttonEnter
                ),
                SizedBox(height: 12.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.dontHaveAccount} ',
                      style: TextStyle(
                        fontWeight: FontWeight.w200
                      )
                    ),
                    Text(
                      AppLocalizations.of(context)!.register,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
                SizedBox(height: 12.5),
                
              ],
            ),
          )
        );
      },
    );
  }
}