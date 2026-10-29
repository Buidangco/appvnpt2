import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/map_utils.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              imageUrl: contact.logoUrl,
              height: 76,
              width: 76,
              borderRadius: 18,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 6),
                  Text(
                    contact.address ?? 'Chưa cập nhật địa chỉ',
                    style: AppTextStyles.meta,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if ((contact.phone ?? '').isNotEmpty)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => launchPhoneCall(contact.phone!),
                            icon: const Icon(Icons.call_outlined),
                            label: const Text('Gọi'),
                          ),
                        ),
                      if ((contact.phone ?? '').isNotEmpty) const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => launchMap(
                            latitude: contact.latitude,
                            longitude: contact.longitude,
                            address: contact.address,
                          ),
                          icon: const Icon(Icons.location_on_outlined),
                          label: const Text('Chỉ đường'),
                        ),
                      ),
                    ],
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
