import 'package:flutter/widgets.dart';

class AppCardItem extends StatelessWidget {
  const AppCardItem({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          'https://avatars.mds.yandex.net/i?id=e46ee45958cab8535eb21d5af4ddd964dfd14536-5581032-images-thumbs&n=13',
        ),
      ],
    );
  }
}
