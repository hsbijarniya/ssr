import 'package:flutter/material.dart';
import 'package:ssr/ssr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServerSideRendering.build({
      'Scaffold': {
        'appBar': {
          'AppBar': {
            'title': {
              'Text': ['Hi'],
            },
            'centerTitle': false,
          },
        },
        'body': {
          'Container': {
            'color': {
              'Color': [0xFFFFFFFF],
            },
            'alignment': 'Alignment.center',
            'child': {
              'Row': {
                'children': [
                  {
                    'Column': {
                      'children': [
                        {
                          'Text': ["Text #1."],
                        },
                        {
                          'Text': ["Text #2."],
                        }
                      ],
                    },
                  },
                  {
                    'Text': [
                      "Text #3",
                      {
                        'maxLines': 3,
                        'overflow': 'TextOverflow.ellipsis',
                        'style': {
                          'TextStyle': {
                            'color': {
                              'Color': [0xFF000000],
                            },
                            'fontSize': 20,
                          }
                        }
                      }
                    ]
                  }
                ]
              }
            }
          }
        }
      }
    });
  }
}
