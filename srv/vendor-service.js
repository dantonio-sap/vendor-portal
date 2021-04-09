const cds = require('@sap/cds')

module.exports = function (){

  this.before('READ','Orders', async req => {
    console.log("userInfo: " + JSON.stringify(req.user));

    req.query.where('vendor_ID=',req.user.attr.vendor)
  })
}
