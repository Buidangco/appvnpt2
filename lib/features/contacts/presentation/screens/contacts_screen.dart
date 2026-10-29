import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../domain/entities/contact.dart';
import '../providers/contacts_providers.dart';
import '../widgets/contact_card.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(contactsProvider(_searchController.text));

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.refresh(contactsProvider(_searchController.text).future),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AppHeader(
                title: 'Liên hệ',
                subtitle: 'Kết nối nhanh với đơn vị lữ hành và đầu mối hỗ trợ hành trình.',
              ),
              const SizedBox(height: 12),
              AppSearchBar(
                controller: _searchController,
                hintText: 'Tìm công ty lữ hành...',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              contactsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => AppErrorState(
                  message: 'Không thể tải danh bạ liên hệ.',
                  onRetry: () => ref.invalidate(contactsProvider),
                ),
                data: (contacts) {
                  if (contacts.isEmpty) {
                    return AppEmptyState(
                      title: 'Không có kết quả',
                      description: 'Không tìm thấy đơn vị liên hệ phù hợp.',
                      onRetry: () => ref.invalidate(contactsProvider),
                    );
                  }

                  final featured = contacts.firstWhere(
                    (c) => c.id == 'ct1',
                    orElse: () => contacts.first,
                  );
                  final others = contacts
                      .where((c) => c.id != featured.id)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FeaturedContactCard(contact: featured),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: others.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (_, index) =>
                            ContactCard(contact: others[index]),
                      ),
                    ],
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

class _FeaturedContactCard extends StatelessWidget {
  const _FeaturedContactCard({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/app_logo.jpg'),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: AppTextStyles.cardTitle),
                  if ((contact.digitalExport ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      contact.digitalExport!,
                      style: AppTextStyles.caption,
                    ),
                  ],
                  if ((contact.address ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(contact.address!, style: AppTextStyles.meta),
                  ],
                  if ((contact.phone ?? '').isNotEmpty) ...[
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => launchPhoneCall(contact.phone!),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.call_outlined,
                            size: 15,
                            color: Colors.teal,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            contact.phone!,
                            style: AppTextStyles.meta.copyWith(
                              color: Colors.teal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.star_rounded, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
