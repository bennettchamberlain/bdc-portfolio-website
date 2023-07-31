import 'package:flutter/material.dart';

class ButtonBox extends StatefulWidget {
  final double? height;
  final double? width;
  final bool border;
  final String text;
  final double fontSize;
  final bool alignCorL;
  final Function onPressed;
  final bool mobile;

  const ButtonBox(
      {Key? key,
      this.height,
      this.width,
      required this.border,
      required this.text,
      required this.fontSize,
      required this.alignCorL,
      required this.onPressed,
      required this.mobile})
      : super(key: key);

  @override
  _ButtonBoxState createState() => _ButtonBoxState();
}

class _ButtonBoxState extends State<ButtonBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isHovered = true;
        });
      },
      onTap: widget.onPressed as void Function()?,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            AnimatedContainer(
              color: Colors.black,
              duration: const Duration(milliseconds: 300),
              height: _isHovered ? widget.height : 0,
              width: widget.width,
            ),
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                border: widget.border
                    ? Border.all(width: 8, color: Colors.black)
                    : null,
              ),
              child: widget.alignCorL
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.mobile ? 4 : 16.0,
                            vertical: 8.0),
                        child: Text(
                          widget.text,
                          style: TextStyle(
                              color: _isHovered ? Colors.white : Colors.black,
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 6, bottom: 2),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                                color: _isHovered ? Colors.white : Colors.black,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
