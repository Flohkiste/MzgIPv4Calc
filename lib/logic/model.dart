class Model {
  var ipAdress = [-1, -1, -1, -1];
  var subnetMask = <int>{-1, -1, -1, -1};

  static final Model _singelton = Model._internal();

  factory Model() {
    return _singelton;
  }

  Model._internal();


}
