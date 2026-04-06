import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final EdgeInsets padding;
  final bool isOutlined;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppTheme.accentOrange,
    this.textColor = AppTheme.white,
    this.width,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppTheme.md,
      vertical: AppTheme.sm,
    ),
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonContent = Text(
      label,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isOutlined ? backgroundColor : textColor,
          ),
    );

    if (isOutlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: backgroundColor),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
          ),
          child: buttonContent,
        ),
      );
    }

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          elevation: 0,
        ),
        child: buttonContent,
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final Color backgroundColor;

  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color = AppTheme.white,
    this.size = AppTheme.iconMd,
    this.backgroundColor = AppTheme.accentOrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: size),
        onPressed: onPressed,
        padding: const EdgeInsets.all(AppTheme.sm),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(AppTheme.md),
    this.backgroundColor = AppTheme.white,
    this.elevation = 0,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusLg),
      ),
      color: backgroundColor,
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusLg),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const AppSectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: titleStyle ?? Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (onSeeAll != null)
              TextButton(
                onPressed: onSeeAll,
                child: Text(
                  'Xem tất cả',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.accentOrange,
                      ),
                ),
              ),
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.xs),
            child: Text(
              subtitle!,
              style: subtitleStyle ?? Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class AppDivider extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets padding;

  const AppDivider({
    Key? key,
    this.color = AppTheme.borderGrey,
    this.height = AppTheme.md,
    this.padding = const EdgeInsets.symmetric(vertical: AppTheme.md),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(color: color, height: height),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const AppEmptyState({
    Key? key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppTheme.iconXl,
              color: AppTheme.textLightGrey,
            ),
            const SizedBox(height: AppTheme.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textGrey,
                  ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppTheme.md),
              AppButton(
                label: 'Thử lại',
                onPressed: onRetry!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
