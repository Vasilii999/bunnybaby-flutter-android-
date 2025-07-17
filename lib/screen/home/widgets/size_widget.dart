import 'package:figma21/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import '../../../theme/colors.dart';

class SizeWidget extends StatefulWidget {
  final List<String> size;
  const SizeWidget({super.key, required this.size});

  @override
  State<SizeWidget> createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Размеры',style: f14w700.copyWith(color: dark,height: 1.5,letterSpacing: 0.5, fontFamily: 'Poppins'),),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: SizedBox(
            height: 48,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.size.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: isSelected ? pink : light, width: 1),
                            ),
                            child: Center(
                              child: Text(widget.size[index],style: f14w700.copyWith(color: dark,height: 1.5,letterSpacing: 0.5, fontFamily: 'Poppins'),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
