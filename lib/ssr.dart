library ssr;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ServerSideRendering {
  static isRegistered(String key) {
    return _registery.containsKey(key);
  }

  static register(String key, dynamic value) {
    _registery[key] = value;
  }

  static Map forEach(Map tree) {
    Map<String, dynamic> processedTree = {};

    for (var key in tree.keys) {
      var value = tree[key];

      // print(['processing: ', key, value]);

      if (value is List) {
        processedTree[key] = <Widget>[];

        for (var element in value) {
          processedTree[key].add(ServerSideRendering.process(element));
        }
      } else if (value is Map) {
        processedTree[key] = ServerSideRendering.process(value);
      } else if (value is String && _registery.containsKey(value)) {
        processedTree[key] = _registery[value];
      } else {
        processedTree[key] = value;
      }

      // print(['processed: ', key, processedTree[key]]);
    }

    return processedTree;
  }

  static dynamic process(Map tree) {
    // print('process');

    // registered item
    if (tree.keys.length == 1 && _registery.containsKey(tree.keys.first)) {
      String name = tree.keys.first;
      var child = tree[name];

      // print('registeryItem');
      // print(name);
      // print(child);

      List<dynamic> positionalArguments =
          (child is List ? child.takeWhile((value) => value is! Map) : [])
              .toList();

      // print('positionalArguments');
      // print(positionalArguments);

      Map<String, dynamic> namedArguments;

      try {
        namedArguments = child is List
            ? child.firstWhere((element) => element is Map)
            : child;
      } catch (err) {
        namedArguments = {};
      }

      // print('namedArguments');
      // print(namedArguments);

      // print('outside loop');
      var processedTree = ServerSideRendering.forEach(namedArguments);

      // });

      if (processedTree.isEmpty) {
        return Function.apply(_registery[name]!, positionalArguments);
      } else {
        return Function.apply(_registery[name]!, positionalArguments,
            {const Symbol('args'): processedTree});
      }
    }

    var processedTree = ServerSideRendering.forEach(tree);

    return processedTree;
  }

  static Widget build(Map tree, {BuildContext? context}) {
    return ServerSideRendering.process(tree);
  }
}

