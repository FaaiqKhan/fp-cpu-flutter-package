import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorFields {
  static const String MANDATORY = "This field is mandatory";
  static const String MIN_LENGTH_ERROR_1 = "Minimum input length is 1";
  static const String MIN_LENGTH_ERROR_3 = "Minimum input length is 3";
  static const String MIN_LENGTH_ERROR_5 = "Minimum input length is 5";
  static const String MIN_LENGTH_ERROR_11 = "Minimum input length is 11";
  static const String LENGTH_ERROR_13 = "Length should be of 13 characters";
  static const String MAX_LENGTH_ERROR_13 = "Maximum input length is 13";
  static const String MAX_LENGTH_ERROR_14 = "Maximum input length is 14";
  static const String MAX_LENGTH_ERROR_50 = "Maximum input length is 50";
  static const String MAX_LENGTH_ERROR_100 = "Maximum input length is 100";
  static const String MAX_LENGTH_ERROR_200 = "Maximum input length is 200";
  static const String MAX_LENGTH_ERROR_500 = "Maximum input length is 500";
}

class LengthLimit {
  static const int MIN_LENGTH_1 = 1;
  static const int MIN_LENGTH_3 = 3;
  static const int MIN_LENGTH_5 = 5;
  static const int MIN_LENGTH_11 = 11;
  static const int MAX_LENGTH_13 = 13;
  static const int MAX_LENGTH_14 = 14;
  static const int MAX_LENGTH_50 = 50;
  static const int MAX_LENGTH_100 = 100;
  static const int MAX_LENGTH_200 = 200;
  static const int MAX_LENGTH_500 = 500;
}

class SelectionHint{
  static const String SELECT = "Please select";
  static const String LEGAL_ENTITY = "Legal Entity";
  static const String BUSINESS_CATEGORY = "Business Category";
  static const String EXPECTED_MONTHLY_TURNOVER = "Expected Monthly Turnover";
  static const String STATE_PROVINCE = "State/Province";
  static const String CITY = "City";
  static const String COUNTRY = "Country";
  static const String BRANCH_CODE = "Branch Code";
  static const String ANY_RELATIONSHIP_AS_BUSINESS_ESTABLISHMENT = "Any relationship as Business Establishment";
  static const String PAYMENT_METHOD = "Payment Method";
  static const String OFFICE_PREMISES = "Office Premises";
}

class BankAccountDetailsHints {
  static const String ACCOUNT_TITLE = "Title of Account";
  static const String ACCOUNT_NUMBER = "Account Number";
  static const String IBAN = "IBAN";
  static const String BANK_NAME = "Bank Name";
  static const String BRANCH_NAME = "Branch Name";
  static const String BRANCH_CODE = "Branch Code";
}

class AdditionalBusinessDetailsHints {
  static const String NAME_BUSINESS_OWNER = "Name of Business Owner";
  static const String CNIC_BUSINESS_OWNER = "CNIC of Business Owner";
  static const String OFFICIAL_ADDRESS = "Official Address";
  static const String STATE_PROVINCE = "State/Province";
  static const String CITY = "City";
  static const String POSTAL_CODE = "Postal Code";
  static const String COUNTRY = "Country";
  static const String YEARS_CURRENT_LOCATION = "Years at current location";
  static const String YEARS_CURRENT_BUSINESS = "Year at current business";
}

class BusinessSignUpHits {
  static const String BUSINESS_NAME = "DBA (Doing Business As) Name";
  static const String EMAIL_ADDRESS = "Email address";
  static const String MOBILE_NUMBER = "Mobile Number";
  static const String PASSWORD = "Password";
  static const String BUSINESS_LEGAL_NAME = "Business Legal Name";
}

