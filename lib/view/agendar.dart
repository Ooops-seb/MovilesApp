import 'package:flutter/material.dart';

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pushNamed(context, '/laboratorios');
          },
        ),
        title: Text(
          '\nAgendar Laboratorio',
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
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Container(color: Colors.blue, height: 30)),
                  DataCell(Container(color: Colors.pink[100], height: 30)),
                  DataCell(Container(color: Colors.pink[300], height: 30)),
                ]),
                DataRow(cells: [
                  DataCell(Container(color: Colors.blue[300], height: 30)),
                  DataCell(Container(color: Colors.blue[100], height: 30)),
                  DataCell(Container(height: 30)),
                ]),
                DataRow(cells: [
                  DataCell(Container(color: Colors.blue[700], height: 30)),
                  DataCell(Container(height: 30)),
                  DataCell(Container(height: 30)),
                ]),
              ],
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Profesor',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Profesor 1',
                  child: Text('Profesor 1'),
                ),
                DropdownMenuItem(
                  value: 'Profesor 2',
                  child: Text('Profesor 2'),
                ),
                DropdownMenuItem(
                  value: 'Profesor 3',
                  child: Text('Profesor 3'),
                ),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Laboratorio',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Laboratorio 1',
                  child: Text('Laboratorio 1'),
                ),
                DropdownMenuItem(
                  value: 'Laboratorio 2',
                  child: Text('Laboratorio 2'),
                ),
                DropdownMenuItem(
                  value: 'Laboratorio 3',
                  child: Text('Laboratorio 3'),
                ),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Horario',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Horario 1',
                  child: Text('Horario 1'),
                ),
                DropdownMenuItem(
                  value: 'Horario 2',
                  child: Text('Horario 2'),
                ),
                DropdownMenuItem(
                  value: 'Horario 3',
                  child: Text('Horario 3'),
                ),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // background color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              onPressed: () {},
              child: Text(
                'AGENDAR LAB',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
