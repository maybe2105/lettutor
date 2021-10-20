import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({Key? key, required this.text, required this.icon, required this.onClick}) : super(key: key);

  final String text;
  final IconData icon;
  final Function onClick;


  @override
  Widget build(BuildContext context) {
    return    Container(
      margin: const EdgeInsets.fromLTRB(16,8,16,8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: GestureDetector(
        onTap:()=>onClick,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8,),
              Expanded(
                child: Text(text,style: const TextStyle(
                  fontSize: 16
                ),)
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
