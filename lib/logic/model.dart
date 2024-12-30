import 'package:flutter/cupertino.dart';

var map = {
  1: 128,
  2: 192,
  3: 224,
  4: 240,
  5: 248,
  6: 252,
  7: 254,
  8: 255,
};

class Model extends ChangeNotifier {
  var ipAdress = [192, 168, 10, 1];
  var subnetMask = [255, 255, 255, 0];
  int cidr = 23;

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

  void setSubnetMaskFromCIDR() {
    String bin = "";
    for (int x = 0; x < cidr; x++) {
      bin += "1";
    }

    for (int x = cidr; x < 32; x++) {
      bin += "0";
    }

    for (int x = 0; x < 4; x++) {
      String octetString = bin.substring(x * 8, (x + 1) * 8);
      subnetMask[x] = int.parse(octetString, radix: 2);
    }
    notifyListeners();
  }

  void setCIDRFromSubnetMask() {
    String bin = "";
    for (int x = 0; x < 4; x++) {
      bin += subnetMask[x].toRadixString(2);
    }
    int x = "1".allMatches(bin).length;

    cidr = x;
  }
}
