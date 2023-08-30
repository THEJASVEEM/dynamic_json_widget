///[CustomSchemas] is used for storing JSON for the predifned
///widgets like Banner, Header, Horizontal_List.
///
///It uses the basic widget builders like `ContainerWidgetBuilder`
///and `TextWidgetBuilder` to build a custom wiidget.
class CustomSchemas {
  static const bannerJson = '''{
      "type": "Container",
      "width":"80.w",
      "height": "25.h",
      "margin": "15,20,0,0",
      "padding": "15,20,10,10",
      "click_event" : "route://recipe?recipe_id=123",
      "decoration": {
        "color": "#2EA270",
        "borderRadius": "15"
      },
      "child": {
        "type": "Column",
        "mainAxisAlignment":"start",
        "crossAxisAlignment":"start",
        "children": [
          {
            "type": "Container",
            "width": "26.w",
            "height": "3.h",
            "alignment": "center",
            "padding":"2,2,2,2",
            "decoration": {
              "themeColor": "onSurface",
              "borderRadius": "15",
               "opacity": "0.5"
            },
            "child": {
              "type": "Text",
              "data": "New Recipe",
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "fontSize": "10.s",
                "themeColor":"onSurfaceVariant"
              }
            }
          },
          {
            "type": "Container",
        "color": "#000000",
        "alignment": "center",
        "width": "46.w",
        "height": "3.h",
        "margin": "0,60,0,0",
        "padding": "2,2,2,2",
        "decoration": {
          "themeColor": "onSurface",
          "borderRadius": "15",
          "opacity": "0.5"
        },
            "child": {
              "type": "Text",
              "data": "Cook Chicken Curry",
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "fontSize": "10.s",
                "themeColor":"onSurfaceVariant"
              }
            }
          }
          
        ]
      }
    }''';
  static const headerJson = '''{
  "type": "Container",
  "color": "#FFFFFF",
  "width": "51.w",
  "height": "15.h",
  "padding": "15,20,15,10",
  "child": {
    "type": "Row",
    "mainAxisAlignment": "spaceBetween",
    "crossAxisAlignment": "start",
    "children": [
     { "type": "Container",
  "width": "70.w",
  "height": "15.h",
     "child": {
        "type": "Column",
        "mainAxisAlignment": "center",
        "crossAxisAlignment": "start",
        "children": [
          {
            "type": "Text",
            "data": "Hello Anne",
            "maxLines": 3,
            "overflow": "ellipsis",
            "style": {
              "fontSize": "10.s"
            }
          },
          {
            "type": "Expanded",

             "child": {
              "type": "Text",
              "data": "What would you like to cook today?",
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "fontSize": "16.s",
                "fontWeight":"w800"
              }
          }
          }
        ]
      }
      },
      {
        "type": "CircularAvatar",
        "path": "asset",
        "image":"assets/images/profile_image.png"
      }
    ]
  }
}''';
  static const horizontalItemsJson = '''
    {

    "type": "Container",
        "color": "#FFFFFF",
        "height": "21.h",
        "alignment": "left",    
    "child":{
    "type": "Column",
     "mainAxisAlignment": "start",
          "crossAxisAlignment": "start",
    "children": [
      {
        "type": "Container",
        "color": "#FFFFFF",
        "height": "3.h",
        "alignment": "left",
        "margin": "15,5,15,0",
        "child": {
          "type": "Row",
          "mainAxisAlignment": "spaceBetween",
          "crossAxisAlignment": "center",
          "children": [
            {
              "type": "Text",
              "data": "Categories",
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "fontSize": "12.s",
                "fontWeight": "w800"
              }
            },
            {
              "type":"SizedBox",
              "height":"20"
            },
            {
              "type": "Text",
              "data": "See All",
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "color": "#2EA270",
                "fontSize": "8.s",
                "fontWeight": "w600"
              }
            }
          ]
        }
      },
      {
        "type": "Container",
        "width": "90.w",
        "height": "15.h",
        "margin": "10,10,0,0",
        "child": {
          "type": "ListView",
          "scrollDirection": "horizontal",
          "children": [
            {
              "type": "CircularItem",
              "text": "Breakfast",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/breakfast.png?alt=media&token=db70db25-c909-408d-a8f7-61baed42bbf6"
            },
            {
              "type": "CircularItem",
              "text": "Lunch",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/lunch.png?alt=media&token=75f5423f-dd7a-4344-a62f-098e0de49c5a"
            },
            {
              "type": "CircularItem",
              "text": "Dinner",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/dinner.png?alt=media&token=c9f6de75-aaff-4369-aecf-1feefcbe2348"
            },
            {
              "type": "CircularItem",
              "text": "Vegan",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/vegan.png?alt=media&token=caf2a6f9-e992-4c7d-91aa-a35ec1643b5d"
            },
            {
              "type": "CircularItem",
              "text": "Meat Based",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/meat_based.png?alt=media&token=7bb2c486-defa-453a-80cf-d3b5b7dcad06"
            },
            {
              "type": "CircularItem",
              "text": "Salads",
              "image": "https://firebasestorage.googleapis.com/v0/b/nymble-3e640.appspot.com/o/salad.png?alt=media&token=87d89340-74ac-4639-955a-e41c7c8be6d9"
            }
          ]
        }
      }
    ]
  }
}''';
}
