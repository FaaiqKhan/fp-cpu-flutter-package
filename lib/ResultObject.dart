import 'dart:convert';
import 'dart:core';

class ResultObject {
  String businessLogo;
  String businessCode;
  String businessName;
  String businessLegalName;
  String emailAddress;
  String mobileNumber;
  String landLineNumber;
  PaymentMethod paymentMethod;
  BusinessAdditionalDetail additionalBusinessDetail;
  String officeWebsite;
  String businessNtnNumber;
  String legalEntity;
  String otherLegalEntity;
  String businessCategory;
  String expectedTurnOver;
  String authPersonName;
  String authPersonCnic;
  String establishmentWithStatus;
  BankAccountDetail bankAccountDetails;
  BusinessDocument businessDocument;
  AddressDetails addressDetails;
  String i;

  ResultObject(
      this.businessLogo, this.businessCode, this.businessName,
      this.businessLegalName, this.emailAddress, this.mobileNumber,
      this.landLineNumber, this.officeWebsite, this.businessNtnNumber,
      this.legalEntity, this.otherLegalEntity, this.businessCategory,
      this.expectedTurnOver, this.authPersonName, this.authPersonCnic,
      this.establishmentWithStatus, this.paymentMethod,
      this.addressDetails, this.additionalBusinessDetail,
      this.bankAccountDetails, this.businessDocument);

  void setBusinessLogo(String val) {
    this.businessLogo = val;
  }

  void setBusinessCode(String val) {
    this.businessCode = val;
  }

  void setBusinessName(String val) {
    this.businessName = val;
  }

  void setBusinessLegalName(String val) {
    this.businessLegalName = val;
  }

  void setEmailAddress(String val) {
    this.emailAddress = val;
  }

  void setMobileNumber(String val) {
    this.mobileNumber = val;
  }

  void setLandLineNumber(String val) {
    this.landLineNumber = val;
  }

  void setPaymentMethod(PaymentMethod val) {
    this.paymentMethod = val;
  }

  void setAdditionalBusinessDetails(BusinessAdditionalDetail val) {
    this.additionalBusinessDetail = val;
  }

  void setOfficeWebSite(String val) {
    this.officeWebsite = val;
  }

  void setBusinessNtn(String val) {
    this.businessNtnNumber = val;
  }

  void setLegalEntity(String val) {
    this.legalEntity = val;
  }

  void setOtherLegalEntity(String val) {
    this.otherLegalEntity = val;
  }

  void setBusinessCategory(String val) {
    this.businessCategory = val;
  }

  void setExpectedMonthlyTurnOver(String val) {
    this.expectedTurnOver = val;
  }

  void setAuthPersonName(String val) {
    this.authPersonName = val;
  }

  void setAuthPersonCnic(String val) {
    this.authPersonCnic = val;
  }

  void setEstablishmentWithStatus(String val) {
    this.establishmentWithStatus = val;
  }

  void setBankAccountDetails(BankAccountDetail val) {
    this.bankAccountDetails = val;
  }

  void setBusinessDocument(BusinessDocument val) {
    this.businessDocument = val;
  }

  void setAddressDetails(AddressDetails val) {
    this.addressDetails = val;
  }

  // temp
  void setI(String val) {
    this.i = val;
  }

  String getI() {
    return this.i;
  }

  factory ResultObject.fromJson(dynamic json) {
    return ResultObject(
      json['business_logo'] as String, json['business_code'] as String,
      json['business_name'] as String, json['business_legal_name'] as String,
      json['email_address'] as String, json['mobile_number'] as String,
      json['land_line_number'] as String,
      json['official_website'] as String, json['business_ntn_number'] as String,
      json['legal_entity'] as String, json['other_legal_entity'] as String,
      json['business_category'] as String,
      json['expected_monthly_turnover'] as String,
      json['auth_person_name'] as String, json['auth_person_cnic'] as String,
      json['establishment_with_status'] as String,
      PaymentMethod.fromJson(json['payment_method']),
      AddressDetails.fromJson(json['address_Details']),
      BusinessAdditionalDetail.fromJson(json['additional_business_details']),
      BankAccountDetail.fromJson(json['bank_account_details']),
      BusinessDocument.fromJson(json['business_documents'])
    );
  }

  Map<String, dynamic> toJson() => {
    'business_logo': this.businessLogo,
    'business_code': this.businessCode,
    'business_name': this.businessName,
    'business_legal_name': this.businessLegalName,
    'email_address': this.emailAddress,
    'mobile_number': this.mobileNumber,
    'land_line_number': this.landLineNumber,
    'official_website': this.officeWebsite,
    'business_ntn_number': this.businessNtnNumber,
    'legal_entity': this.legalEntity,
    'other_legal_entity': this.otherLegalEntity,
    'business_category': this.businessCategory,
    'expected_monthly_turnover': this.expectedTurnOver,
    'auth_person_name': this.authPersonName,
    'auth_person_cnic': this.authPersonCnic,
    'establishment_with_status': this.establishmentWithStatus,
    'payment_method': json.encode(this.paymentMethod.toJson()),
    'additional_business_details': json.encode(this.additionalBusinessDetail.toJson()),
    'bank_account_details': json.encode(this.bankAccountDetails),
    'business_documents': json.encode(this.businessDocument),
    'address_Details': json.encode(this.addressDetails.toJson())
  };
}

