const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TestToken", function () {
  
  it("Example test", async function () {
    
    const TestToken = await ethers.getContractFactory("TestToken");
    const testToken = await TestToken.deploy("TestToken", "TEST", 18);
    await testToken.deployed();

    // example test
    // expect(await testToken.someFunction()).to.equal("SomeValue");

  });

});
