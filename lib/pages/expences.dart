import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expences Optimizer',
          style: TextStyle(color: Colors.white),  
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Container(
            color: Colors.yellow,
            child: IconButton(
              onPressed: () => {}, 
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}