const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const app = express();
const { getURI, mintTo, setGasParameters, getTokenIDsByOwner } = require("./service");


app.use(bodyParser.json());
app.use(cors({
  origin: '*'
}));

const DEFAULT_GAS_LIMIT = '8000000'
const DEFAULT_GAS_PRICE = '1000000000';

// Poorly named endpoints. Get it together man
// should be getMetaDataById eg
app.get("/getURI/:nftID", async (req, res) => {
  const nftID = req.params.nftID;
  try {
    const metaDataString = await getURI(nftID);
    const metaData = JSON.parse(metaDataString);
    res.json({ metaData });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



app.post("/mintNFT", cors(), async (req, res) => {
  // const {gasLimit, gasPrice} = await setGasParameters()
  const options = {
    gasLimit : DEFAULT_GAS_LIMIT,
    gasPrice : DEFAULT_GAS_PRICE
  }

  const {address, nftName, imageCID, audioCID } = req.body;


  try {
    const metaData = await mintTo(address,nftName, imageCID, audioCID)//.send(options);
    res.json({ metaData });
  } catch (error) {
    res.status(500).json({ error: error.message });
    console.log(error.message)
  }
});

app.get("/ownedTokens/:ownerAddress", async (req, res) => {
  const ownerAddress = req.params.ownerAddress;
  try {
      const tokenIds = await getTokenIDsByOwner(ownerAddress);
      res.json({ tokenIds });
  } catch (error) {
      res.status(500).json({ error: error.message });
  }
});


app.listen(3000, () => {
  console.log("Server running on port 3000");
});