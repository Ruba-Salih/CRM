const io = require("socket.io-client");
const axios = require("axios");

const socket = io("https://n8n-helper.afro-tech.net", {
  transports: ["polling", "websocket"],
});

socket.on("connect", () => {
  console.log("Connected to VPS");

  socket.emit("register_ai_client", {
    token: "CR7Ra3tKIedrY1ya2AD9xa3Ds7tstYBwoXEJcfXLeirPR9CYP25eaDL4gCcSjo9H"
  });
});


socket.on("connect_error", (err) => {
  console.log("❌ connect_error:", err.message);
});

socket.on("error", (err) => {
  console.log("❌ socket error:", err);
});

socket.on("disconnect", (reason) => {
  console.log("⚠️ disconnected:", reason);
});

socket.on("reconnect_attempt", (attempt) => {
  console.log("🔄 reconnect attempt:", attempt);
});

socket.on("reconnect_failed", () => {
  console.log("❌ reconnect failed");
});

// Handle incoming AI requests from VPS
socket.on("request_to_ai", async (data) => {
  console.log("📩 Received request for AI:", data.requestId);

  try {
    // 1. استخراج الـ requestId وحذفه من البيانات المرسلة للأولاما
    const { requestId, ...ollamaData } = data;

    // 2. إضافة اسم الموديل (تأكد أن هذا الموديل محمل عندك في Ollama)
    ollamaData.model = "qwen2.5:7b";

    // 3. إرسال الطلب
    console.log("🤖 Calling Ollama...");
    const qwenRes = await axios.post("http://localhost:11434/v1/chat/completions", ollamaData);

    // الرد الكامل الذي يدعمه LangChain في n8n موجود داخل .data حصراً
    const answer = qwenRes.data;
    
    // سنطبع الرد الكامل (بدون أخطاء دائرية)
    console.log("✅ Full AI Response Data:", JSON.stringify(answer, null, 2));

    // 4. إرسال الرد للجسر
    socket.emit("response_from_ai", {
      requestId: requestId,
      answer: answer
    });

  } catch (e) {
    console.error("❌ Ollama Error:", e.response ? e.response.data : e.message);
    socket.emit("response_from_ai", {
      requestId: data.requestId,
      answer: "Error: " + (e.response ? JSON.stringify(e.response.data) : e.message)
    });
  }
});
