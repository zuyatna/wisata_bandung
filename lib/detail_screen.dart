import 'package:flutter/material.dart';
import 'package:wisata_bandung/model/tourism_place.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.place, required this.index}) : super(key: key);

  final TourismPlace place;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 800) {
        return DetailMobilePage(place: place, index: index);
      } else {
        return DetailWebPage(place: place, index: index,);
      }
    });
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: IconButton(onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            )
        ),
      ),
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  const DetailMobilePage({Key? key, required this.place, required this.index}) : super(key: key);

  final TourismPlace place;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(tag: 'place$index', child: Image.asset(place.imageAsset)),
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white,),
                              onPressed: () { Navigator.pop(context); },
                            ),
                          ),
                          const FavoriteButton()
                        ],
                      )
                  ),
                ),
              ],
            ), // Image_Background
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ), // Title
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      const SizedBox(height: 8.0),
                      Text(place.openDays, style: informationTextStyle,)
                    ],
                  ), // Calendar
                  Column(
                    children: <Widget>[
                      const Icon(Icons.access_time_outlined),
                      const SizedBox(height: 8.0),
                      Text(place.openTime, style: informationTextStyle,)
                    ],
                  ), // Access_Time
                  Column(
                    children: <Widget>[
                      const Icon(Icons.attach_money_rounded),
                      const SizedBox(height: 8.0),
                      Text(place.ticketPrice, style: informationTextStyle,)
                    ],
                  ), // Money
                ],
              ),
            ), // Icon_Description
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ), // Description
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  const DetailWebPage({Key? key, required this.place, required this.index}) : super(key: key);

  final TourismPlace place;
  final int index;

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wisata Bandung',
                  style: TextStyle(
                    fontFamily: 'Staatliches',
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 32,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(widget.place.imageAsset),
                        ),
                        const SizedBox(height: 16,),
                        Scrollbar(thumbVisibility: true, controller: _scrollController, child: Container(
                          height: 150,
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ListView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            children: widget.place.imageUrls.map((url) {
                              return Padding(padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(url),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                        ),
                      ],
                    )),
                    const SizedBox(width: 32,),
                    Expanded(child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              widget.place.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Staatliches',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(width: 8.0,),
                                    Text(
                                      widget.place.openDays,
                                      style: informationTextStyle,
                                    )
                                  ],
                                ),
                                const FavoriteButton()
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.access_time),
                                const SizedBox(width: 8.0,),
                                Text(
                                  widget.place.openTime,
                                  style: informationTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0,),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.monetization_on),
                                const SizedBox(width: 8.0,),
                                Text(
                                  widget.place.ticketPrice,
                                  style: informationTextStyle,
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                widget.place.description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Oxygen',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
