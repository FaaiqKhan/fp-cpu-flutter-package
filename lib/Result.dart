import 'dart:convert';
import 'dart:core';

class Result {
  String businessCode;
  String businessLogo;
  String date;
  String businessLegalName;
  String businessName;
  String registeredNumber;
  String mobileNumber;
  String registeredAddress;
  String physicalAddress;
  String officialWebsite;
  String legalEntity;
  String legalEntityOther;
  String ntnCnicNumber;
  String authorizedSignatoryName;
  String authorizedSignatoryCnic;
  String businessCategory;
  String officePremises;
  String yearAtCurrentLocation;
  String yearAtCurrentBusiness;
  String expectedMonthlyTurnOver;
  String bankName;
  String branchName;
  String accountTitle;
  String branchCode;
  String accountNumber;
  String iBan;
  PartnerDetails partnerDetails;

  Result(this.businessCode, this.businessLogo, this.date, this.businessLegalName,
      this.businessName, this.registeredNumber, this.mobileNumber,
      this.registeredAddress, this.physicalAddress, this.officialWebsite,
      this.legalEntity, this.legalEntityOther, this.ntnCnicNumber,
      this.authorizedSignatoryName, this.authorizedSignatoryCnic,
      this.businessCategory, this.officePremises, this.yearAtCurrentLocation,
      this.yearAtCurrentBusiness, this.expectedMonthlyTurnOver, this.bankName,
      this.branchName, this.accountTitle, this.branchCode, this.accountNumber,
      this.iBan, this.partnerDetails);

  void setBusinessCode(String val) {
    this.businessCode = val;
  }

  void setBusinessLogo(String val) {
    this.businessLogo = val;
  }

  void setDate(String val) {
    this.date = val;
  }

  void setBusinessLegalName(String val) {
    this.businessLegalName = val;
  }

  void setBusinessName(String val) {
    this.businessName = val;
  }

  void setRegisteredNumber(String val) {
    this.registeredNumber = val;
  }

  void setMobileNumber(String val) {
    this.mobileNumber = val;
  }

  void setRegisteredAddress(String val) {
    this.registeredAddress = val;
  }

  void setPhysicalAddress(String val) {
    this.physicalAddress = val;
  }

  void setOfficialWebSite(String val) {
    this.officialWebsite = val;
  }

  void setLegalEntity(String val) {
    this.legalEntity = val;
  }

  void setLegalEntityOther(String val) {
    this.legalEntityOther = val;
  }

  void setNtnCnicNumber(String val) {
    this.ntnCnicNumber = val;
  }

  void setAuthorizedSignatoryName(String val) {
    this.authorizedSignatoryName = val;
  }

  void setAuthorizedSignatoryCnic(String val) {
    this.authorizedSignatoryCnic = val;
  }

  void setBusinessCategory(String val) {
    this.businessCategory = val;
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

  void setExpectedMonthlyTurnOver(String val) {
    this.expectedMonthlyTurnOver = val;
  }

  void setBankName(String val) {
    this.bankName = val;
  }

  void setBranchName(String val) {
    this.branchName = val;
  }

  void setAccountTitle(String val) {
    this.accountTitle = val;
  }

  void setBranchCode(String val) {
    this.branchCode = val;
  }

  void setAccountNumber(String val) {
    this.accountNumber = val;
  }

  void setIban(String val) {
    this.iBan = val;
  }

  void setPartnerDetails(PartnerDetails val) {
    this.partnerDetails = val;
  }

  factory Result.fromJson(dynamic json) {
    return Result(
      json['business_code'] as String, json['business_logo'] as String,
      json['date'] as String, json['business_legal_name'] as String,
      json['business_name'] as String, json['registered_number'] as String,
      json['mobile_number'] as String, json['registered_address'] as String,
      json['physical_address'] as String, json['official_website'] as String,
      json['legal_entity'] as String, json['legal_entity_other'] as String,
      json['ntn_cnic_number'] as String,
      json['name_of_authorized_signatory'] as String,
      json['authorized_signatory_cnic'] as String,
      json['business_category'] as String, json['office_premises'] as String,
      json['years_at_current_location'] as String,
      json['years_at_current_business'] as String,
      json['expected_monthly_turnover'] as String, json['bank_name'] as String,
      json['branch_name'] as String, json['account_title'] as String,
      json['branch_code'] as String, json['account_number'] as String,
      json['iban'] as String,
      PartnerDetails.fromJson(json['partners_details'])
    );
  }

  Map<String, dynamic> toJson() => {
    'business_code': this.businessCode,
    'business_logo': this.businessLogo,
    'date': this.date,
    'business_legal_name': this.businessLegalName,
    'business_name': this.businessName,
    'registered_number': this.registeredNumber,
    'mobile_number': this.mobileNumber,
    'registered_address': this.registeredAddress,
    'physical_address': this.physicalAddress,
    'official_website': this.officialWebsite,
    'legal_entity': this.legalEntity,
    'ntn_cnic_number': this.ntnCnicNumber,
    'authorized_signatory_name': this.authorizedSignatoryName,
    'authorized_signatory_cnic': this.authorizedSignatoryCnic,
    'business_category': this.businessCategory,
    'office_premises': this.officePremises,
    'years_at_current_location': this.yearAtCurrentLocation,
    'years_at_current_business': this.yearAtCurrentBusiness,
    'expected_monthly_turnover': this.expectedMonthlyTurnOver,
    'bank_name': this.bankName,
    'branch_name': this.branchName,
    'account_title': this.accountTitle,
    'branch_code': this.branchCode,
    'account_number': this.accountNumber,
    'iban': this.iBan,
    'partners_details': json.encode(this.partnerDetails.toJson())
  };
}

class PartnerDetails {
  String partnerName1, partnerCnic1, partnerName2, partnerCnic2;
  String partnerName3, partnerCnic3, partnerName4, partnerCnic4;

  PartnerDetails(
      this.partnerName1, this.partnerCnic1,
      this.partnerName2, this.partnerCnic2,
      this.partnerName3, this.partnerCnic3,
      this.partnerName4, this.partnerCnic4
  );

  void setPartnerName1(String val) {
    this.partnerName1 = val;
  }

  void setPartnerCnic1(String val) {
    this.partnerCnic1 = val;
  }

  void setPartnerName2(String val) {
    this.partnerName1 = val;
  }

  void setPartnerCnic2(String val) {
    this.partnerCnic1 = val;
  }

  void setPartnerName3(String val) {
    this.partnerName1 = val;
  }

  void setPartnerCnic3(String val) {
    this.partnerCnic1 = val;
  }

  void setPartnerName4(String val) {
    this.partnerName1 = val;
  }

  void setPartnerCnic4(String val) {
    this.partnerCnic1 = val;
  }

  factory PartnerDetails.fromJson(dynamic json) {
    return PartnerDetails(
      json['partner_name_1'] as String, json['partner_cnic_1'] as String,
      json['partner_name_2'] as String, json['partner_cnic_2'] as String,
      json['partner_name_3'] as String, json['partner_cnic_3'] as String,
      json['partner_name_4'] as String, json['partner_cnic_4'] as String
    );
  }

  Map<String, dynamic> toJson() => {
    'partner_name_1': this.partnerName1,
    'partner_cnic_1': this.partnerCnic1,
    'partner_name_2': this.partnerName2,
    'partner_cnic_2': this.partnerCnic2,
    'partner_name_3': this.partnerName3,
    'partner_cnic_3': this.partnerCnic3,
    'partner_name_4': this.partnerName4,
    'partner_cnic_4': this.partnerCnic4
  };
}