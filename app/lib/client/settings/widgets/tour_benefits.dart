import 'package:app/client/settings/widgets/bullet_point.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourBenefits extends StatelessWidget {
  const TourBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const baseTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
    final boldStyle = textTheme.bodyLarge ?? const TextStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Это приложение объединяет все предложения по отдыху в Кыргызстане от надежных организаторов.',
          style: baseTextStyle,
        ),
        const SizedBox(height: AppSpacing.md),
        Text('С нами вы получаете:', style: boldStyle),
        const SizedBox(height: AppSpacing.sm),
        BulletPoint(
          textSpans: [
            TextSpan(text: 'Экономия времени:', style: boldStyle),
            const TextSpan(
              text:
                  ' Все актуальные туры на любую дату теперь собраны в одной удобной ленте. Не тратьте больше часы на поиск в социальных сетях.',
            ),
          ],
        ),
        BulletPoint(
          textSpans: [
            TextSpan(text: 'Безопасность и доверие:', style: boldStyle),
            const TextSpan(
              text:
                  ' мы сотрудничаем только с надежными партнерами. Вы можете ознакомиться с честными отзывами и рейтингами перед тем, как сделать выбор.',
            ),
          ],
        ),
        BulletPoint(
          textSpans: [
            TextSpan(text: 'Простота и удобство:', style: boldStyle),
            const TextSpan(
              text:
                  ' бронируйте и оплачивайте туры онлайн в приложении за несколько кликов.',
            ),
          ],
        ),
      ],
    );
  }
}
