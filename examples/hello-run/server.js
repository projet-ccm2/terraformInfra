import http from "node:http";

const port = process.env.PORT || 8080;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({ ok: true, service: "hello-run" }));
});

server.listen(port, () => {
  // eslint-disable-next-line no-console
  console.log(`listening on :${port}`);
});


