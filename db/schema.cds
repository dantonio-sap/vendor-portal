using {
  Currency,
  managed,
  sap
} from '@sap/cds/common';

namespace sap.capire.vendor;

entity Orders : managed {
  key ID        : Integer                @title : 'Order ID';
      summary   : localized String(300)  @title : 'Summary';
      vendor    : Association to Vendors @title : 'Vendor';
      netAmount : Decimal(9, 2)          @title : 'Order Amount';
      currency  : Currency;
}

@cds.odata.valuelist
entity Vendors : managed {
  key ID     : String(3)  @title : 'Vendor ID';
      name   : String(300)@title : 'Vendor Name';
      orders : Association to many Orders
                 on orders.vendor = $self;
}

type Currencies : Association to sap.common.Currencies;
