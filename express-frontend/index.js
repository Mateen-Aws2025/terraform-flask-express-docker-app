import express from "express";

const app = express();
const PORT = 3000;

/* Serve static frontend */
app.use(express.static("public"));

/* Health check for ALB */
app.get("/", (req, res) => {
  res.status(200).send("OK");
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Frontend running on port ${PORT}`);
});
