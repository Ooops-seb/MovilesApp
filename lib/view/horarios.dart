import 'package:flutter/material.dart';

class Horarios extends StatefulWidget {
  const Horarios({super.key});

  @override
  State<Horarios> createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '\nHorarios',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Lunes')),
                DataColumn(label: Text('Martes')),
                DataColumn(label: Text('Miércoles')),
                //DataColumn(label: Text('Jueves')),
                //DataColumn(label: Text('Viernes')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('A.B.C')),
                  DataCell(Text('A.B.C')),
                  DataCell(Text('A.B.C')),
                  //DataCell(Text('')),
                  //DataCell(Text('')),
                ]),
                DataRow(cells: [
                  DataCell(Text('MOVILES')),
                  DataCell(Text('MOVILES')),
                  DataCell(Text('MOVILES')),
                  //DataCell(Text('')),
                  //DataCell(Text('')),
                ]),
                DataRow(cells: [
                  DataCell(Text('LETA')),
                  DataCell(Text('LETA')),
                  DataCell(Text('LETA')),
                  //DataCell(Text('')),
                  //DataCell(Text('')),
                ]),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Información del Lab\n',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure '
                  'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non '
                  'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
