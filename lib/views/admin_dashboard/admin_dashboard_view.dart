library admin_dashboard_view;

import 'package:bdc_website_v2/models/blog/blog_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'admin_dashboard_view_model.dart';

part 'admin_dashboard_mobile.dart';
part 'admin_dashboard_tablet.dart';
part 'admin_dashboard_desktop.dart';

class AdminDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminDashboardViewModel>.reactive(
      viewModelBuilder: () => AdminDashboardViewModel(),
      builder: (context, viewModel, _) {
        return ScreenTypeLayout.builder(
          mobile: (_) => _AdminDashboardMobile(viewModel),
          tablet: (_) => _AdminDashboardDesktop(viewModel),
          desktop: (_) => _AdminDashboardDesktop(viewModel),
        );
      },
    );
  }
}

// ─── Shared Admin Body ──────────────────────────────────────────────────────────

class _AdminBody extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  const _AdminBody(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontFamily: 'Primetime',
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              tooltip: 'Sign out',
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.go('/login');
              },
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            tabs: [
              Tab(text: 'Blogs'),
              Tab(text: 'Projects'),
              Tab(text: 'Resume'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ContentTab(viewModel: viewModel, type: 'blogs'),
            _ContentTab(viewModel: viewModel, type: 'projects'),
            _ResumeTab(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}

// ─── Content Tab ───────────────────────────────────────────────────────────────

class _ContentTab extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  final String type;
  const _ContentTab({required this.viewModel, required this.type});

  String get _label => type == 'blogs' ? 'Blog' : 'Project';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_label}s',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900),
              ),
              _PrimaryButton(
                label: 'New $_label',
                icon: Icons.add,
                onTap: () => context.go('/editor/$type'),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 2, color: Colors.black),
        Expanded(
          child: StreamBuilder<List<Blog>>(
            stream: viewModel.getItemsStream(type),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = snapshot.data ?? [];
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.article_outlined,
                          size: 72, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text(
                        'No ${_label.toLowerCase()}s yet.',
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 12),
                      _PrimaryButton(
                        label: 'Create your first $_label',
                        icon: Icons.add,
                        onTap: () => context.go('/editor/$type'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, thickness: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _PostListTile(
                    item: item,
                    type: type,
                    onDelete: () => viewModel.confirmAndDelete(
                        context, type, item.id, item.title),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Post List Tile ─────────────────────────────────────────────────────────────

class _PostListTile extends StatelessWidget {
  final Blog item;
  final String type;
  final VoidCallback onDelete;
  const _PostListTile(
      {required this.item, required this.type, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: item.imgUrl.isNotEmpty
                ? Image.network(
                    item.imgUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _thumbPlaceholder(),
                  )
                : _thumbPlaceholder(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.createdAt != null
                      ? _formatDate(item.createdAt!)
                      : 'No date',
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionButton(
                icon: Icons.edit_outlined,
                label: 'Edit',
                onTap: () => context.go('/editor/$type/${item.id}'),
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Icons.delete_outline,
                label: 'Delete',
                color: Colors.red,
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thumbPlaceholder() => Container(
        width: 72,
        height: 72,
        color: Colors.grey.shade100,
        child: Icon(Icons.article, color: Colors.grey.shade400, size: 32),
      );

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

// ─── Resume Tab ────────────────────────────────────────────────────────────────

class _ResumeTab extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  const _ResumeTab({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.description_outlined,
                size: 72, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Upload a new resume PDF\nto replace the one shown on the About page.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            ),
            const SizedBox(height: 28),
            _PrimaryButton(
              label: 'Upload Resume PDF',
              icon: Icons.upload_file,
              onTap: viewModel.handleUploadButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared Buttons ────────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton(
      {required this.icon,
      required this.label,
      this.color = Colors.black,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }
}

