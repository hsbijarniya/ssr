# Flutter SSR (Alpha Stage)
>A Backend-Driven UI toolkit, build your dynamic UI with json, and the json format is very similar with flutter widget code.
  
  
## Install
#### 1. Depend on it
Add this to your package's pubspec.yaml file:
```
dependencies:
  ssr: any
```
  
#### 2. Install it
You can install packages from the command line:
  
with Flutter:
```
$ flutter pub get
```
  
Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.
  
#### 3. Import it
Now in your Dart code, you can use:
```dart
import 'package:ssr/ssr.dart';
```
  
## Get started
You should use `ServerSideRendering.build` method to covert a json string into flutter widget. It will be time-consuming. so you'd better using `FutureBuilder` to build the UI.
  
```dart
import 'package:ssr/ssr.dart';

class PreviewPage extends StatelessWidget {
  final String jsonString;

  PreviewPage(this.jsonString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: FutureBuilder<Widget>(
        future: _buildWidget(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox.expand(
                  child: snapshot.data,
                )
              : Text("Loading...");
        },
      ),
    );
  }

  Future<Widget> _buildWidget(BuildContext context) async {
    return ServerSideRendering.build(jsonString, context);
  }
}
```
  

## How to implement for custom widgets
This is a RaisedButton widget parser.
```dart
import 'package:ssr/ssr.dart';
import 'package:flutter/material.dart';

ServerSideRendering.register('RaisedButton', ({Map args = const {}}) {
    return RaisedButton(
      color: args['color'],
      disabledColor: args['disabledColor'],
      disabledElevation: args['disabledElevation'],
      disabledTextColor: args['disabledTextColor'],
      elevation: args['elevation'],
      padding: args['padding'],
      splashColor: args['splashColor'],
      textColor: args['textColor'],
      child: args['child'],
      onPressed: () {
      },
    );
});
```
  
## How to add a click listener
Add "click_event" property to your widget json definition. for example:
```dart
var raisedButton_json =
'''
{
    'Container': {
        'alignment': 'Alignment.center',
        'child': {
            'RaisedButton' : {
                'color': {
                    Color: [0xFF00FF],
                },
                'textColor': {
                    Color: [0x00FF00],
                },
                'splashColor' : {
                    'Color': [0x00FF00],
                },
                'click_event' : 'route://productDetail?goods_id=123',
                'child' : {
                    'Text': ['I am a button']
                }
            }
        }
    }
}
```
  

## Widget Documents
Already completed widget/registery:
* AppBar
* Color
* Column
* Container
* Row
* Scaffold
* Text
* TextStyle