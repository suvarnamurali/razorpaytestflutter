import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'SUCCESS:${response.paymentId!}', toastLength: Toast.LENGTH_SHORT);
  }
 void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        // ignore: prefer_interpolation_to_compose_strings
        msg: 'ERROR:' + response.code.toString() + "-" + response.message!, toastLength: Toast.LENGTH_SHORT);
  }

void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'EXTERNAL_WALLET:${response.walletName!}', toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose(){
    super.dispose();
    _razorpay.clear();
  }

 // ignore: non_constant_identifier_names
 void OpenCheckout() async{

  var options = {
    'key': 'rzp_test_Nh2rAmd5XUIBCC',
    'Key Secret': 'sPISKhmDBLUNTmHS1Zd8QALZ',
    'amount':100,
    'name':'Baabte System Technologies',
    'description': 'full stack flutter development',
    'retry':{'enabled': true , 'max_count':1},
    'send_sms_hash':true,
    'prefill': {'contact': '8606326406','email':
    'content@baabte.com'},
    'external':{
      'wallets':['paytm']
    }
  };

  try{
    _razorpay.open(options);
  } catch (e){
    debugPrint('Error: e');
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Razorpay'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: OpenCheckout,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, //background color of button
                side: const BorderSide(width: 3), //border width and color
                elevation: 3, //elevation of button
                // shape: RoundedRectangleBorder( //to set border radius to button
                //     borderRadius: BorderRadius.circular(10)
                // ),
                padding:
                    const EdgeInsets.all(20) //content padding inside button
                ),
            child: const Text('Pay'),
          ),
        ));
  }
}
