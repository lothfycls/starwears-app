import 'package:flutter/material.dart';

class AboutItemCard extends StatelessWidget {
  const AboutItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
         color: Color.fromARGB(255, 236, 233, 233),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About this item",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Brand",
                    style: TextStyle(color: Color(0xff53565A)),
                  
                  ),
                  SizedBox(
                    width: 62,
                  ),
                  Text("Chanel", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Condition",
                     style: TextStyle(color: Color(0xff53565A)),
                   
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Used", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Category",
                     style: TextStyle(color: Color(0xff53565A)),
                   
                  ),
                   SizedBox(
                    width: 44,
                  ),
                  Text("Bags",  style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Quantity",
                     style: TextStyle(color: Color(0xff53565A)),
                  
                  ),
                   SizedBox(
                    width: 46,
                  ),
                  Text("1", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}