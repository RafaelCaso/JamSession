extends Node
#####################
# Script name needs to be changed to UserData #
#####################

# wallet address used for minting and retrieving NFTs
var address : String

# variables to pass to NFT Post Request
var selected_nft_img
var selected_nft_audio
# variable for grouping instruments and genre when accessing minted NFT
var selected_nft_name

# variables for previewing NFT before buying
var sample_instrument
var sample_genre
