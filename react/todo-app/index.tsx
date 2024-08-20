import { React, ReactDOM } from "./deps.ts";
import App1 from "./src/todo-app-1.tsx";
import App2 from "./src/todo-app-2.tsx";

const app1 = ReactDOM.createRoot(document.getElementById("app1"));
const app2 = ReactDOM.createRoot(document.getElementById("app2"));

app1.render(
  <React.StrictMode>
    <App1 />
  </React.StrictMode>,
);

app2.render(
  <React.StrictMode>
    <App2 />
  </React.StrictMode>,
);
