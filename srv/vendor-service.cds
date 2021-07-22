using {sap.capire.vendor as my} from '../db/schema';

service VendorService @(requires : 'authenticated-user') {
    entity Orders  as projection on my.Orders;
    entity Vendors as projection on my.Vendors;
}

//---------------------//
// ORDERS
//---------------------//
annotate VendorService.Orders with @odata.draft.enabled;

annotate VendorService.Orders with @(restrict : [
    {
        grant : 'READ',
        where : 'vendor_ID = $user.vendor'
    },
    {
        grant : 'WRITE',
        to    : 'user',
        where : 'vendor_ID = $user.vendor'
    }
]);

annotate VendorService.Orders with @(
    UI : {LineItem : [
        {Value : ID},
        {Value : summary},
        {
            $Type : 'UI.DataField',
            Value : vendor.name
        },
        {Value : netAmount},
        {
            Value : currency.code,
            Label : ' '
        }
    ]},
    UI : {
        HeaderInfo                           : {
            TypeName       : 'Order',
            TypeNamePlural : 'Orders',
            TypeImageUrl   : 'sap-icon://sales-order',
            Title          : {Value : summary}
        },

        HeaderFacets                         : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#HeaderGeneralInformation'
        }],

        FieldGroup #HeaderGeneralInformation : {Data : [{Value : ID},

        ]}
    },
    UI : {
        FieldGroup #OrderDetails : {Data : [
            {Value : vendor_ID},
            {Value : netAmount},
            {Value : currency_code}
        ]},
        Facets                   : [{
            $Type  : 'UI.CollectionFacet',
            Label  : 'Order',
            ID     : 'OrderDetails',
            Facets : [{
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Details',
                Target : '@UI.FieldGroup#OrderDetails'
            }, ]
        }]
    }
);

//---------------------//
// VENDORS
//---------------------//
annotate VendorService.Vendors with @odata.draft.enabled;

annotate VendorService.Vendors with @(restrict : [
    {
        grant : 'READ',
        where : 'ID = $user.vendor'
    },
    {
        grant : 'WRITE',
        to    : 'admin',
        where : 'ID = $user.vendor'
    }
]);

annotate VendorService.Vendors with @(UI : {LineItem : [
    {Value : ID},
    {Value : name}
]});

annotate VendorService.Vendors with @(UI : {
    HeaderInfo                           : {
        TypeName       : 'Vendor',
        TypeNamePlural : 'Vendors',
        TypeImageUrl   : 'sap-icon://factory',
        Title          : {Value : name}
    },

    HeaderFacets                         : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#HeaderGeneralInformation'
    }],

    FieldGroup #HeaderGeneralInformation : {Data : [{Value : ID},

    ]}
});
