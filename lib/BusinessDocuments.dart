import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constants.dart' as Constant;
import 'Result.dart';
import 'Utils.dart';

class BusinessDocuments extends StatefulWidget {
  final String title;
  final Result data;
  final Widget logo;
  BusinessDocuments(
      {Key key, this.title, this.data, this.logo}) : super(key: key);

  @override
  _BusinessDocumentsState createState() => _BusinessDocumentsState(data);
}

class _BusinessDocumentsState extends State<BusinessDocuments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> path = Map();
  Map<String, bool> requiredDocs = {
    Constant.RequiredDocs.CNIC: false,
    Constant.RequiredDocs.M_CERTIFICATE: false,
    Constant.RequiredDocs.NTN: false,
    Constant.RequiredDocs.R_CERTIFICATE: false,
    Constant.RequiredDocs.UTILITY_BILL: false
  };

  Map<String, String> rd = {
    Constant.RequiredDocs.CNIC: Constant.RequiredDocs.C,
    Constant.RequiredDocs.M_CERTIFICATE: Constant.RequiredDocs.MC,
    Constant.RequiredDocs.NTN: Constant.RequiredDocs.NT,
    Constant.RequiredDocs.R_CERTIFICATE: Constant.RequiredDocs.RC,
    Constant.RequiredDocs.UTILITY_BILL: Constant.RequiredDocs.UB
  };

  Future<void> uploadImage(FileType type, String pathOf) async {
    await FilePicker.getFilePath(type: type)
      .then((value) {
        if (value != null) {
          setState(() {
            requiredDocs[pathOf] = true;
            path[pathOf] = value;
          });
        }
      });
  }

  Result rawResult;

  _BusinessDocumentsState(Result object) {
    this.rawResult = object;
  }

  void _removePicture(String item) {
    setState(() {
      path.remove(item);
      requiredDocs[item] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        leading: widget.logo,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: Constant.Layout.left,
            right: Constant.Layout.right),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new SingleChildScrollView(
                  child: new Form(
                    key: _formKey,
                    child: new Column(
                      children: [
                        // Upload NTN
                        new Padding(
                          padding: const EdgeInsets.only(top: Constant.Layout.textViewTop),
                          child: new GestureDetector(
                            onTap: () {
                              uploadImage(
                                FileType.image,
                                Constant.RequiredDocs.NTN);
                            },
                            child: new DottedBorder(
                              color: Colors.grey,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              strokeCap: StrokeCap.round,
                              padding: const EdgeInsets.fromLTRB(
                                Constant.Layout.dp5, Constant.Layout.dp5,
                                Constant.Layout.dp5, Constant.Layout.dp5
                              ),
                              child: new Container(
                                height: Constant.Layout.uploadLogoH,
                                child: new Row(
                                  children: [
                                    new Container(
                                      width: Constant.Layout.uploadLogoW,
                                      height: MediaQuery.of(context).size.height,
                                      child: new Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.file(
                                                new File((path == null ? ""
                                                  : (path.containsKey(Constant
                                                    .RequiredDocs.NTN) ? path[
                                                      Constant.RequiredDocs.NTN]
                                                    : ""))),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Visibility(
                                              visible: requiredDocs[Constant.RequiredDocs.NTN],
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _removePicture(Constant.RequiredDocs.NTN);
                                                  },
                                                  child: Icon(Icons.cancel_outlined),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Visibility(
                                                  visible: !requiredDocs[Constant.RequiredDocs.NTN],
                                                  child: new Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.cloud_upload,
                                                        size: 50.0,
                                                      ),
                                                      Text(Constant.General.UPLOAD)
                                                    ],
                                                  )
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .only(top: 5.0, left: 5.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Constant.RequiredDocs.btnNTN,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                  left: 5.0
                                              ),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "National Tax Number",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 12.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ),
                          )
                        ),
                        // Upload CNIC
                        new Padding(
                          padding: const EdgeInsets.only(top: Constant.Layout.textViewTop),
                          child: new GestureDetector(
                            onTap: () {
                              uploadImage(
                                  FileType.image,
                                  Constant.RequiredDocs.CNIC
                              );
                            },
                            child: new DottedBorder(
                              color: Colors.grey,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              strokeCap: StrokeCap.round,
                              padding: const EdgeInsets.fromLTRB(
                                  Constant.Layout.dp5, Constant.Layout.dp5,
                                  Constant.Layout.dp5, Constant.Layout.dp5
                              ),
                              child: new Container(
                                height: Constant.Layout.uploadLogoH,
                                child: new Row(
                                  children: [
                                    new Container(
                                      width: Constant.Layout.uploadLogoW,
                                      height: MediaQuery.of(context).size.height,
                                      child: new Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.file(
                                                new File((path == null ? "" :
                                                (path.containsKey(
                                                    Constant.RequiredDocs.CNIC
                                                ) ? path[Constant.RequiredDocs.CNIC] : "")
                                                )),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Visibility(
                                              visible: requiredDocs[Constant.RequiredDocs.CNIC],
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _removePicture(Constant.RequiredDocs.CNIC);
                                                  },
                                                  child: Icon(Icons.cancel_outlined),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Visibility(
                                                  visible: !requiredDocs[Constant.RequiredDocs.CNIC],
                                                  child: new Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.cloud_upload,
                                                        size: 50.0,
                                                      ),
                                                      Text(Constant.General.UPLOAD)
                                                    ],
                                                  )
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .only(top: 5.0, left: 5.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Constant.RequiredDocs.btnCNIC,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                  left: 5.0
                                              ),
                                              child: new Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Constant.RequiredDocs.CNIC,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 12.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ),
                          )
                        ),
                        // Upload Utility bill
                        new Padding(
                          padding: const EdgeInsets
                              .only(top: Constant.Layout.textViewTop),
                          child: new GestureDetector(
                            onTap: () {
                              uploadImage(
                                  FileType.image,
                                  Constant.RequiredDocs.UTILITY_BILL
                              );
                            },
                            child: new DottedBorder(
                              color: Colors.grey,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              strokeCap: StrokeCap.round,
                              padding: const EdgeInsets.fromLTRB(
                                  Constant.Layout.dp5, Constant.Layout.dp5,
                                  Constant.Layout.dp5, Constant.Layout.dp5
                              ),
                              child: new Container(
                                height: Constant.Layout.uploadLogoH,
                                child: new Row(
                                  children: [
                                    new Container(
                                      width: Constant.Layout.uploadLogoW,
                                      height: MediaQuery.of(context).size.height,
                                      child: new Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.file(
                                                new File((path == null ? "" :
                                                (path.containsKey(
                                                    Constant.RequiredDocs.UTILITY_BILL
                                                ) ? path[Constant.RequiredDocs.UTILITY_BILL] : "")
                                                )),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Visibility(
                                              visible: requiredDocs[Constant.RequiredDocs.UTILITY_BILL],
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _removePicture(Constant.RequiredDocs.UTILITY_BILL);
                                                  },
                                                  child: Icon(Icons.cancel_outlined),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: Visibility(
                                                    visible: !requiredDocs[Constant.RequiredDocs.UTILITY_BILL],
                                                    child: new Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.cloud_upload,
                                                          size: 50.0,
                                                        ),
                                                        Text(Constant.General.UPLOAD)
                                                      ],
                                                    )
                                                )
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(top: 5.0, left: 5.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                Constant.RequiredDocs.btnUTILITY_BILL,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 5.0
                                            ),
                                            child: Text(
                                              Constant.RequiredDocs.UTILITY_BILL,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 12.0
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              )
                            ),
                          )
                        ),
                        // Upload Registration certificate
                        new Padding(
                            padding: const EdgeInsets
                                .only(top: Constant.Layout.textViewTop),
                            child: new GestureDetector(
                              onTap: () {
                                uploadImage(
                                    FileType.image,
                                    Constant.RequiredDocs.R_CERTIFICATE
                                );
                              },
                              child: new DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 1,
                                dashPattern: [6, 3],
                                strokeCap: StrokeCap.round,
                                padding: const EdgeInsets.fromLTRB(
                                    Constant.Layout.dp5, Constant.Layout.dp5,
                                    Constant.Layout.dp5, Constant.Layout.dp5
                                ),
                                child: new Container(
                                  height: Constant.Layout.uploadLogoH,
                                  child: new Row(
                                    children: [
                                      new Container(
                                        width: Constant.Layout.uploadLogoW,
                                        height: MediaQuery.of(context).size.height,
                                        child: new Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Image.file(
                                                  new File((path == null ? "" :
                                                  (path.containsKey(
                                                      Constant.RequiredDocs.R_CERTIFICATE
                                                  ) ? path[Constant.RequiredDocs.R_CERTIFICATE] : "")
                                                  )),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Visibility(
                                                visible: requiredDocs[Constant.RequiredDocs.R_CERTIFICATE],
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _removePicture(Constant.RequiredDocs.R_CERTIFICATE);
                                                    },
                                                    child: Icon(Icons.cancel_outlined),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Opacity(
                                                  opacity: 0.5,
                                                  child: Visibility(
                                                    visible: !requiredDocs[Constant.RequiredDocs.R_CERTIFICATE],
                                                    child: new Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.cloud_upload,
                                                          size: 50.0,
                                                        ),
                                                        Text(Constant.General.UPLOAD)
                                                      ],
                                                    )
                                                  )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(top: 5.0, left: 5.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    Constant.RequiredDocs.btnR_CERTIFICATE,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17.0
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0,
                                                    left: 5.0
                                                ),
                                                child: Text(
                                                  Constant.RequiredDocs.R_CERTIFICATE,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 12.0
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            )
                        ),
                        // Upload Account Maintenance certificate
                        new Padding(
                            padding: const EdgeInsets
                                .only(top: Constant.Layout.textViewTop),
                            child: new GestureDetector(
                              onTap: () {
                                uploadImage(
                                    FileType.image,
                                    Constant.RequiredDocs.M_CERTIFICATE
                                );
                              },
                              child: new DottedBorder(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                  dashPattern: [6, 3],
                                  strokeCap: StrokeCap.round,
                                  padding: const EdgeInsets.fromLTRB(
                                      Constant.Layout.dp5, Constant.Layout.dp5,
                                      Constant.Layout.dp5, Constant.Layout.dp5
                                  ),
                                  child: new Container(
                                    height: Constant.Layout.uploadLogoH,
                                    child: new Row(
                                      children: [
                                        new Container(
                                          width: Constant.Layout.uploadLogoW,
                                          height: MediaQuery.of(context).size.height,
                                          child: new Card(
                                            elevation: 0,
                                            color: Colors.transparent,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Image.file(
                                                    new File((path == null ? "" :
                                                    (path.containsKey(
                                                        Constant.RequiredDocs.M_CERTIFICATE
                                                    ) ? path[Constant.RequiredDocs.M_CERTIFICATE] : "")
                                                    )),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: requiredDocs[Constant.RequiredDocs.M_CERTIFICATE],
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _removePicture(Constant.RequiredDocs.M_CERTIFICATE);
                                                      },
                                                      child: Icon(Icons.cancel_outlined),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Opacity(
                                                    opacity: 0.5,
                                                    child: Visibility(
                                                      visible: !requiredDocs[Constant.RequiredDocs.M_CERTIFICATE],
                                                      child: new Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.cloud_upload,
                                                            size: 50.0,
                                                          ),
                                                          Text(Constant.General.UPLOAD)
                                                        ],
                                                      )
                                                    )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(top: 5.0, left: 5.0),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Constant.RequiredDocs.btnM_CERTIFICATE,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 17.0
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5.0,
                                                      left: 5.0
                                                  ),
                                                  child: Text(
                                                    Constant.RequiredDocs.M_CERTIFICATE,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 12.0
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ),
              new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Container(
                          width: Constant.Layout.dp100,
                          height: Constant.Layout.dp50,
                          child: new Image.asset("assets/images/foree_logo.png")
                      ),
                      new ElevatedButton(
                        onPressed: () {
                          if (path.length == 5) {
                            Map<String, String> data = Map();
                            for (var val in path.entries)
                              data[val.key] = Utilities.getImageBase64(val.value);
                            /*rawResult.setBusinessDocument(
                                new BusinessDocument(
                                  data[Constant.RequiredDocs.cnic],
                                  data[Constant.RequiredDocs.mc],
                                  data[Constant.RequiredDocs.ntn],
                                  data[Constant.RequiredDocs.rc],
                                  data[Constant.RequiredDocs.ub]
                                )
                            );*/
                            Constant.SharedPref.save("ok", rawResult.toJson());
                          } else {
                            String da = "";
                            for (var val in requiredDocs.entries) {
                              if (!val.value) {
                                if (da.isEmpty)
                                  da = da + rd[val.key];
                                else
                                  da = da + ", " + rd[val.key];
                              }
                            }
                            if (da.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Text(
                                        "Please upload all the required documents: " + da
                                    ),
                                  ));
                            } else {
                              // Navigator.pop(context, "Ok the result is here");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Text(
                                        "Your form is submitted"
                                    ),
                                  ));
                            }
                          }
                        },
                        child: Text("Submit"),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      )
    );
  }

}