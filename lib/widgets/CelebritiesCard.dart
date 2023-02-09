import 'package:flutter/material.dart';
import 'package:starwears/models/celebrity.dart';

class CelebritiesCard extends StatelessWidget {
  final Celebrity celebrity;
  const CelebritiesCard({
    Key? key,
    required this.celebrity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        color: Color.fromARGB(255, 233, 230, 230),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      // height: 350,
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      Image.network(fit: BoxFit.cover, celebrity.pictures[0]),
                )),
            Container(
              // height: 60,
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                celebrity.name,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
              ),
            ),
           const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Profession: ${celebrity.profession}'),
            ),
           const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "${celebrity.itemsCount} Items",
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
               const   SizedBox(width: 70),
                  Text(
                    "${celebrity.activeCount} Active  Products",
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
