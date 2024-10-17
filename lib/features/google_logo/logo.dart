import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       InkWell(
        onTap: (){},
         child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 45),
            width: 50,
            height: 40,
               
            // decoration: BoxDecoration(color: Colors.blue),
            child: Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
            ),
             ),
       );
  }
}
