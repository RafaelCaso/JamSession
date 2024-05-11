const contractAddress = "0x513849cA4C41d0bb5C22afA0391f7347EEa3aC0b";
const myAddress = "0x71FDd6Bb8F1432e12B426CC9eCD3fF55Fac3A90C";
const {abi} = require("./contractABI.js")
const { Web3 } = require("web3");

const web3 = new Web3("http://0.0.0.0:7545");
const contract = new web3.eth.Contract(abi, contractAddress);


// named incorrectly, this should be getTokenMetaData eg
async function getURI(nftID) {
  const metaData = await contract.methods.tokenURI(nftID).call();
  return metaData;
}

async function mintTo(address, nftName, imgCID, audioCID) {
  const metaData = await contract._methods
    .mintTo(nftName, imgCID, audioCID)
    .send({ from: address, gas: 2000000 });
    return metaData
}

// get all tokens belonging to wallet address
async function getTokenIDsByOwner(ownerAddress) {
  const tokenIdsBigInt = await contract.methods.getOwnedTokenIDs(ownerAddress).call();
  const tokenIds = tokenIdsBigInt.map(id => Number(id));
  return tokenIds;
}



async function getGasLimit() {
  const dummyRecipient = "0x1234567890123456789012345678901234567890";
  const dummyImgCID = "QmPlaceholderImgCID12341209u103gb1093b01b2gas3"
  const dummyAudioCID = "QmPlaceholderAudioCIDsb2h4091n313gh13s1n03gas3"
  const dummyName = "Placeholder NFT Name"
  const gasLimit = await web3.eth.estimateGas({to :contractAddress, data : contract.methods.mintTo(dummyRecipient, dummyName, dummyImgCID, dummyAudioCID, ).encodeABI()});
  // return gasLimit;
  return 2000000
}

async function getGasPrice() {
  const gasPrice = await web3.eth.getGasPrice();
  // return gasPrice;
  return 20000000000;
}

async function setGasParameters() {
  const gasLimit = await getGasLimit();
  const gasPrice = await getGasPrice();

  await contract.methods.setGasParameters(gasLimit, gasPrice).send({from : myAddress})
}

module.exports = { mintTo, getURI, setGasParameters, getTokenIDsByOwner };
