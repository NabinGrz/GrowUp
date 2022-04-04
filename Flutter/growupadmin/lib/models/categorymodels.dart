// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.skills,
  });

  int? id;
  String? name;
  dynamic? skills;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        skills: json["skills"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "skills": skills,
      };
}
/**
 * 

 * 
  FutureBuilder<List>(
          future: getAllCat(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData ||
                snapshot.data != null ||
                snapshot.connectionState == ConnectionState.done) {
              List<String> categoryList = [];
              int i = 0;
              late List<String> nameList;
              for (i = 0; i <= (snapshot.data!.length - 1); i++) {
                categoryList.add(snapshot.data![i].name!);
                nameList = categoryList;
              }
              print("*****************************************");
              print(snapshot.data![0].name!);
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 50,
                    color: darkBlueColor,
                    child: DropdownButton<String>(
                      // Step 3.
                      /// value: snapshot.data![0].name!,
                      value: snapshot.data![0].name!,
                      // Step 4.
                      items: nameList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          _currentItemSelected = newValue!;
                          selectedIndex =
                              nameList.indexOf(_currentItemSelected).toString();
                          catID = snapshot.data![int.parse(selectedIndex)].id!
                              .toString();
                        });
                        print("SELECTED ITEM:" + _currentItemSelected);
                        print("SELECTED INDEX:" + selectedIndex);
                        print("CAT ID:" + catID.toString());
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(
          height: 10,
        ),
 */