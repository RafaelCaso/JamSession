// const ipfsEndpoint = "http://localhost:8080/ipfs/ip4/127.0.0.1/tcp/8080";

// const { cid } = await client.add("Hello World!");

// SpaceMarineCID: "QmSsEQF2HzVQzNvdquxs9CgBBz8iaPZA71WYJg3LwxiUUS"
// LaserFireCID: "QmWj9tFP8NJj1PyjzeGPjTQQT4CjgPHkQChca9zJC2VYiZ"
// MetalGuitarCID: "QmPwPFR5vxhiWACXMC3Vrz6Rf473Jeu4whh25bdCRaXWNX"
// MetalGuitarRiffCID: "QmSRy8taccJ3hhdiDxHAcm8w1mTLuVHwoansS89GLChpZi"
// MetalBassCID: "QmVSYfkGZ2HPhGiPEhZP4gbRDgUtSruzxv7JH9jeheeT5b"
// MetalBassRiffCID: "QmRF5QaWLw3D5z7AXFQcFbGxLsFJutNkybedhiNLkeShfA"
const metadata = {
  name: "Metal Bass",
  imageURI: "QmVSYfkGZ2HPhGiPEhZP4gbRDgUtSruzxv7JH9jeheeT5b",
  audioURI: "QmRF5QaWLw3D5z7AXFQcFbGxLsFJutNkybedhiNLkeShfA",
};

document.getElementById("nftName").innerText = metadata.name;

const ipfsGateway = "http://localhost:8080/ipfs/";
const imageUrl = ipfsGateway + metadata.imageURI;
const audioUrl = ipfsGateway + metadata.audioURI;

document.getElementById("nftImage").src = imageUrl;

if (metadata.audioURI) {
  document.getElementById("nftAudio").src = audioUrl;
} else {
  document.getElementById("nftAudio").style.display = "none";
}
