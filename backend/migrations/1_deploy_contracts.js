const NFT = artifacts.require("NFT");

module.exports = function (deployer) {
  const _name = "JamSession"; // Replace with your desired name
  const _symbol = "JAM"; // Replace with your desired symbol
  deployer.deploy(NFT, _name, _symbol);
};
