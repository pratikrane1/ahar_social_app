import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Text? text;
  final bool? loading;
  final bool? disableTouchWhenLoading;
  final OutlinedBorder? shape;
  final Color? color;
  final ButtonStyle? style;
  final double? height;
  final double? width;

  AppButton(
      {Key? key,
      this.onPressed,
      this.text,
      this.loading = false,
      this.disableTouchWhenLoading = false,
      this.shape,
      this.color,
      this.style,
      this.height,
      this.width})
      : super(key: key);

  Widget _buildLoading() {
    if (loading!) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: style,
          onPressed: disableTouchWhenLoading! && loading! ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[text!, _buildLoading()],
          ),
        ));
  }
}
