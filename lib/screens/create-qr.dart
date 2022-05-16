import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQR extends StatefulWidget {
  const CreateQR({Key? key}) : super(key: key);

  @override
  State<CreateQR> createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  TextEditingController? name = TextEditingController();
  TextEditingController? event = TextEditingController();

  final GlobalKey _renderObjectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: name!.text + '@' + event!.text,
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor: Colors.white,
                  embeddedImage: AssetImage('assets/images/Peter.jpg'),
                ),
                const SizedBox(height: 40,),
                _buildTextField(context, name, 'Name'),
                const SizedBox(height: 20,),
                _buildTextField(context, event, 'Event'),
                const SizedBox(height: 20,),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.done, size: 30),
                  onPressed: () {
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloaded')));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController? controller, String? hintText) => TextField(
    controller: controller,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );

}
