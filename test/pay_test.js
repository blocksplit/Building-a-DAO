var PaymentProtocol = artifacts.require("PaymentProtocol");
var DAO = artifacts.require("DAO");

contract("PaymentProtocol", async(accounts) => {
    it("should pay and transer", async() => {

        var iPayment = await PaymentProtocol.deployed();

        iPayment.pay(accounts[1], {value: 350});
        iPayment.claim({from: accounts[1]});
        
    })
})
