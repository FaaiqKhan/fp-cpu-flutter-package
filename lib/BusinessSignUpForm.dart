import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BusinessDocuments.dart';
import 'Result.dart';
import 'Constants.dart' as Constant;

class BusinessSignUpForm extends StatefulWidget {
  final String title;
  final Result data;
  final String fieldsData;
  final String apiKey;
  BusinessSignUpForm(
      {Key key, @required this.apiKey, this.title, this.data, this.fieldsData})
      : super(key: key);

  @override
  _BusinessSignUpFormState createState() => _BusinessSignUpFormState(apiKey, data, fieldsData);
}

class _BusinessSignUpFormState extends State<BusinessSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  Widget logo;
  String date;
  String businessLegalName, businessName;
  String registeredNumber, mobileNumber, emailAddress;
  String registeredAddress, physicalAddress, officialWebsite;
  String legalEntity, legalEntityOther;
  String ntnCnicNumber;
  String authorizedSignatoryName, authorizedSignatoryCnic;
  String businessCategory, businessCategoryOther, officePremises;
  String yearsAtCurrentLocation, yearsAtCurrentBusiness;
  String expectedMonthlyTurnOver;
  String bankName, branchName, accountTitle, branchCode, accountNumber, iBan;
  String director1Name, director2Name, director3Name, director4Name;
  String director1Cnic, director2Cnic, director3Cnic, director4Cnic;
  String logoPath = "";
  Result rawResult;
  bool hasPartners = false;
  bool showLogoUploadIcon = true;
  bool showPartnersFields = false;
  bool isLegalEntityOtherFieldVisible = false;
  bool isBusinessCategoryOtherFieldVisible = false;

  _BusinessSignUpFormState(String apiKey, Result obj, String fieldsData) {
    rawResult = obj;
    if (fieldsData.isNotEmpty) {
      Map<String, dynamic> val = jsonDecode(fieldsData);
      businessName = val[Constant.FieldKeys.BUSINESS_NAME];
      ntnCnicNumber = val[Constant.FieldKeys.CNIC];
      mobileNumber = val[Constant.FieldKeys.MOBILE_NUMBER];
      String tempLogo = val[Constant.FieldKeys.LOGO];
      if (tempLogo.isNotEmpty)
        logo = Image.asset(tempLogo);
    }
  }

  Future<void> uploadImage(FileType type) async {
    await FilePicker.getFilePath(type: type)
        .then((value) {
      if (value != null) {
        setState(() {
          logoPath = value;
          showLogoUploadIcon = false;
        });
      } else {
        setState(() {
          showLogoUploadIcon = false;
        });
      }
    });
  }

  void _removeLogo() {
    setState(() {
      showLogoUploadIcon = true;
      logoPath = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.apiKey == null || widget.apiKey.isEmpty) {
        throw Exception(Constant.General.API_KEY_REQUIRED);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: logo,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: Constant.Layout.left,
              right: Constant.Layout.right),
          child: Container(
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new SingleChildScrollView(
                    child: new Form(
                      key: _formKey,
                      child: new Column(
                        children: [
                          // Business logo
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: new GestureDetector(
                                  onTap: () { uploadImage(FileType.image); },
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
                                                    new File(logoPath),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: logoPath.isNotEmpty,
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _removeLogo();
                                                      },
                                                      child: Icon(Icons.cancel_outlined),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Opacity(
                                                      opacity: 0.5,
                                                      child: Visibility(
                                                          visible: !logoPath.isNotEmpty,
                                                          child: new Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Icon(Icons.cloud_upload,
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
                                                      .only(top: Constant.Layout.dp5,
                                                      left: Constant.Layout.textViewTop),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Constant.RequiredDocs.logoText,
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
                                                      top: Constant.Layout.dp5,
                                                      left: Constant.Layout.textViewTop
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Constant.RequiredDocs.logoDescription,
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
                              )
                          ),
                          // Date
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: Constant.FormLabels.DATE,
                                border: const OutlineInputBorder(),
                                counterText: ""
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return Constant.ErrorFields.MANDATORY;
                                else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                  return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                else if (val.length > Constant.LengthLimit.MAX_LENGTH_200)
                                  return Constant.ErrorFields.MAX_LENGTH_ERROR_200;
                                else return null;
                              },
                              initialValue: date,
                              keyboardType: TextInputType.datetime,
                              onChanged: (val) => {
                                date = val
                              },
                              maxLength: 10,
                              maxLengthEnforced: true,
                            ),
                          ),
                          // Business legal name
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels.BUSINESS_LEGAL_NAME
                                ),
                                validator: (val) {
                                  if (val.isEmpty) return Constant.ErrorFields.MANDATORY;
                                  else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                    return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                  else if (val.length > Constant.LengthLimit.MAX_LENGTH_200)
                                    return Constant.ErrorFields.MAX_LENGTH_ERROR_200;
                                  else return null;
                                },
                                onChanged: (val) => businessLegalName = val,
                                textCapitalization: TextCapitalization.sentences,
                              )
                          ),
                          // DBA (Doing Business As) Name
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.BUSINESS_NAME
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return Constant.ErrorFields.MANDATORY;
                                } else if (val.length < Constant.LengthLimit
                                    .MIN_LENGTH_5)
                                  return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                else if (val.length > Constant.LengthLimit
                                    .MAX_LENGTH_200)
                                  return Constant.ErrorFields.MAX_LENGTH_ERROR_200;
                                else return null;
                              },
                              initialValue: businessName,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (val) => businessName = val,
                            ),
                          ),
                          // Registered Number
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels
                                        .REGISTERED_NUMBER,
                                  counterText: ""
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return null;
                                  else if (val.length < Constant.LengthLimit.MIN_LENGTH_11)
                                    return Constant.ErrorFields.MIN_LENGTH_ERROR_11;
                                  else return null;
                                },
                                onChanged: (val) => registeredNumber = val,
                                keyboardType: TextInputType.number,
                                maxLength: 11,
                                maxLengthEnforced: true
                              )
                          ),
                          // Mobile Number
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.MOBILE_NUMBER,
                                  counterText: ""
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return Constant.ErrorFields.MANDATORY;
                                  else if (val.length < 11)
                                    return Constant.ErrorFields.MIN_LENGTH_ERROR_11;
                                  else return null;
                                },
                                keyboardType: TextInputType.number,
                                onChanged: (val) => mobileNumber = val,
                                initialValue: mobileNumber,
                                maxLength: 11,
                                maxLengthEnforced: true
                              )
                          ),
                          // Registered Address
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.REGISTERED_ADDRESS
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return Constant.ErrorFields.MANDATORY;
                                else return null;
                              },
                              onChanged: (val) => registeredAddress = val,
                            ),
                          ),
                          // Physical Address
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.PHYSICAL_ADDRESS
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return Constant.ErrorFields.MANDATORY;
                                else return null;
                              },
                              onChanged: (val) => physicalAddress = val,
                            ),
                          ),
                          // Email address
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: Constant.FormLabels.EMAIL_ADDRESS
                              ),
                              onChanged: (val) => emailAddress = val,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          // Official website
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: Constant.FormLabels.OFFICIAL_WEBSITE
                              ),
                              onChanged: (val) => officialWebsite = val,
                            ),
                          ),
                          // Legal entity
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: new Column(
                                  children: [
                                    new Container(
                                      child: new DropdownButtonFormField(
                                        isExpanded: true,
                                        value: legalEntity,
                                        items: Constant.General.LEGAL_ENTITIES.map((itemValue) {
                                          return DropdownMenuItem(
                                              value: itemValue,
                                              child: new Text(itemValue)
                                          );
                                        }).toList(),
                                        onChanged: (String value) {
                                          if (value == Constant.General.LEGAL_ENTITIES.last) {
                                            setState(() {
                                              legalEntity = value;
                                              isLegalEntityOtherFieldVisible = true;
                                            });
                                          } else
                                            setState(() {
                                              isLegalEntityOtherFieldVisible = false;
                                              legalEntity = value;
                                              if (value == Constant.General
                                                  .LEGAL_ENTITIES[1] ||
                                                  value == Constant.General
                                                      .LEGAL_ENTITIES[2] ||
                                                  value == Constant.General
                                                      .LEGAL_ENTITIES[3]) {
                                                showPartnersFields = true;
                                              } else
                                                showPartnersFields = false;
                                            });
                                        },
                                        validator: (value) {
                                          if (value == null)
                                            return Constant.ErrorFields.MANDATORY;
                                          else return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: Constant.FormLabels.LEGAL_ENTITY
                                        ),
                                        iconEnabledColor: CupertinoColors
                                            .darkBackgroundGray,
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(new FocusNode()),
                                      ),
                                    ),
                                    Visibility(
                                        visible: isLegalEntityOtherFieldVisible,
                                        child: new Padding(
                                          padding: const EdgeInsets.only(
                                              top: Constant.Layout.textViewTop
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                labelText: Constant.General.OTHER
                                            ),
                                            validator: (val) {
                                              if (val.isEmpty)
                                                return Constant.ErrorFields.MANDATORY;
                                              else return null;
                                            },
                                            onChanged: (val) => legalEntityOther = val,
                                            textCapitalization: TextCapitalization
                                                .sentences,
                                          ),
                                        )
                                    )
                                  ]
                              )
                          ),
                          // NTN/CNIC
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels.NTN_CNIC_NUMBER
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return Constant.ErrorFields.MANDATORY;
                                  else if (val.length < Constant.LengthLimit.MIN_LENGTH_3)
                                    return Constant.ErrorFields.MIN_LENGTH_ERROR_3;
                                  else if (val.length > Constant.LengthLimit.MAX_LENGTH_13)
                                    return Constant.ErrorFields.MAX_LENGTH_ERROR_13;
                                  else return null;
                                },
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(13)
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (val) => ntnCnicNumber = val,
                                initialValue: ntnCnicNumber,
                              )
                          ),
                          // Name of Authorized Signatory
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels
                                        .NAME_OF_AUTHORIZED_SIGNATORY
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return Constant.ErrorFields.MANDATORY;
                                  else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                    return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                  else if (val.length > Constant.LengthLimit.MAX_LENGTH_100)
                                    return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                  else return null;
                                },
                                onChanged: (val) => authorizedSignatoryName = val,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.sentences,
                              )
                          ),
                          // Authorized Signatory CNIC
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: Constant.FormLabels
                                          .AUTHORIZED_SIGNATORY_CNIC
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return Constant.ErrorFields.MANDATORY;
                                    else if (val.length != Constant.LengthLimit.MAX_LENGTH_13)
                                      return Constant.ErrorFields.LENGTH_ERROR_13;
                                    else return null;
                                  },
                                  onChanged: (val) => authorizedSignatoryCnic = val,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(13)
                                  ]
                              )
                          ),
                          // Partner/Director information
                          Visibility(
                            visible: showPartnersFields,
                            child: Column(
                              children: [
                                // Partner/Director 1 info
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_1_NAME
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return Constant.ErrorFields.MANDATORY;
                                        else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                          return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_100)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                        else return null;
                                      },
                                      onChanged: (val) => director1Name = val,
                                      textCapitalization: TextCapitalization.sentences,
                                    )
                                ),
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_1_CNIC
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return Constant.ErrorFields.MANDATORY;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_13)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_13;
                                        else return null;
                                      },
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(13)
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) => director1Cnic = val,
                                    )
                                ),
                                // Partner/Director 2 info
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_2_NAME
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return Constant.ErrorFields.MANDATORY;
                                        else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                          return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_100)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                        else return null;
                                      },
                                      onChanged: (val) => director2Name = val,
                                      textCapitalization: TextCapitalization.sentences,
                                    )
                                ),
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_2_CNIC
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return Constant.ErrorFields.MANDATORY;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_13)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_13;
                                        else return null;
                                      },
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(13)
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) => director2Cnic = val,
                                    )
                                ),
                                // Partner/Director 3 info
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_3_NAME
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return null;
                                        else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                          return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_100)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                        else return null;
                                      },
                                      onChanged: (val) => director3Name = val,
                                      textCapitalization: TextCapitalization.sentences,
                                    )
                                ),
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_3_CNIC
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return null;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_13)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_13;
                                        else return null;
                                      },
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(13)
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) => director3Cnic = val,
                                    )
                                ),
                                // Partner/Director 4 info
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_4_NAME
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return null;
                                        else if (val.length < Constant.LengthLimit.MIN_LENGTH_5)
                                          return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_100)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                        else return null;
                                      },
                                      onChanged: (val) => director4Name = val,
                                      textCapitalization: TextCapitalization.sentences,
                                    )
                                ),
                                Padding(
                                    padding: Constant.PaddingDetails.textTopPadding,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: Constant.FormLabels.DIRECTOR_4_CNIC
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return null;
                                        else if (val.length > Constant.LengthLimit.MAX_LENGTH_13)
                                          return Constant.ErrorFields.MAX_LENGTH_ERROR_13;
                                        else return null;
                                      },
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(13)
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) => director4Cnic = val,
                                    )
                                )
                              ],
                            ),
                          ),
                          // Business Category
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: new Column(
                                  children: [
                                    new DropdownButtonFormField(
                                      isExpanded: true,
                                      value: businessCategory,
                                      items: Constant.General.BUSINESS_CATEGORIES.map((itemValue) {
                                        return DropdownMenuItem(
                                            value: itemValue,
                                            child: new Text(itemValue)
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        if (value == Constant.General.BUSINESS_CATEGORIES.last) {
                                          setState(() {
                                            isBusinessCategoryOtherFieldVisible = true;
                                            businessCategory = value;
                                          });
                                        } else {
                                          setState(() {
                                            isBusinessCategoryOtherFieldVisible = false;
                                            businessCategory = value;
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null)
                                          return Constant.ErrorFields.MANDATORY;
                                        else return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: Constant.FormLabels.BUSINESS_CATEGORY
                                      ),
                                      iconEnabledColor: CupertinoColors
                                          .darkBackgroundGray,
                                      onTap: () => FocusScope.of(context)
                                          .requestFocus(new FocusNode()),
                                    ),
                                    Visibility(
                                        visible: isBusinessCategoryOtherFieldVisible,
                                        child: new Padding(
                                          padding: Constant.PaddingDetails.textTopPadding,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                labelText: Constant.FormLabels.BUSINESS_CATEGORY
                                            ),
                                            validator: (val) {
                                              if (val.isEmpty)
                                                return Constant.ErrorFields.MANDATORY;
                                              else return null;
                                            },
                                            onChanged: (val) => businessCategoryOther = val,
                                            textCapitalization: TextCapitalization.sentences,
                                          ),
                                        )
                                    )
                                  ]
                              )
                          ),
                          // Office premises
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new Column(
                              children: [
                                new DropdownButtonFormField(
                                  isExpanded: true,
                                  value: officePremises,
                                  items: Constant.General.PREMISES_TYPES.map((item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: new Text(item)
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      officePremises = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: Constant.FormLabels.OFFICE_PREMISES
                                  ),
                                  onTap: () => FocusScope.of(context)
                                      .requestFocus(new FocusNode()),
                                )
                              ],
                            ),
                          ),
                          // Year at current location
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.YEARS_CURRENT_LOCATION
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return Constant.ErrorFields.MANDATORY;
                                else return null;
                              },
                              onChanged: (val) => yearsAtCurrentLocation = val,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          // Year at current business
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.YEARS_CURRENT_BUSINESS
                              ),
                              validator: (val) {
                                if (val.isEmpty)
                                  return Constant.ErrorFields.MANDATORY;
                                else return null;
                              },
                              onChanged: (val) => yearsAtCurrentBusiness = val,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          // Expected Monthly TurnOver
                          Padding(
                              padding: Constant.PaddingDetails.textTopPadding,
                              child: new TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels.EXPECTED_MONTHLY_TURNOVER,
                                    prefix: Text(Constant.General.PAK_RUPEE)
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return Constant.ErrorFields.MANDATORY;
                                  else return null;
                                },
                                onChanged: (val) => expectedMonthlyTurnOver = val,
                              )
                          ),
                          // Bank Name
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.BANK_NAME
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return Constant.ErrorFields.MANDATORY;
                                } else return null;
                              },
                              onChanged: (val) => bankName = val,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          // Branch Name
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.BRANCH_NAME
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return Constant.ErrorFields.MANDATORY;
                                } else return null;
                              },
                              onChanged: (val) => branchName = val,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          // Account title
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.ACCOUNT_TITLE
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return Constant.ErrorFields.MANDATORY;
                                } else if (val.length < Constant.LengthLimit.MIN_LENGTH_5) {
                                  return Constant.ErrorFields.MIN_LENGTH_ERROR_5;
                                } else if (val.length > Constant.LengthLimit.MAX_LENGTH_100) {
                                  return Constant.ErrorFields.MAX_LENGTH_ERROR_100;
                                } else return null;
                              },
                              onChanged: (val) => accountTitle = val,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          // Branch Code
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels.BRANCH_CODE
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return Constant.ErrorFields.MANDATORY;
                                  } else return null;
                                },
                                onChanged: (val) => branchCode = val
                            ),
                          ),
                          // Account Number
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: Constant.FormLabels.ACCOUNT_NUMBER
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return Constant.ErrorFields.MANDATORY;
                                } else if (val.length < Constant.LengthLimit.MIN_LENGTH_1) {
                                  return Constant.ErrorFields.MIN_LENGTH_ERROR_1;
                                } else return null;
                              },
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(10)
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (val) => accountNumber = val,
                            ),
                          ),
                          // IBan
                          Padding(
                            padding: Constant.PaddingDetails.textTopPadding,
                            child: new TextFormField(
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: Constant.FormLabels.IBAN
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return Constant.ErrorFields.MANDATORY;
                                  } else return null;
                                },
                                onChanged: (val) => iBan = val
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Foree Logo
                          new Container(
                            width: Constant.Layout.dp100,
                            height: Constant.Layout.dp50,
                            child: new Image.network(Constant.AssetsPath.FOREE_LOGO),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Button save
                              Padding(
                                padding: const EdgeInsets.only(left: Constant.Layout.dp5),
                                child: new ElevatedButton(
                                  onPressed: () {
                                    if (mobileNumber == null || mobileNumber.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                "Mobile number cannot be empty"
                                              )
                                          )
                                      );
                                    } else {
                                        rawResult.setDate(date);
                                        // logo is missing.
                                        rawResult.setBusinessLegalName(businessLegalName);
                                        rawResult.setBusinessName(businessName);
                                        rawResult.setRegisteredNumber(registeredNumber);
                                        rawResult.setMobileNumber(mobileNumber);
                                        rawResult.setRegisteredAddress(registeredAddress);
                                        rawResult.setPhysicalAddress(physicalAddress);
                                        rawResult.setEmailAddress(emailAddress);
                                        rawResult.setOfficialWebSite(officialWebsite);
                                        rawResult.setLegalEntity(legalEntity);
                                        rawResult.setLegalEntityOther(legalEntityOther);
                                        rawResult.setNtnCnicNumber(ntnCnicNumber);
                                        rawResult.setAuthorizedSignatoryName(authorizedSignatoryName);
                                        rawResult.setAuthorizedSignatoryCnic(authorizedSignatoryCnic);
                                        rawResult.setBusinessCategory(businessCategory);
                                        rawResult.setOfficePremises(officePremises);
                                        rawResult.setYearAtCurrentLocation(yearsAtCurrentLocation);
                                        rawResult.setYearAtCurrentBusiness(yearsAtCurrentBusiness);
                                        rawResult.setExpectedMonthlyTurnOver(expectedMonthlyTurnOver);
                                        rawResult.setBankName(bankName);
                                        rawResult.setBranchName(branchName);
                                        rawResult.setAccountTitle(accountTitle);
                                        rawResult.setBranchCode(branchCode);
                                        rawResult.setAccountNumber(accountNumber);
                                        rawResult.setIban(iBan);
                                        // Implement api call to send data to foree server.
                                    }
                                  },
                                  child: new Text(Constant.ButtonTags.SAVE)
                                ),
                              ),
                              // Button Next
                              Padding(
                                padding: const EdgeInsets.only(left: Constant.Layout.dp5),
                                child: new ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      rawResult.setDate(date);
                                      rawResult.setBusinessLegalName(businessLegalName);
                                      rawResult.setBusinessName(businessName);
                                      rawResult.setRegisteredNumber(registeredNumber);
                                      rawResult.setMobileNumber(mobileNumber);
                                      rawResult.setRegisteredAddress(registeredAddress);
                                      rawResult.setPhysicalAddress(physicalAddress);
                                      rawResult.setEmailAddress(emailAddress);
                                      rawResult.setOfficialWebSite(officialWebsite);
                                      rawResult.setLegalEntity(legalEntity);
                                      rawResult.setLegalEntityOther(legalEntityOther);
                                      rawResult.setNtnCnicNumber(ntnCnicNumber);
                                      rawResult.setAuthorizedSignatoryName(authorizedSignatoryName);
                                      rawResult.setAuthorizedSignatoryCnic(authorizedSignatoryCnic);
                                      rawResult.setBusinessCategory(businessCategory);
                                      rawResult.setOfficePremises(officePremises);
                                      rawResult.setYearAtCurrentLocation(yearsAtCurrentLocation);
                                      rawResult.setYearAtCurrentBusiness(yearsAtCurrentBusiness);
                                      rawResult.setExpectedMonthlyTurnOver(expectedMonthlyTurnOver);
                                      rawResult.setBankName(bankName);
                                      rawResult.setBranchName(branchName);
                                      rawResult.setAccountTitle(accountTitle);
                                      rawResult.setBranchCode(branchCode);
                                      rawResult.setAccountNumber(accountNumber);
                                      rawResult.setIban(iBan);
                                      Navigator.push(_formKey.currentContext,
                                          new MaterialPageRoute(
                                              builder: (context) => new
                                              BusinessDocuments(
                                                title: Constant.PageTitle
                                                  .BUSINESS_DOCUMENTS,
                                                data: rawResult, logo: logo,)
                                          )
                                      );
                                    }
                                  },
                                  child: new Text(Constant.ButtonTags.NEXT)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}