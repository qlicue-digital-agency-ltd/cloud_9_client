import 'package:flutter/material.dart';

class Service {
  final int id;
  final String image;
  final String title;
  final String body;
  final int categoryId;

  Service(
      {@required this.id,
      @required this.image,
      @required this.title,
      @required this.body,
      @required this.categoryId});
}

List<Service> serviceList = <Service>[
  Service(
      id: 1,
      image: 'assets/images/lisa.jpeg',
      title: 'SKIN TAGS, MOLES, WARTS, MILLIA, SPOTS, CHALE',
      body:
          'By Plasma fibroblast and Laser technology, instant removal, no downtime!',
      categoryId: 1),
  Service(
      id: 2,
      image: 'assets/images/lisa.jpeg',
      title: 'UNDER EYE BAGS, SUNKEN UNDER EYE, UNDER EYE DARKNESS',
      body:
          'These can be removed effectively by our various options like Dermal filler, Plasma fibroblast, Laser',
      categoryId: 1),
  Service(
      id: 3,
      image: 'assets/images/lisa.jpeg',
      title: 'WRINKLES AND FINE LINES REMOVAL',
      body:
          'Anti aging: Achieved by using high technology methods such as Plasma fibroblast, Microneedling collagen induction therapy, Dermal filler, Botox, Laser',
      categoryId: 1),
  Service(
      id: 4,
      image: 'assets/images/lisa.jpeg',
      title: 'MELASMA, HYPERPIGMENTATION, DARKNESS',
      body: 'We have very effective treatments for these problems',
      categoryId: 1),
  Service(
      id: 5,
      image: 'assets/images/lisa.jpeg',
      title: 'STRETCH MARKS',
      body:
          'We have effective ways to remove stretch marks! Laser, Plasma fibroblast, Microneedling',
      categoryId: 1),
  Service(
      id: 6,
      image: 'assets/images/lisa.jpeg',
      title:
          'SCARS REMOVAL: ACNE SCARS, CHICKEN POX SCARS, CUT WOUND SCARS, OTHER SCARS',
      body: 'This can be achieved by Laser, Plasma fibroblast, Microneedling,',
      categoryId: 1),
  Service(
      id: 7,
      image: 'assets/images/lisa.jpeg',
      title: 'MICROBLADING',
      body:
          'Eyebrows microblading Is a way of semi-permanent make-up, where through manual process of inserting pigment into the upper layers of skin we create the desired fullness and shape of the eyebrows. The effects last up to 12 months after which the pigment fades leaving the skin',
      categoryId: 1),
  Service(
      id: 4,
      image: 'assets/images/lisa.jpeg',
      title: 'SKIN REJUVENATION',
      body:
          'Vampire facial: for a glowing, brightening and more youthful look, Microneedling to inject PRP, Stem cell, Vitamin C and Collagen. This is Kim Kardashian’s favorite facial rejuvenation procedure',
      categoryId: 1),
];
