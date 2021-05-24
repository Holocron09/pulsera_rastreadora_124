import 'dart:io';

class WiFiSocketSender {
  WiFiSocketSender._privateConstructor();
  static final WiFiSocketSender _instance =
      WiFiSocketSender._privateConstructor();

  factory WiFiSocketSender() {
    return _instance;
  }

  Socket channel;
  //String _name, _uid, _phone, _ssid, _pswd, _ePhone;

  /*get channel => _channel;
  get name => _name;
  get uid => _uid;
  get phone => _phone;
  get sSID => _ssid;
  get pSWD => _pswd;
  get ePhone => _ePhone;*/

  //set channel(Socket socket) => _channel = socket;

  set name(String name) {
    channel.write('name: $name;\n');
    print(name);
  }

  set uid(String uid) {
    channel.write('uid: $uid;\n');
    print(uid);
  }

  void data() {
    channel.write('data: 0;\n');
    print('data showed');
  }

  void show() {
    channel.write('show: 0;\n');
  }

  void reboot() {
    channel.write('reboot: 0;\n');
  }

  void fReset() {
    channel.write('Freset: 1;\n');
    channel.write('reboot: 0;\n');
  }

  void saveToFile() {
    channel.write('status: 0;\n');
  }

  void printInfo() {
    channel.write('status: 1;\n');
  }

//todo store this locally
  set phoneNumber(String phone) {
    channel.write('phone: $phone;\n');
    print(phone);
  }

  set ePhoneNumber(String ePhone) {
    channel.write('ephone: $ePhone;\n');
    print(ePhone);
  }

  set sSID(String wSSID) {
    channel.write('SSID: $wSSID;\n');
    print(wSSID);
  }

  set pSWD(String pass) {
    channel.write('PSWD: $pass;\n');
    print(pass);
  }
}
