using {
  Currency,
  managed,
  sap
} from '@sap/cds/common';

namespace sap.capire.vendor;

entity Orders : managed {
  key ID        : Integer;
      summary   : localized String(300);
      vendor    : Association to Vendors;
      netAmount : Decimal(9, 2);
      currency  : Currency;
}

entity Vendors : managed {
  key ID     : Integer;
      name   : String(300);
      orders : Association to many Orders
                 on orders.vendor = $self;
}
