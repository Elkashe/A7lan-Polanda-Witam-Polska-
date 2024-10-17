class OnBoarding{
  String image;
  String des;
  String title;

  OnBoarding({required this.image, required this.des, required this.title});

}

List <OnBoarding> onboard =[
  OnBoarding(image: 'assets/images/krak9.jpg', des: 'User Privacy',title: "we don't sell your information"),
  OnBoarding(image: 'assets/images/krak7.jpg', des: 'Hotels & Tours',title:"Trusted Partner's"),
  OnBoarding(image: 'assets/images/krakowR.jpg', des: 'Login To see Best Prices', title:"Members Can Save Up To 70%" ),
];