class PaymentMethod {
  String method;

  PaymentMethod(this.method);

  void setMethod(String val) {
    this.method = val;
  }

  factory PaymentMethod.fromJson(dynamic json) {
    return PaymentMethod(json['method'] as String);
  }

  Map<String, dynamic> toJson() => {
    'method': this.method
  };
}

class BusinessAdditionalDetail {
  String businessOwnerName;
  String businessOwnerCnic;
  String officePremises;
  String yearAtCurrentLocation;
  String yearAtCurrentBusiness;

  BusinessAdditionalDetail(this.businessOwnerName, this.businessOwnerCnic,
      this.officePremises, this.yearAtCurrentLocation,
      this.yearAtCurrentBusiness);

  void setBusinessOwnerName(String val) {
    this.businessOwnerName = val;
  }

  void setBusinessOwnerCnic(String val) {
    this.businessOwnerCnic = val;
  }

  void setOfficePremises(String val) {
    this.officePremises = val;
  }

  void setYearAtCurrentLocation(String val) {
    this.yearAtCurrentLocation = val;
  }

  void setYearAtCurrentBusiness(String val) {
    this.yearAtCurrentBusiness = val;
  }

  factory BusinessAdditionalDetail.fromJson(dynamic json) {
    return BusinessAdditionalDetail(
        json['business_owner_name'] as String,
        json['business_owner_cnic'] as String,
        json['office_premises'] as String,
        json['year_at_current_location'] as String,
        json['year_at_current_business'] as String
    );
  }

  Map<String, dynamic> toJson() => {
    'business_owner_name': this.businessOwnerName,
    'business_owner_cnic': this.businessOwnerCnic,
    'office_premises': this.officePremises,
    'year_at_current_location': this.yearAtCurrentLocation,
    'year_at_current_business': this.yearAtCurrentBusiness,
  };
}

class AddressDetails {
  String officeAddress;
  String stateProvince;
  String city;
  String postalCode;
  String country;

  void setOfficeAddress(String val) {
    this.officeAddress = val;
  }

  void setStateProvince(String val) {
    this.stateProvince = val;
  }

  void setCity(String val) {
    this.city = val;
  }

  void setPostalCode(String val) {
    this.postalCode = val;
  }

  void setCountry(String val) {
    this.country = val;
  }

  AddressDetails(this.officeAddress, this.stateProvince, this.city,
      this.postalCode, this.country);

  factory AddressDetails.fromJson(dynamic json) {
    return AddressDetails(
        json['official_address'] as String,
        json['state_province'] as String, json['city'] as String,
        json['postal_code'] as String, json['country'] as String);
  }

  Map<String, dynamic> toJson() => {
    'official_address': this.officeAddress,
    'state_province': this.stateProvince,
    'city': this.city,
    'postal_code': this.postalCode,
    'country': this.country
  };
}

class BankAccountDetail {
  String titleOfAccount;
  String accountNumber;
  String iban;
  String bankName;
  String branchName;
  String branchCode;

  void setTitleOfAccount(String val) {
    this.titleOfAccount = val;
  }

  void setAccountNumber(String val) {
    this.accountNumber = val;
  }

  void setIban(String val) {
    this.iban = val;
  }

  void setBankName(String val) {
    this.bankName = val;
  }

  void setBranchName(String val) {
    this.branchName = val;
  }

  void setBranchCode(String val) {
    this.branchCode = val;
  }

  BankAccountDetail(this.titleOfAccount, this.accountNumber, this.iban,
      this.bankName, this.branchName, this.branchCode);

  factory BankAccountDetail.fromJson(dynamic json) {
    return BankAccountDetail(
      json['title_Of_Account'] as String, json['account_number'] as String,
      json['iban'] as String, json['bank_name'] as String,
      json['branch_name'] as String, json['branch_code'] as String);
  }

  Map<String, dynamic> toJson() => {
    'title_Of_Account': this.titleOfAccount,
    'account_number': this.accountNumber,
    'iban': this.iban,
    'bank_name': this.bankName,
    'branch_name': this.branchName,
    'branch_code': this.branchCode
  };
}

class BusinessDocument {
  String cnic;
  String mCertificate;
  String ntn;
  String rCertificate;
  String utilityBill;

  void setCnic(String path) {
    this.cnic = path;
  }

  void setMCertificate(String path) {
    this.mCertificate = path;
  }

  void setNtn(String path) {
    this.ntn = path;
  }

  void setRCertificate(String path) {
    this.rCertificate = path;
  }

  void setUtilityBill(String path) {
    this.utilityBill = path;
  }

  BusinessDocument(this.cnic, this.mCertificate, this.ntn, this.rCertificate,
      this.utilityBill);

  factory BusinessDocument.fromJson(dynamic json) {
    return BusinessDocument(
        json['cnic'] as String, json['mCertificate'] as String,
        json['ntn'] as String, json['rCertificate'] as String,
        json['utilityBill'] as String);
  }

  Map<String, dynamic> toJson() => {
    'cnic': this.cnic,
    'mCertificate': this.mCertificate,
    'ntn': this.ntn,
    'rCertificate': this.rCertificate,
    'utilityBill': this.utilityBill
  };
}