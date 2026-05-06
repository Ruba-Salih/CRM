const path = require("path");
const fs = require("fs");
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const cors = require("cors");
const crmRoutes = require('./routes/crmRoutes');
const socialMediaRoutes = require('./routes/socialMediaRoutes');
const videoGenerationRoutes = require('./routes/videoGenerationRoute');
require('dotenv').config({ path: path.resolve(__dirname, './.env') });

const app = express();
app.use(express.json({ limit: '50mb' }));  // Increase from default 100kb to 50MB
app.use(express.urlencoded({ limit: '50mb', extended: true }));

app.use(cors());


const server = http.createServer(app);

const io = new Server(server, {
  cors: { origin: "*" }
});

// Track connected clients
global.aiClient = null;

io.on("connection", (socket) => {
  console.log("AI connected:", socket.id);

  socket.on("register_ai_client", (data) => {
    if (data.token !== process.env.AI_TOKEN) return;
    aiClient = socket;
    console.log("AI client registered completely:", socket.id);
  });

  socket.on("disconnect", () => {
    if (aiClient?.id === socket.id) {
      aiClient = null;
    }
    console.log("AI CLIENT disconnected:", socket.id); 
  });
});


// Routes
// CRM Routes
app.use('/api', crmRoutes);
// Social Media Routes
app.use('/social-media', socialMediaRoutes);
// Video Generation Routes
app.use('/video-generation', videoGenerationRoutes);

app.get("/test",(req,res)=>{
    res.send("Be happy !")
})
const PORT = process.env.PORT || 5577;
server.listen(PORT, () => console.log(`VPS AI Bridge Running on port ${PORT}`));
