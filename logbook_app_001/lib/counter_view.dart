import 'package:flutter/material.dart';
import 'counter_controller.dart';
import 'package:flutter/services.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  final TextEditingController _stepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stepController.text = _controller.step.toString();
  }

  Widget _actionBox({
  required VoidCallback onPressed,
  required IconData icon,
  required Color iconColor,
  required Color borderColor,
  required Color fillColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), 
      child: Container(
        decoration: BoxDecoration(
          color: fillColor, 
          border: Border.all(color: borderColor, width: 3), 
          borderRadius: BorderRadius.circular(12), 
        ),
        child: FloatingActionButton(
          backgroundColor: fillColor, 
          onPressed: onPressed,
          child: Icon(icon, color: iconColor), 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogBook: Versi SRP"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Total Hitungan:"),
          Text('${_controller.value}', style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            child: TextField(
              controller: _stepController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, 
              ],
              decoration: const InputDecoration(labelText: "Step"),
              onChanged: (val) {
                final stepValue = int.tryParse(val) ?? 1;
                setState(() {
                  _controller.setStep(stepValue);
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text("Riwayat Aktivitas (5 terakhir):"),
          Expanded(
            child: ListView.builder(
              itemCount: _controller.history.length,
              itemBuilder: (context, index) {
                final item = _controller.history[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  padding: const EdgeInsets.all(8), 
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    border: Border.all(color: item["color"] as Color, width: 2), 
                    borderRadius: BorderRadius.circular(8), 
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["text"] as String,
                        style: TextStyle(color: item["color"] as Color),
                      ),
                      Text(
                        "Waktu: ${item["time"]}",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _actionBox(
            onPressed: () => setState(() => _controller.decrement()),
            icon: Icons.remove,
            iconColor: Colors.black,
            borderColor: Colors.red,
            fillColor: Colors.red,
          ),
          _actionBox(
            onPressed: () => setState(() => _controller.increment()),
            icon: Icons.add,
            iconColor: Colors.black,
            borderColor: Colors.green,
            fillColor: Colors.green,
          ),
          _actionBox(
            onPressed: () => setState(() => _controller.reset()),
            icon: Icons.refresh,
            iconColor: Colors.black,
            borderColor: Colors.red,
            fillColor: Colors.red,
          ),
        ],
      ),
    );
  }
}