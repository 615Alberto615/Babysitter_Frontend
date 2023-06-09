import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/reglas_cubit.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';
import 'package:front/ui/tutor/component/img_top2.dart';
import 'package:front/ui/tutor/perfil.dart';

import '../../component/filds_forms.dart';

class BookingRules extends StatefulWidget {
  final int tutorId;
  final int userId;
  const BookingRules({Key? key, required this.tutorId, required this.userId})
      : super(key: key);
  @override
  _ReglasScreenState createState() => _ReglasScreenState();
}

class _ReglasScreenState extends State<BookingRules> {
  final TextEditingController _ruleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    try {
      context.read<ReglasCubit>().fetchReglas(
          'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
          widget.tutorId.toString());
    } catch (e) {
      print(e);
    }
    print(widget.tutorId);
    print(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: BlocConsumer<ReglasCubit, ReglasState>(
            listener: (context, state) {
              if (state is ReglasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is ReglaDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro eliminado correctamente')),
                );
                context.read<ReglasCubit>().fetchReglas(
                    'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
                    widget.tutorId.toString());
              } else if (state is ReglaCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro creado correctamente')),
                );
                _ruleController.clear();
                context.read<ReglasCubit>().fetchReglas(
                    'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
                    widget.tutorId.toString());
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  rules(),
                  SizedBox(height: 10),
                  Text('Reglas de la casa',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#20262E'))),
                  SizedBox(height: 10),
                  Text(
                      'Informacion que debe saber antes de aceptar la reserva.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#20262E'))),
                  SizedBox(height: 10),
                  if (state is ReglasLoaded)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.reglas.length,
                      itemBuilder: (context, index) {
                        final rule = state.reglas[index];
                        return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.rule_sharp,
                                color: HexColor('#20262E')),
                            title: Text(rule.rulesHome.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                          ),
                        );
                      },
                    ),
                  if (state is ReglasLoading) CircularProgressIndicator(),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
