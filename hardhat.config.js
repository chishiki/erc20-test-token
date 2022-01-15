const dotenv = require('dotenv');
dotenv.config();

const ROPSTEN_ENDPOINT = process.env.ROPSTEN_ENDPOINT;
const ROPSTEN_ACCOUNT = process.env.ROPSTEN_ACCOUNT;

require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.10",
  networks: {
    ropsten: {
      url: `${ROPSTEN_ENDPOINT}`,
      accounts: [`${ROPSTEN_ACCOUNT}`]
    }
  }
};
