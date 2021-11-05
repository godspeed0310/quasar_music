import 'package:flutter/material.dart';
import 'package:quasar_music/viewmodels/input_field_view_model.dart';
import 'package:stacked/stacked.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? additionalNote;
  final double spacing;
  final TextEditingController controller;

  const InputField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.additionalNote,
    this.keyboardType = TextInputType.text,
    this.spacing = 30,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;

    return ViewModelBuilder<InputFieldViewModel>.reactive(
      viewModelBuilder: () => InputFieldViewModel(),
      builder: (context, model, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF353839).withOpacity(0.2),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF8D929A),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: spacing,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: keyboardType,
                      obscureText: isPassword ? !model.isVisible : false,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  isPassword
                      ? GestureDetector(
                          onTap: () => model.toggleVisibility(),
                          child: Container(
                            width: 40,
                            height: 60,
                            child: Center(
                              child: Text(
                                model.isVisible ? 'Hide' : 'Show',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            additionalNote != null
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            additionalNote != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        additionalNote!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8D929A),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