class BusinessDetailsHits {
  static const String BUSINESS_CODE = "(Foree Id) Business Code";
  static const String BUSINESS_NAME = "Business Name";
  static const String BUSINESS_LEGAL_NAME = "Business Legal Name";
  static const String LAND_LINE_NUMBER = "Landline Number";
  static const String OFFICIAL_WEBSITE = "Official Website";
  static const String NTN_CNIC_NUMBER = "NTN / CNIC Number";
  static const String OTHER = "Please Specify";
  static const String OTHER_BUSINESS_CATEGORY = "What category does your business fall under?";
  static const String NAME_OF_AUTHORIZED_SIGNATORY = "Name of Authorized Signatory";
  static const String AUTHORIZED_SIGNATORY_CNIC = "Authorized Signatory CNIC";
  static const String DIRECTOR_1 = "Name of Partner/Director 1";
  static const String DIRECTOR_2 = "Name of Partner/Director 2";
  static const String DIRECTOR_3 = "Name of Partner/Director 3";
  static const String DIRECTOR_4 = "Name of Partner/Director 4";

}

class SharedPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
    // return json.decode(prefs.getString(key));
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

String generateId() {
  return new Random().nextInt(99999).toString();
}

class BankStatus {
  static const String ACTIVE = "Active";
  static const String INACTIVE = "Inactive";
}

class RequiredDocs {
  static const String CNIC = "Valid CNIC";
  static const String M_CERTIFICATE = "Account Maintenance Certificate from Bank mentioning the name of Individual/Proprietor and length of relationship where settlement needs to be done";
  static const String NTN = "NTN";
  static const String R_CERTIFICATE = "Registration Certificate/Permit/License from competent authorities";
  static const String UTILITY_BILL = "Last month of utility bills of registered address";

  static const String cnic = "cnic";
  static const String mc = "mCertificate";
  static const String ntn = "ntn";
  static const String rc = "rCertificate";
  static const String ub = "utilityBill";

  static const Map<int, String> list = { 0: cnic, 1: mc, 2: ntn, 3: rc, 4: ub };

  static const String btnCNIC = "CNIC";
  static const String btnM_CERTIFICATE = "Maintenance Certificate";
  static const String btnNTN = "NTN";
  static const String btnR_CERTIFICATE = "Registration Certificate";
  static const String btnUTILITY_BILL = "Utility Bill";

  static const String logoText = "Business Logo";
  static const String logoDescription = "Biller can upload their Business logo. This logo will be reflected in Foree App alongside the business name";

  static const String C = "CNIC";
  static const String MC = "Account Maintenance Certificate";
  static const String NT = "NTN";
  static const String RC = "Registration Certificate";
  static const String UB = "Utility bills";
}

class Layout {
  static const double textViewTop = 15.0;
  static const double left = 10.0;
  static const double right = 10.0;
  static const double top = 10.0;
  static const double uploadLogoW = 140.0;
  static const double uploadLogoH = 140.0;
  static const double dp5 = 5.0;
  static const double dp10 = 10.0;
  static const double ZERO = 0.0;
  static const double dp100 = 100.0;
  static const double dp50 = 50.0;
}

class InitValue {
  static const String StringNan = "Faaiq Ali Khan";
  static const String numberNan = "4220124260387";
  static const String p = "154";
}

class PagesDetails {
  static const String AccountDetails = "Provide Account Details";
}

class ButtonTags {
  static const String SAVE = "SAVE";
  static const String NEXT = "NEXT";
}

