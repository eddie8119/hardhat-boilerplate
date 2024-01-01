require("@nomicfoundation/hardhat-toolbox");

// The next line is part of the sample project, you don't need it in your
// project. It imports a Hardhat task definition, that can be used for
// testing the frontend.
require("./tasks/faucet");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",

  networks: {
    local: {
      url: "http://localhost:8545",
      accounts: [
        "0xea6c44ac03bff858b476bba40716402b03e41b8e97e276d1baec7c37d42484a0",
      ],
    },
  },
};
