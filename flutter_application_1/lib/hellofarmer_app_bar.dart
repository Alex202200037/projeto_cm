import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelloFarmerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;
  const HelloFarmerAppBar({
    this.onMenuPressed,
    this.onProfilePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2A815E),
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                  onPressed:
                      onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Builder(
                builder: (context) => GestureDetector(
                  onTap:
                      onProfilePressed ??
                      () => Scaffold.of(context).openEndDrawer(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                        ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                        : null,
                    child: FirebaseAuth.instance.currentUser?.photoURL == null
                        ? const Icon(
                            Icons.person,
                            color: Color(0xFF2A815E),
                            size: 28,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.jpg', height: 100),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
