import 'package:flutter/material.dart';
import 'package:nike_shoes_app/product.dart';
import 'package:nike_shoes_app/repository.dart';

class DetailPage extends StatefulWidget{
  const DetailPage(this.product, {Key? key}) : super(key: key);
  final Product product;
  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  final _bgColor = const Color(0xff1d1f21);
  late Product _product;
  late double _decoratorRadius = 0;
 final double _pagePadding =15;
 late  int _activeCarouselIndex =0;
 late final List<Product> _productsInGroup = [];
  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _productsInGroup.addAll(Repository().productsInGroup(_product.group));
    //start animation immediately
    Future.delayed(const Duration(milliseconds: 0)).then((value) => setState((){
      _decoratorRadius = 350;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     backgroundColor: _bgColor,
      body: Stack(
        children: [
          decorator(),
          content(),
        ],
      ),
    );
  }

  //content widget
  Widget content(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //action bar
        actionBar(),
        //product photos and back word
        photosContainer(),
        //shoes carousel indicators
        carouselIndicators(),
        //info
        infoContainer(),
        //size container
        sizeContainer(),
        //color and buy btn container
        colorAndBuyBtnContainer(),
      ],
    );
  }

  //carouselIndicator
  carouselIndicators(){
    return Container(
      width:MediaQuery.of(context).size.width,
     alignment: Alignment.center,
     margin: EdgeInsets.only(top: _pagePadding*1.5, left: _pagePadding),
   // color: Colors.white,
    child: Container(
      padding: EdgeInsets.only(left: _pagePadding),
       width: 200,
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productsInGroup.length,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _activeCarouselIndex == index? _product.primaryColor.withRed(165): Colors.white,
            ),
          );
        },
      ),
    ),);
  }

  //color and buy btn container
  Widget colorAndBuyBtnContainer(){
    return Padding(padding: EdgeInsets.all(_pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //colors container
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text("COLOR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,letterSpacing: -1, color: Colors.white70),),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(3.5),
                        width: 15,
                        height: 15,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: _product.primaryColor,
                        ),
                      ),
                    ),

                    Container(
                     margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),

                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff0c8080),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //buy button
         InkWell(
           onTap: (){},
           child:  Container(
             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
             decoration: BoxDecoration(
                 color: _product.primaryColor,
                 borderRadius: const BorderRadius.all(Radius.circular(8))
             ),
             child: Text("Buy".toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
           ),
         ),
        ],
      ),
    );
  }

  //size container
  sizeContainer(){
    return Padding(
        padding: EdgeInsets.all(_pagePadding ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text("SIZE", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20),),
          Padding(
          padding:const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //size containers,
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _product.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("7", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("8", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("9", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("10", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)
              ),
            ],
          ),),
        ],
      ),
    );
  }

  //more info container
  Widget infoContainer(){
    return Container(
      margin: EdgeInsets.only(top: _pagePadding),
      padding: EdgeInsets.all(_pagePadding),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          const Text("NIKE AIR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,letterSpacing: -1, color: Colors.white70),),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("AIR JORDAN 1 MID SE GC", maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,letterSpacing: -2, color: Colors.white),),
                Text("\$200", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,letterSpacing: -2, color: Colors.white),),
              ],
            ),
          ),
          //stars
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star, color: _product.primaryColor, size: 18,),
              Icon(Icons.star, color: _product.primaryColor, size: 18,),
              Icon(Icons.star, color: _product.primaryColor, size: 18,),
              Icon(Icons.star, color: _product.primaryColor, size: 18,),
              const Icon(Icons.star, color: Colors.white, size: 18,),
            ],
          ),
        ],
      ),
    );
  }

//products photos container
 Widget photosContainer(){
   return Container(
     padding: EdgeInsets.all(_pagePadding),
     height: MediaQuery.of(context).size.height*.3,
     child: Stack(
       children:  [
          const Align(alignment: Alignment.center,
         child: Text("NIKE AIR", maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 85, fontWeight: FontWeight.bold),),
         ),

         PageView.builder(
           itemCount: _productsInGroup.length,
           //controller: _pageController,
           onPageChanged: (int index) {
             setState(() {
               _activeCarouselIndex = index;
              // _activeProduct = repository.firstProductInGroup(productGroups.elementAt(_activeProductGroupIndex));
             });
           },
           itemBuilder: (context, index) {
             return photoItem(index);
           },
         ),

       ],
     ),
   );
  }

  photoItem(int index){
    return Hero(
      tag: "tag",
      child:  Image.asset(
        _productsInGroup.elementAt(index).url,
        fit: BoxFit.fitHeight,
      ),
    );
  }



//tool bar top
  Widget actionBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26), //status bar space
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //back btn
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          //like btn
          InkWell(
            onTap: (){}, //liked
            child: const Icon(Icons.favorite, color: Colors.white, size: 30,),
          ),
        ],
      ),
    );
  }
  //decoration box
  Widget decorator() {
return Align(
  alignment: Alignment.topRight,
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeIn,
    width: MediaQuery.of(context).size.width*.7,
    height: MediaQuery.of(context).size.height*.6,
    decoration: BoxDecoration(
      color: _product.primaryColor,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(_decoratorRadius), bottomLeft: Radius.circular(_decoratorRadius),),
    ),
  ),
 );
}

}
