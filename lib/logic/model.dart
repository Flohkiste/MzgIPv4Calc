class Model {
  var ipAdress = [192, 168, 10, 1];
  var subnetMask = [255, 255, 255, 0];

  static final Model _singelton = Model._internal();

  factory Model() {
    return _singelton;
  }

  Model._internal();

  List getNetworkID() {
    var networkIP = [];
    for (int x = 0; x < ipAdress.length; x++) {
      networkIP.add(ipAdress[x] & subnetMask[x]);
    }
    return networkIP;
  }

  List getFirstIP() {
    var firstIP = getNetworkID();
    firstIP.last++;
    return firstIP;
  }

  List getDif() {
    var dif = [];
    for (int x = 0; x < ipAdress.length; x++) {
      dif.add(255 - subnetMask[x]);
    }
    return dif;
  }

  List getBroadcast() {
    var broadcast = getNetworkID();
    for (int x = 0; x < ipAdress.length; x++) {
      broadcast[x] += getDif()[x];
    }
    return broadcast;
  }

  List getLastIP() {
    var lastIP = getBroadcast();
    lastIP.last--;
    return lastIP;
  }
}
