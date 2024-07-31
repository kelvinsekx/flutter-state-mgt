# Evolution of Flutter State Management
One of the old ways of managing state in Flutter is by using the Global State Technique. To achieve this, parent widget hold a global variable of its private stateful widget - State<StatefulWidget>. From there, the global variable can be used to call setState and access the stateful values.

```dart
var globalState;

class ParentWidget extends StatefulWidget {
  ...
// THIS IS A BAD WAY OF DOING THINGS
 @override
  State<StatefulWidget> createState() {
    globalState = _ParentState(); // Here global variable holds the value of the parent's private widget
    return globalState;
  }
}

class _AppState extends State<App> {
  late List<Items> items = itemsM // stateful values that globalState now has control of.
  ...
}
```

## Demerits with the Global Approach
1. Strongly coupled. The child components get to know too much about the parent component. It is too much tomorrow I must agree.
2. State is globally tracked. It turned to be a glorified setState and stateful widget approach.
3. SetState is called outside the widget that owns it.