class General {
  static const String UPLOAD = "Tap to Upload";
  static const Map<int, String> PROVINCE = {
    1 : "Sindh",
    2 : "Punjab",
    3 : "Balochistan",
    4 : "Khyber Pakhtunkhwa",
    5 : "Gilgit-Baltistan",
    6 : "Azad Kashmir",
    7 : "Islamabad-Federal Territory"
  };
  static const String COUNTRY = "Pakistan";
  static const List<String> BUSINESS_CATEGORIES = [
    "Variety Store",
    "General Store",
    "Bus Lines",
    "Taxicab&Limousines",
    "Utilities Gas, Water etc.",
    "Drug Stores and Pharmacies",
    "Education",
    "All Other MCC"
  ];
  static const List<String> EXPECTED_MONTHLY_TURNOVER = [
    "Below 500,000",
    "Equal or Above 500,000"
  ];
  static const String OTHER = "Please Specify";
  static const List<String> LEGAL_ENTITIES = [
    "Sole proprietorship",
    "Partnership",
    "Private Limited Company",
    "Public Limited Company",
    "Trust",
    "NGO",
    "Club",
    "Others"
  ];
  static const List<String> PREMISES_TYPES = ["Owned", "Rented", "Leased"];
  static const String PAK_RUPEE = "PKR ";
  static const String API_KEY_REQUIRED = "API key is required";
}

class PageTitle {
  static const String BUSINESS_SIGN_UP = "Business Sign Up";
  static const String BUSINESS_DOCUMENTS = "Business Documents";
}

class FormLabels {
  static const String DATE = "Date";
  static const String BUSINESS_LEGAL_NAME = "Business Legal Name";
  static const String BUSINESS_NAME = "DBA (Doing Business As) Name";
  static const String REGISTERED_NUMBER = "Registered Number";
  static const String MOBILE_NUMBER = "Mobile Number";
  static const String REGISTERED_ADDRESS = "Registered Address";
  static const String PHYSICAL_ADDRESS = "Physical Address";
  static const String EMAIL_ADDRESS = "Email Address";
  static const String OFFICIAL_WEBSITE = "Official Website";
  static const String LEGAL_ENTITY = "Legal Entity";
  static const String NTN_CNIC_NUMBER = "NTN/CNIC Number";
  static const String NAME_OF_AUTHORIZED_SIGNATORY = "Name of Authorized Signatory";
  static const String AUTHORIZED_SIGNATORY_CNIC = "Authorized Signatory CNIC";
  static const String DIRECTOR_1_NAME = "Name of Partner/Director 1";
  static const String DIRECTOR_2_NAME = "Name of Partner/Director 2";
  static const String DIRECTOR_3_NAME = "Name of Partner/Director 3";
  static const String DIRECTOR_4_NAME = "Name of Partner/Director 4";
  static const String DIRECTOR_1_CNIC = "CNIC of Partner/Director 1";
  static const String DIRECTOR_2_CNIC = "CNIC of Partner/Director 2";
  static const String DIRECTOR_3_CNIC = "CNIC of Partner/Director 3";
  static const String DIRECTOR_4_CNIC = "CNIC of Partner/Director 4";
  static const String BUSINESS_CATEGORY = "Business Category";
  static const String OFFICE_PREMISES = "Office Premises";
  static const String YEARS_CURRENT_LOCATION = "Years at current location";
  static const String YEARS_CURRENT_BUSINESS = "Year at current business";
  static const String EXPECTED_MONTHLY_TURNOVER = "Expected Monthly Turnover";
  static const String BANK_NAME = "Bank Name";
  static const String BRANCH_NAME = "Branch Name";
  static const String ACCOUNT_TITLE = "Title of Account";
  static const String BRANCH_CODE = "Branch Code";
  static const String ACCOUNT_NUMBER = "Account Number";
  static const String IBAN = "IBAN";
}

class PaddingDetails {
  static const textTopPadding =  EdgeInsets.only(top: 15.0);
}

class FieldKeys {
  static const String BUSINESS_NAME = "businessName";
  static const String CNIC = "cnic";
  static const String MOBILE_NUMBER = "mobileNumber";
  static const String LOGO = "logo";
  static const String BANK_ID = "bank_id";
  static const String BANK_SHORT_NAME = "bank_short_name";
}

class AssetsPath {
  static const String BANKS = "assets/banks";
  static const String RESULT = "assets/result";
  static const String RESULT_OBJECT = "assets/resultObject";
  static const String FOREE_LOGO = "https://foree.co/assets/img/logo.png";
}