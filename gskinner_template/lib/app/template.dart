import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gskinner_template/app/custom_widgets/sliding_panel.dart';

import 'model.dart';

class CardsTemplateDemo extends StatefulWidget {
  @override
  _CardsTemplateDemoState createState() => _CardsTemplateDemoState();
}

class _CardsTemplateDemoState extends State<CardsTemplateDemo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              ..._buildCards(
                size: constraints.biggest,
                isDesktop: constraints.maxWidth > 540,
              ),
              _buildFooter(),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildCards({Size size, bool isDesktop}) {
    var cards = loadCards(iconSize: isDesktop ? 250 : 180);

    List<Widget> cardWidgets = [];
    for (int i = 0; i < cards.length; i++) {
      cardWidgets.add(isDesktop
          ? _buildCardForDesktop(cards[i], size)
          : _buildCardForMobile(cards[i], size));
    }
    return cardWidgets;
  }

  Widget _buildCardForDesktop(CardModel card, Size size) {
    return SliverToBoxAdapter(
      child: Container(
        width: size.width,
        height: size.height,
        color: card.color,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 100, bottom: 150),
              child: card.icon,
            ),
            SlidingPanel(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 80, top: 60, bottom: 80, right: 80),
                    child: Container(
                      width: 520,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              card.title,
                              style: GoogleFonts.kronaOne(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            card.description,
                            style: GoogleFonts.raleway(
                              height: 1.5,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          if (card.buttonText != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Material(
                                color: Colors.transparent,
                                child: MaterialButton(
                                  height: 50,
                                  onPressed: () {
                                    print('${card.buttonText}');
                                  },
                                  splashColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    card.buttonText,
                                    style: GoogleFonts.aldrich(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForMobile(CardModel card, Size screenSize) {
    return SliverToBoxAdapter(
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: card.color,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 50, bottom: 100),
              child: card.icon,
            ),
            SlidingPanel(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, bottom: 20, right: 20),
                    child: Container(
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              card.title,
                              style: GoogleFonts.kronaOne(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            card.description,
                            style: GoogleFonts.raleway(
                              height: 1.2,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          if (card.buttonText != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Material(
                                color: Colors.transparent,
                                child: MaterialButton(
                                  height: 45,
                                  onPressed: () {
                                    print('${card.buttonText}');
                                  },
                                  splashColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    card.buttonText,
                                    style: GoogleFonts.aldrich(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return SliverToBoxAdapter(
      child: Container(
        height: 150,
        color: Colors.black,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "FOOTER",
          style: GoogleFonts.kronaOne(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
