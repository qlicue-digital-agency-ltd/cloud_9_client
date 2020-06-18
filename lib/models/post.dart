import 'package:flutter/material.dart';

class Post {
  final int id;
  final String image;
  final String title;
  final String body;
  final int likeCount;

  Post(
      {@required this.id,
      @required this.image,
      @required this.title,
      @required this.body,
      @required this.likeCount});
}

List<Post> postList = <Post>[
  Post(
      id: 1,
      image: 'assets/images/3.jpg',
      title: 'SKIN TAGS, MOLES, WARTS, MILLIA, SPOTS, CHALE',
      body:
          'By Plasma fibroblast and Laser technology, instant removal, no downtime!',
      likeCount: 1),
  Post(
      id: 2,
      image: 'assets/images/4.jpg',
      title: 'UNDER EYE BAGS, SUNKEN UNDER EYE, UNDER EYE DARKNESS',
      body:
          'These can be removed effectively by our various options like Dermal filler, Plasma fibroblast, Laser',
      likeCount: 1),
  Post(
      id: 3,
      image: 'assets/images/2.jpg',
      title: 'WRINKLES AND FINE LINES REMOVAL',
      body:
          'Anti aging: Achieved by using high technology methods such as Plasma fibroblast, Microneedling collagen induction therapy, Dermal filler, Botox, Laser',
      likeCount: 1),
  Post(
      id: 4,
      image: 'assets/images/3.jpg',
      title: 'MELASMA, HYPERPIGMENTATION, DARKNESS',
      body: 'We have very effective treatments for these problems',
      likeCount: 1),
  Post(
      id: 5,
      image: 'assets/images/1.jpg',
      title: 'STRETCH MARKS',
      body:
          'We have effective ways to remove stretch marks! Laser, Plasma fibroblast, Microneedling',
      likeCount: 1),
  Post(
      id: 6,
      image: 'assets/images/0.jpg',
      title:
          'SCARS REMOVAL: ACNE SCARS, CHICKEN POX SCARS, CUT WOUND SCARS, OTHER SCARS',
      body: 'This can be achieved by Laser, Plasma fibroblast, Microneedling,',
      likeCount: 1),
  Post(
      id: 7,
      image: 'assets/images/6.jpg',
      title: 'MICROBLADING',
      body:
          'Eyebrows microblading Is a way of semi-permanent make-up, where through manual process of inserting pigment into the upper layers of skin we create the desired fullness and shape of the eyebrows. The effects last up to 12 months after which the pigment fades leaving the skin',
      likeCount: 1),
  Post(
      id: 4,
      image: 'assets/images/7.jpg',
      title: 'SKIN REJUVENATION',
      body:
          'Vampire facial: for a glowing, brightening and more youthful look, Microneedling to inject PRP, Stem cell, Vitamin C and Collagen. This is Kim Kardashian’s favorite facial rejuvenation procedure',
      likeCount: 1),
];
