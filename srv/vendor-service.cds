using {sap.capire.vendor as my} from '../db/schema';

service VendorService @(requires : 'user') {
    entity Orders  as projection on my.Orders;
    entity Vendors as projection on my.Vendors;
}
