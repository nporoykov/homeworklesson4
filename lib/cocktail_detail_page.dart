import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Общие комментарии: 
// 1. Назавния методов должны содержать в себе действие. т.е например не _styledAppBar, а _buildStyledAppBar
// 2. Из "Best practice". Все виджеты из material и cupertino. Берут свои стили из ThemeData автоматом. 
// Поэтому лучше определять их там.(Например цвет AppBar)
// 3. const Color(0xffFFFFFF), подобные переменные обычно выносятся в отдельных класс и задаются как статические
// static const black = const Color(0xffFFFFFF); - т.к есть название, то другой разработчик сможет прочитать и понять какой это цвет,
// иначе это magic переменная


class CocktailDetailPage extends StatelessWidget {
  const CocktailDetailPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _styledAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(cocktail.drinkThumbUrl),
            _briefPart(),
            _ingredientsPart(),
            _instructionPart(),
            _ratingPart()
          ],
        ),
      ),
    );
  }

  Widget _styledAppBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: null,
            icon: SvgPicture.asset('assets/images/icon_back.svg')),
        actions: [
          IconButton(
              onPressed: null,
              icon: SvgPicture.asset('assets/images/icon_out.svg'))
        ]);
  }

  Widget _briefPart() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      //  MARK: Если нужно переопределить только цвет, то лучше использовать 
      // color из Container
      decoration: BoxDecoration(
        color: Color(0xff1A1927),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
             //TODO: Обязательно использовать Flexible в этом месте.
              Text(
                cocktail.name,
              // MARK: Стили лучше выносить в ThemeData
                style: TextStyle(
                  fontFamily: 'SfProText',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xffFFFFFF),
                ),
              ),
              SvgPicture.asset('assets/images/icon_hart.svg')
            ],
           //MARK: Обычно принято сначала определять переменные свойствв
           // а ниже child, children, build, это нужно для удобства чтения.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
              // TODO: Обязательно использование Flexible в этом месте  
                Text(
                  cocktail.id,
               // MARK: Стили лучше выносить в ThemeData
                  style: TextStyle(
                    fontFamily: 'SfProText',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff848396),
                  ),
                ),
                // MARK: тут можно использовать const и убрать запятую для лучшего форматирования.
                SizedBox(
                  width: 10,
                )
              ],
           //MARK: Обычно принято сначала определять переменные свойствв
           // а ниже child, children, build, это нужно для удобства чтения.
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          _chipsContainer('Категория коктейля', cocktail.category.value),
          _chipsContainer('Тип коктейля', cocktail.cocktailType.value),
          _chipsContainer('Тип стекла', cocktail.glassType.value)
        ],
      ),
    );
  }

  Widget _chipsContainer(String titleText, String chipsText) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      // MARK: Обычно Flex не используют для решения таого рода задачь, либо Row либо Column
      // Flex используется если вам нужно динамически менять ориентацию.
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //MARK: Некорректное форматирование, параметры должн быть в столбец, по одному в строке.
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // TODO: Обязательно использование Flexible в этом месте  
            Text(
              titleText,
           // MARK: Стили лучше выносить в ThemeData
              style: TextStyle(
                fontFamily: 'SfProText',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: const Color(0xffEAEAEA),
              ),
            ),
         // MARK: тут можно использовать const и убрать запятую для лучшего форматирования.
            SizedBox(
              width: 10,
            )
          ]),
          Chip(
              backgroundColor: const Color(0xff15151C),
              label: Text(
                chipsText,
          // MARK: Стили лучше выносить в ThemeData
                style: TextStyle(
                  fontFamily: 'SfProText',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xffFFFFFF),
                ),
              ))
        ],
      ),
    );
  }

  Widget _ingredientsPart() {
    return Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 36, 24),
      //  MARK: Если нужно переопределить только цвет, то лучше использовать 
      // color из Container 
        decoration: BoxDecoration(
          color: const Color(0xff000000),
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('Ингридиенты:',
              // MARK: Стили лучше выносить в ThemeData
                  style: TextStyle(
                    fontFamily: 'SfProText',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(0xffB1AFC6),
                  )),
            ),
            ...cocktail.ingredients.map((e) => _ingredientsContainer(e)),
          ],
        ));
  }

  Widget _ingredientsContainer(IngredientDefinition ingredient) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         // TODO: Обязательно использование Flexible в этом месте  
          Text(
            ingredient.ingredientName,
         // MARK: Стили лучше выносить в ThemeData
            style: TextStyle(
              fontFamily: 'SfProText',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xffFFFFFF),
            ),
          ),
          Text(
            ingredient.measure,
         // MARK: Стили лучше выносить в ThemeData
            style: TextStyle(
              fontFamily: 'SfProText',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color(0xffFFFFFF),
            ),
          )
        ],
      ),
    );
  }

  Widget _instructionPart() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
    //  MARK: Если нужно переопределить только цвет, то лучше использовать 
      // color из Container 
        decoration: BoxDecoration(
          color: const Color(0xff201F2C),
        ),
       // MARK: Обычно Flex не используют для решения таого рода задачь, либо Row либо Column
      // Flex используется если вам нужно динамически менять ориентацию.
        child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 12),
                child: Text('Инструкция для приготовления',
                    //cocktail.instruction.toString()
                // MARK: Стили лучше выносить в ThemeData
                    style: TextStyle(
                      fontFamily: 'SfProText',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xffFFFFFF),
                    )),
              ),
              ..._instructionContainer(cocktail.instruction)
            ]));
  }

  List<Widget> _instructionContainer(String description) {
    List<String> data = description.split('\n');
    List<Widget> result = [];

    data.forEach((e) {
      result.add(Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [        
            Container(
                margin: const EdgeInsets.only(right: 8, top: 6),
                height: 4.0,
                width: 4.0,
                // MARK: new уже не используется
                decoration: new BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  shape: BoxShape.circle,
                )),
            Flexible(
              child: Text(
                e.replaceAll('- ', ''), 
                // MARK: Стили лучше выносить в ThemeData
                style: TextStyle(
                  fontFamily: 'SfProText',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            )
          ],
        ),
      ));
    });

    return result;
  }

  Widget _ratingPart() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      //  MARK: Если нужно переопределить только цвет, то лучше использовать 
      // color из Container 
      decoration: BoxDecoration(color: const Color(0xff1A1927)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // TODO: Обязательно использование Flexible в этом месте  
          _ratingContainer(true),
          _ratingContainer(true),
          _ratingContainer(true),
          _ratingContainer(false),
          _ratingContainer(false),
        ],
      ),
    );
  }

  Widget _ratingContainer(bool isPositive) {
   //MARK: можно переопределить margin у Container, тогда не нужно лишнее вложение в Padding,
   // читабельность лучше, а эффект тот же
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
      child: Container(
          height: 48.0,
          width: 48.0,
          decoration: new BoxDecoration(
            color: const Color(0xff2A293A),
            shape: BoxShape.circle,
          ),
          child: isPositive
              ? Image.asset('assets/images/Star_white.png')
              : Image.asset('assets/images/Star_black.png')),
    );
  }
}
