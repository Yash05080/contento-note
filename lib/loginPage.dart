import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage>
    with SingleTickerProviderStateMixin {
  var emailText = TextEditingController();
  var passKey = TextEditingController();
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  var result = "";
  var UEmail = "";
  var UPass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Login"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: const [
                          Color.fromARGB(255, 255, 0, 0),
                          Color.fromARGB(255, 0, 0, 0),
                        ],
                        begin: _topAlignmentAnimation.value,
                        end: _bottomAlignmentAnimation.value,
                      )),
                      child: Container(
                        height: 200,
                        width: 200,
                      ),
                    );
                  }),
              Container(
                height: 50,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 3)),
                      suffixText: "username",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {},
                      ),
                    ),
                  )),
              Container(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: passKey,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 3)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.black12, width: 2)),
                    suffixText: "password",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    String uEmail = emailText.text.toString();
                    String uPass = passKey.text;
                    print(" Email: $uEmail , pass: $uPass");
                    setState(() {
                      UEmail = uEmail;
                      UPass = uPass;
                    });

                    if (UEmail != "yash05080" || UPass != "frosthack") {
                      setState(() {
                        result = "INCORRECT USER ID OR PASSWORD";
                      });
                    }

                    // push to the home page
                    else if (UEmail == "yash05080" && UPass == "frosthack") {
                      setState(() {
                        result = "login successful";
                      });
                    } else {
                      setState(() {
                        result = "enter the fields";
                      });
                    }
                    ;
                  },
                  child: Text("login")),
              SizedBox(height: 20.0),
              Text(
                "$result",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
