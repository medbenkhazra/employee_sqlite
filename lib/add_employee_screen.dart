import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite/local/db/app_db.dart';
import 'package:sqlite/widget/custom_date_picker_form.dart';
import 'package:drift/drift.dart' as drift;

class AddEmployeeScreen extends StatefulWidget {
  AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late AppDb _db;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerLast = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = AppDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final entity = EmployeeCompanion(
                  userName: drift.Value(_controller.text),
                  firstName: drift.Value(_controllerFirst.text),
                  LastName: drift.Value(_controllerLast.text),
                  dateOfBirth: drift.Value(_dateOfBirth!),
                );

                _db.insertEmployee(entity).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: Text("New employee inserted: $value"),
                     actions: [
                       TextButton(
                         onPressed: (){
                           ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                         },
                          child:Text('Close') )
                     ])
                ));
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('User Name'),
              ),
              controller: _controller,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('First Name'),
              ),
              controller: _controllerFirst,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Last Name'),
              ),
              controller: _controllerLast,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 15,
            ),
            CustomDatepickerFormField(
                controllerBirthday: _controllerBirthday,
                txtLbel: "date of birth",
                callBack: () {
                  pickDateOfBirth(context);
                })
          ],
        ),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: ColorScheme.light(
                      primary: Colors.pink,
                      onPrimary: Colors.white,
                      onSurface: Colors.black),
                  dialogBackgroundColor: Colors.white),
              child: child ?? const Text(""),
            ));
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _controllerBirthday.text = dob;
    });
  }
}
