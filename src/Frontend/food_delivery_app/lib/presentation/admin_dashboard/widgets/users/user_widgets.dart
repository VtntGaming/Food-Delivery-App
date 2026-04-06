import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/theme.dart';
import '../common/app_widgets.dart';

class AdminUserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  AdminUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class UserListTile extends StatelessWidget {
  final AdminUserModel user;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserListTile({
    Key? key,
    required this.user,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.primaryDark.withOpacity(0.1),
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: AppTheme.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.xs),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryDark.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        user.role,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.primaryDark,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.md),
          AppDivider(padding: EdgeInsets.zero),
          const SizedBox(height: AppTheme.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                label: 'Chỉnh sửa',
                onPressed: onEdit ?? () {},
                backgroundColor: AppTheme.accentOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.sm,
                ),
              ),
              const SizedBox(width: AppTheme.md),
              AppButton(
                label: 'Xóa',
                onPressed: onDelete ?? () {},
                backgroundColor: AppTheme.accentRed,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.sm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UsersSection extends StatelessWidget {
  final List<AdminUserModel> users;
  final VoidCallback? onEditUser;
  final VoidCallback? onDeleteUser;

  const UsersSection({
    Key? key,
    required this.users,
    this.onEditUser,
    this.onDeleteUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const AppEmptyState(
        message: 'Không có người dùng',
        icon: Icons.person_outline,
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppTheme.md),
      itemBuilder: (context, index) {
        return UserListTile(
          user: users[index],
          onEdit: onEditUser,
          onDelete: onDeleteUser,
        );
      },
    );
  }
}
