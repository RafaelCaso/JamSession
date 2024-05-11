# Jam Session
> an unrehearsed or improvised jazz or rock perfomance (Collins English Dictionary)
---

### What is it?
Combine NFTs to make songs. Individual NFTs consist of an instrument and a 2-bar phrase in a genre selected by the user.
This can then be combined with other NFTs with matching genres to make a song


#### What is it going to be?
The Music of Collaboration and Jam Tokens. Users can create their own music and upload to Jam Session. Collaborators can then submit samples of their own accompaniment. Users can select their favorite and mint a song. Jam tokens can be awared for submissions.

---

# Dymension Ecosystem
By leveraging and building on Dymension's infrastructure, Jam Session would be able to minimize costs allowing the target audience (the crypto-curious) to explore the metaverse. 
The introduction of Jam tokens incentivizes participation. Paired with decentralized governance, this opens the door for Jam Session events where the community can stake tokens to participate in voting for best collaborations (Jams), best solos, and best performances just to name a few. 
The metaverse itself can also be shaped by users who want more audacious guitars, more smoky venues in the jazz district, or more drum solos! 
This is where I see the greatest potential for something like Jam Session, a product that is easily accessible for the average person, and a fun, impactful reason to participate. 

# Vision / The Product:
Metaverse set in a fictional city where users can explore different musical venues and listen to submissions.
Different neighborhoods in the city represent musical genres and will have stores that sell appropriately stylized instruments and offer lessons in that genre.
Each neighborhood will be heavily stylized for that genre and will be loaded with easter eggs for the users to find. These should make the user feel like they're in-the-know for the particular neighborhood.
This world offers two main use cases 
1. a videogame style world where people can explore at their leisure while listening to music and enjoying the sights.
2. provide a way for real-world musicians across the planet to collaborate and create something completely unique, a digital jam session.

Number 2 is more central in my eyes, but by combining these two ideas, we can emulate real life in a much more meaningful way, where many people will be 'tourists' enjoying the local scene while contributing 
to people who live and breathe music every day of their lives.

![inspiration](https://github.com/RafaelCaso/jam-session/blob/main/assets/img/005EntranceDoor.png?raw=true) 

#### Challenges:
Storage - Storing audio is obviously an issue. My solution was to use IPFS and I started with 2-bar phrases which is very limiting in what you can accomplish musically.
However, I was surprised that the largest file was smaller than I anticipated (91KiB). A 4-bar phrase is easily achievable and provides a much larger opportunity for musicality (much more than just twice as much as a 2-bar phrase)
My working idea is to then chain together NFTs so 2 audio files equalling 8-bars which is, again, an order of magnitude larger.


#### Last Thought:
The music industry has a long history of nefarious business dealings and exploitative practices. Blockchain technology allows a musician to retain ownership of their music.



---






### Tech Stack:
I used Godot game engine to create the frontend exported as HTML5. It connects to an Express backend which uses Web3 and Ethers to communicate with the Smart Contract.
Using the JAM token, NFTs can be purchased that contain an audio and image CID in their metadata which is then used to retreive data from IPFS.



### Try it yourself
1. git clone <repo-url>

2. Host IPFS node locally http://127.0.0.1:8080

3. (Deploy Smart Contract)
truffle migrate --network development

4. Go to service.js in project folder and replace const contractAddress and myAddress

5. Host API locally http://127.0.0.1:3000

6. Host HTML5 locally

---




~About the creator:
Adrian has been a musician since he was 8 years old. Beginning with piano, he was fortunate to receive lessons from Mr. White in Columbus, Ohio, who introduced him to jazz. Adrian picked up the guitar when he was 14, and bass shortly after, and quickly started the obligatory highschool rock and roll band. In College, he studied Music Theory at The Ohio State University where he was again fortunate to work with local musicians Michael Zarilli, Dominic Carioti, and Boki who all contributed greatly to his growth as a musician. After several years as a working jazz musician, Adrian went on to other things in his life but still retains his love of music, particularly the piano.~