Map<String, dynamic> _registery = {
  'AppBar': ({Map args = const {}}) => AppBar(
        key: args['key'],
        leading: args['leading'],
        automaticallyImplyLeading: args['automaticallyImplyLeading'] ?? true,
        title: args['title'],
        actions: args['actions'],
        flexibleSpace: args['flexibleSpace'],
        bottom: args['bottom'],
        elevation: args['elevation'],
        shadowColor: args['shadowColor'],
        shape: args['shape'],
        backgroundColor: args['backgroundColor'],
        foregroundColor: args['foregroundColor'],
        brightness: args['brightness'],
        iconTheme: args['iconTheme'],
        actionsIconTheme: args['actionsIconTheme'],
        textTheme: args['textTheme'],
        primary: args['primary'] ?? true,
        centerTitle: args['centerTitle'],
        excludeHeaderSemantics: args['excludeHeaderSemantics'] ?? true,
        titleSpacing: args['titleSpacing'],
        toolbarOpacity: args['toolbarOpacity'] ?? 1.0,
        bottomOpacity: args['bottomOpacity'] ?? 1.0,
        toolbarHeight: args['toolbarHeight'],
        leadingWidth: args['leadingWidth'],
        backwardsCompatibility: args['backwardsCompatibility'],
        toolbarTextStyle: args['toolbarTextStyle'],
        titleTextStyle: args['titleTextStyle'],
        systemOverlayStyle: args['systemOverlayStyle'],
      ),
  'Alignment.center': Alignment.center,
  'Color': (int value) => Color(value),
  'Column': ({Map args = const {}}) => Column(
        key: args['key'],
        mainAxisAlignment: args['mainAxisAlignment'] ?? MainAxisAlignment.start,
        mainAxisSize: args['mainAxisSize'] ?? MainAxisSize.max,
        crossAxisAlignment:
            args['crossAxisAlignment'] ?? CrossAxisAlignment.center,
        textDirection: args['textDirection'],
        verticalDirection: args['verticalDirection'] ?? VerticalDirection.down,
        textBaseline: args['textBaseline'],
        children: args['children'] ?? const <Widget>[],
      ),
  'Container': ({Map args = const {}}) => Container(
        key: args['key'],
        alignment: args['alignment'],
        padding: args['padding'],
        color: args['color'],
        decoration: args['decoration'],
        foregroundDecoration: args['foregroundDecoration'],
        width: args['width'],
        height: args['height'],
        constraints: args['constraints'],
        margin: args['margin'],
        transform: args['transform'],
        transformAlignment: args['transformAlignment'],
        child: args['child'],
        clipBehavior: args['clipBehavior'] ?? Clip.none,
      ),
  'Row': ({Map args = const {}}) => Row(
        key: args['key'],
        mainAxisAlignment: args['mainAxisAlignment'] ?? MainAxisAlignment.start,
        mainAxisSize: args['mainAxisSize'] ?? MainAxisSize.max,
        crossAxisAlignment:
            args['crossAxisAlignment'] ?? CrossAxisAlignment.center,
        textDirection: args['textDirection'],
        verticalDirection: args['verticalDirection'] ?? VerticalDirection.down,
        textBaseline: args['textBaseline'],
        children: args['children'] ?? const <Widget>[],
      ),
  'Scaffold': ({Map args = const {}}) => Scaffold(
        key: args['key'],
        appBar: args['appBar'],
        body: args['body'],
        floatingActionButton: args['floatingActionButton'],
        floatingActionButtonLocation: args['floatingActionButtonLocation'],
        floatingActionButtonAnimator: args['floatingActionButtonAnimator'],
        persistentFooterButtons: args['persistentFooterButtons'],
        drawer: args['drawer'],
        onDrawerChanged: args['onDrawerChanged'],
        endDrawer: args['endDrawer'],
        onEndDrawerChanged: args['onEndDrawerChanged'],
        bottomNavigationBar: args['bottomNavigationBar'],
        bottomSheet: args['bottomSheet'],
        backgroundColor: args['backgroundColor'],
        resizeToAvoidBottomInset: args['resizeToAvoidBottomInset'],
        primary: args['primary'] ?? true,
        drawerDragStartBehavior: args['drawerDragStartBehavior'] =
            DragStartBehavior.start,
        extendBody: args['extendBody'] ?? false,
        extendBodyBehindAppBar: args['extendBodyBehindAppBar'] ?? false,
        drawerScrimColor: args['drawerScrimColor'],
        drawerEdgeDragWidth: args['drawerEdgeDragWidth'],
        drawerEnableOpenDragGesture:
            args['drawerEnableOpenDragGesture'] ?? true,
        endDrawerEnableOpenDragGesture:
            args['endDrawerEnableOpenDragGesture'] ?? true,
        restorationId: args['restorationId'],
      ),
  'Text': (String data, {Map args = const {}}) => Text(
        data,
        key: args['key'],
        style: args['style'],
        strutStyle: args['strutStyle'],
        textAlign: args['textAlign'],
        textDirection: args['textDirection'],
        locale: args['locale'],
        softWrap: args['softWrap'],
        overflow: args['overflow'],
        textScaleFactor: args['textScaleFactor'],
        maxLines: args['maxLines'],
        semanticsLabel: args['semanticsLabel'],
        textWidthBasis: args['textWidthBasis'],
        textHeightBehavior: args['textHeightBehavior'],
      ),
  'TextOverflow.ellipsis': TextOverflow.ellipsis,
  'TextStyle': ({Map args = const {}}) => TextStyle(
        inherit: args['inherit'] ?? true,
        color: args['color'],
        backgroundColor: args['backgroundColor'],
        fontSize: args['fontSize'],
        fontWeight: args['fontWeight'],
        fontStyle: args['fontStyle'],
        letterSpacing: args['letterSpacing'],
        wordSpacing: args['wordSpacing'],
        textBaseline: args['textBaseline'],
        height: args['height'],
        leadingDistribution: args['leadingDistribution'],
        locale: args['locale'],
        foreground: args['foreground'],
        background: args['background'],
        shadows: args['shadows'],
        fontFeatures: args['fontFeatures'],
        decoration: args['decoration'],
        decorationColor: args['decorationColor'],
        decorationStyle: args['decorationStyle'],
        decorationThickness: args['decorationThickness'],
        debugLabel: args['debugLabel'],
        fontFamily: args['fontFamily'],
        fontFamilyFallback: args['fontFamilyFallback'],
        package: args['package'],
        overflow: args['overflow'],
      ),
};
