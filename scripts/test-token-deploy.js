const hre = require("hardhat");

async function main() {

  const TestToken = await hre.ethers.getContractFactory("TestToken");
  const testToken = await TestToken.deploy("TestToken", "TEST", 18);
  
  await testToken.deployed();

  console.log("TestToken deployed to:", testToken.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
