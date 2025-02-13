import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_text_field.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mobileHamburgerScreen,
                (route) => false,
              );
            },
            child: SvgPicture.asset(cross),
          )
        ],
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment,
            children: [
              SizedBox(height: height / 20),
              // SizedBox(height: 48),
              Image.asset(logo),
              SizedBox(height: height / 15),
              // SizedBox(height: 60),
              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: mainColor),
              ),
              SizedBox(height: height / 140),
              // SizedBox(height: 10),
              Text(
                'SignUp to continue',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textGreyColor,
                ),
              ),
              SizedBox(height: height / 9),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Please Tell Us Your Name',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        ' *',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  customTextField(
                    controller: nameController,
                    hintText: 'Name',
                  ),
                ],
              ),
              SizedBox(height: height / 9),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UserUpdatedAuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.homeScreen,
                      (route) => false,
                    );
                  } else if (state is AuthFailure) {
                    showToast(state.error);
                  }
                },
                builder: (context, state) {
                  return customBtn(
                    context: context,
                    onTap: () {
                      if (nameController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(
                            UpdatedUserDataEvent(nameController.text.trim()));
                      } else {
                        showToast('Enter Name');
                      }
                    },
                    isLoading: state is AuthLoading ? true : false,
                    btnColor: mainColor,
                    text: 'Confirm Name',
                    icons: arrow,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
