import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DrawerWidget extends StatelessWidget {
  final String nombre;
  const DrawerWidget({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          const DrawerHeader(
              margin: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                image: DecorationImage(
                    image: AssetImage('assets/Logo.png'),
                    fit: BoxFit.scaleDown), // Ajustar imagen
              ),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Versión 1.0'))),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text(nombre),
                  onTap: () {
                    // Acción cuando se toque el nombre
                  },
                );
              } else if (index == 1) {
                return ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text('Salir'),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
