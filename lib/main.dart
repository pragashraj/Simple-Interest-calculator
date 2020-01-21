import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Interest Calculator App",
      home: MyApp(),
    )
  );
} 


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _MyAppState();
  }
}

  class _MyAppState extends State<MyApp> {

    var formKey=GlobalKey<FormState>(); 
    var currencies=['Rupees','Dollors','Pounds'];
    var selectedItem="";

   @override
    void initState()
    {
        selectedItem=currencies[0];
    }
    
    TextEditingController pricipalController=TextEditingController();
    TextEditingController rOIController=TextEditingController();
    TextEditingController termController=TextEditingController();
    var result='';

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Interest Calculator App"),
          ),

          body: Form(
            key: formKey,
            child:Padding(
              padding:EdgeInsets.all(10.0),
              child:ListView(
                  children: <Widget>[
                      getImageAsset(),

                      Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                        child:TextFormField(
                        keyboardType: TextInputType.number,
                        controller: pricipalController,
                        validator: (String value){
                          if(value.isEmpty)
                          {
                            return "Not Valid";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Principle",
                          hintText: "Ex:10000",
                          border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                          )
                        ),
                      ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                        child:TextFormField(
                          controller: rOIController,
                        keyboardType: TextInputType.number,
                        validator: (String value){
                          if(value.isEmpty)
                          {
                            return "Not Valid";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: "In Percentage",
                          border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                          )
                        ),
                      ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                        child:Row(
                          children: <Widget>[
                            Expanded(
                                child:TextFormField(
                                  controller: termController,
                                keyboardType: TextInputType.number,
                                validator: (String value){
                                    if(value.isEmpty)
                                    {
                                      return "Not Valid";
                                    }
                                  },
                                decoration: InputDecoration(
                                  labelText: "In Term",
                                  hintText: "In Years",
                                  border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0)
                                   )
                                  ),
                                )
                      ) ,
                      Container(width: 25.0,),
                      Expanded(
                        child: DropdownButton<String>(
                          items: currencies.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          value: selectedItem,
                          onChanged: (String newValueSelected){
                                onDropDownitemSelected(newValueSelected);
                          },
                        ),
                      )
                          ],
                        )
                      ),


                      Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 5.0,),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text("Calculate",textScaleFactor: 1.5,),
                                onPressed: (){
                                  setState(() {
                                    if(formKey.currentState.validate()){
                                    this.result=calculateInterest();
                                    }
                                  });

                                },
                              ),
                            ),

                            Container(width: 25.0,),


                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text("Reset",textScaleFactor: 1.5,),
                                onPressed: (){
                                  setState(() {
                                    reset();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(this.result),
                      )


                  ],
              ),
          ),
        )
        );
      }



      Widget getImageAsset()
      {
        AssetImage assetImage=AssetImage('images/user.png');
        Image image=Image(image: assetImage,width: 100.0,height: 100.0,);
        return Container(child: image,margin: EdgeInsets.all(30.0),);
      }

      void  onDropDownitemSelected(String newValueSelected){
          setState(() {
            this.selectedItem=newValueSelected;
          });
      }

      String calculateInterest(){
        double principal=double.parse( pricipalController.text);
        double rate=double.parse(rOIController.text);
        double term=double.parse(termController.text);
        double total=principal+(principal*rate*term)/100;
        String result="After $term years ,Total Amount is $total $selectedItem";
        return result;
      }

      void reset()
      {
        pricipalController.text="";
        rOIController.text="";
        termController.text="";
        result="";
        selectedItem=currencies[0];
      }
  }
  

