import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;
  final String? url;

  const Background({Key? key, this.child, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            url ??
                'https://i.pinimg.com/originals/cb/10/bc/cb10bc7065a90eee7bbdeb7cd1122a26.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
