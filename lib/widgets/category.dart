import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  String name;
  String url;
  Color color;
  Function() onTap;

  Category({required this.name, required this.url, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 12.0),
      elevation: 10,
        child: InkWell(
          splashColor: green25,
          onTap: onTap,
          child: SizedBox(
            width: 130,
            height: 160,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  trailing: Image(image: AssetImage(url)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
